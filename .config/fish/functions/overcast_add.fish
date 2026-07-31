# Uploads audio files to Overcast (https://overcast.fm/uploads, requires Premium).
# Works by scraping the presigned S3 form from the uploads page, posting the
# file to S3, then notifying Overcast. Based on
# https://github.com/mootcycle/overcast-upload — there is no official API.
#
# http(s) arguments are downloaded with yt-dlp first (audio extracted to mp3,
# with chapters/thumbnail/title embedded) before being uploaded like any
# other file. The video description isn't embedded — it can be forced into a
# real ID3 COMM frame (ffmpeg's mp3 muxer otherwise only writes it as a
# nonstandard TXXX frame), but Overcast doesn't show that field for
# manually-uploaded episodes either, so it's not worth the extra dependency.
#
# Password is stored in the macOS login keychain. To set it up once:
#   security add-generic-password -a stefan@vanburen.xyz -s overcast.fm -w 'YOUR_PASSWORD'
function overcast_add --description 'Uploads audio files to Overcast.'
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
        echo "overcast_add: login failed or the upload form changed" >&2
        rm -f $cookies
        return 1
    end

    set --local status_code 0
    for file in $argv
        set --local tmp_dir ''
        if string match --quiet --regex '^https?://' -- $file
            if not command --query yt-dlp
                echo "overcast_add: yt-dlp not found, can't download $file" >&2
                set status_code 1
                continue
            end

            set tmp_dir (mktemp -d)
            echo "Downloading $file"
            yt-dlp --no-warnings --no-playlist \
                -x --audio-format mp3 --audio-quality 0 \
                --embed-metadata --embed-chapters --embed-thumbnail \
                -o "$tmp_dir/%(title)s.%(ext)s" \
                -- $file
            or begin
                echo "overcast_add: yt-dlp failed for $file" >&2
                rm -rf $tmp_dir
                set status_code 1
                continue
            end

            set --local downloaded $tmp_dir/*
            if test (count $downloaded) -ne 1
                echo "overcast_add: expected exactly one file from yt-dlp for $file" >&2
                rm -rf $tmp_dir
                set status_code 1
                continue
            end
            set file $downloaded[1]
        end

        set --local key $key_prefix(path basename $file)
        set --local mime audio/mpeg
        if contains -- (path extension $file | string lower) .m4a .mp4
            set mime audio/mp4
        end
        echo "Uploading $file"
        # curl hides its progress meter when the response body goes to the
        # terminal, so send S3's (empty, 204) response to /dev/null to get it.
        curl --fail --location --compressed --progress-bar --output /dev/null \
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

        if test -n "$tmp_dir"
            rm -rf $tmp_dir
        end
    end

    rm -f $cookies
    return $status_code
end

# Prefer .mp3 files, but still allow completing to any file.
complete -c overcast_add -k -a '(__fish_complete_suffix .mp3)'
