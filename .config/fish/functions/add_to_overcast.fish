# Uploads audio files to Overcast (https://overcast.fm/uploads, requires Premium).
# Works by scraping the presigned S3 form from the uploads page, posting the
# file to S3, then notifying Overcast. Based on
# https://github.com/mootcycle/overcast-upload — there is no official API.
#
# Password is stored in the macOS login keychain. To set it up once:
#   security add-generic-password -a stefan@vanburen.xyz -s overcast.fm -w 'YOUR_PASSWORD'
function add_to_overcast --description 'Uploads audio files to Overcast.'
    set --local user stefan@vanburen.xyz
    set --local pass (security find-generic-password -s overcast.fm -w)
    set --local cookies (mktemp)

    set --local page (curl --fail --silent --show-error --location --compressed \
        --data-urlencode then=uploads \
        --data-urlencode email=$user \
        --data-urlencode password=$pass \
        --cookie-jar $cookies \
        https://overcast.fm/login)
    or begin
        rm -f $cookies
        return 1
    end

    set --local policy (string match --regex --groups-only 'name="policy" value="([^"]+)' -- $page)
    set --local signature (string match --regex --groups-only 'name="signature" value="([^"]+)' -- $page)
    set --local access_key (string match --regex --groups-only 'name="AWSAccessKeyId" value="([^"]+)' -- $page)
    set --local key_prefix (string match --regex --groups-only 'data-key-prefix="([^"]+)' -- $page)

    if test -z "$policy" -o -z "$signature" -o -z "$access_key" -o -z "$key_prefix"
        echo "add_to_overcast: login failed or the upload form changed" >&2
        rm -f $cookies
        return 1
    end

    set --local status_code 0
    for file in $argv
        set --local key $key_prefix(path basename $file)
        set --local mime audio/mpeg
        if contains -- (path extension $file | string lower) .m4a .mp4
            set mime audio/mp4
        end
        echo "Uploading $file"
        curl --fail --location --compressed \
            --form bucket=uploads-overcast \
            --form key=$key \
            --form AWSAccessKeyId=$access_key \
            --form acl=authenticated-read \
            --form policy=$policy \
            --form signature=$signature \
            --form Content-Type=$mime \
            --form file=@$file \
            --cookie $cookies \
            https://uploads-overcast.s3.amazonaws.com/
        and curl --fail --silent --show-error --location --compressed \
            --form key=$key \
            --cookie $cookies \
            https://overcast.fm/podcasts/upload_succeeded >/dev/null
        and echo "Uploaded $file"
        or set status_code 1
    end

    rm -f $cookies
    return $status_code
end

# Prefer .mp3 files, but still allow completing to any file.
complete -c add_to_overcast -k -a '(__fish_complete_suffix .mp3)'
