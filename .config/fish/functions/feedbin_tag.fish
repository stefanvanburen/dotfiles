# https://github.com/feedbin/feedbin-api/blob/master/content/taggings.md
#
# Feedbin's tags have no existence of their own: a tag is created by tagging a
# feed with it, and disappears when the last feed carrying it is untagged. So
# there is nothing to create here, only taggings to add and remove.
#
# Renaming and deleting a tag everywhere is a different endpoint, /v2/tags.json.
#
# Password is stored in the macOS login keychain. To set it up once:
#   security add-generic-password -a stefan@vanburen.xyz -s feedbin-api -w 'YOUR_PASSWORD'
function feedbin_tag --description 'Tags and untags Feedbin feeds.'
    argparse --exclusive remove,list h/help r/remove l/list 't/tag=+' -- $argv
    or return 1

    if set --query _flag_help
        echo "Usage: feedbin_tag [--remove] --tag <name> [--tag <name>]... <url, title or feed id>..."
        echo "       feedbin_tag --list [<url, title or feed id>...]"
        echo
        echo "Feeds are matched against your subscriptions by feed ID, exact feed or"
        echo "site URL, then by substring of the URL or title. Tagging is idempotent."
        echo "--list with no feeds lists every tag and how many feeds carry it."
        return 0
    end

    set --local user stefan@vanburen.xyz
    set --local pass (security find-generic-password -s feedbin-api -w)
    set --local taggings_url https://api.feedbin.com/v2/taggings.json

    if not set --query _flag_list
        if not set --query _flag_tag
            echo "feedbin_tag: no tags given (see --help)" >&2
            return 1
        else if test (count $argv) -eq 0
            echo "feedbin_tag: no feeds given (see --help)" >&2
            return 1
        end
    end

    set --local subscriptions (curl --fail --silent --show-error --compressed \
        --user "$user:$pass" \
        https://api.feedbin.com/v2/subscriptions.json)
    or return 1

    set --local taggings (curl --fail --silent --show-error --compressed \
        --user "$user:$pass" \
        $taggings_url)
    or return 1

    if set --query _flag_list; and test (count $argv) -eq 0
        echo $taggings | jq --raw-output '
            group_by(.name) | sort_by(-length)
            | .[] | "\(length)\t\(.[0].name)"'
        return 0
    end

    # Resolve everything up front so a typo doesn't half-apply the batch.
    set --local targets
    set --local unresolved 0
    for arg in $argv
        set --local matches (echo $subscriptions | jq --raw-output --arg q $arg '
            def exact: map(select((.feed_id | tostring) == $q or .feed_url == $q or .site_url == $q));
            def fuzzy: map(select(
                [.feed_url, .site_url, .title] | map(. // "") | join(" ")
                | ascii_downcase | contains($q | ascii_downcase)));
            (if (exact | length) > 0 then exact else fuzzy end)
            | .[] | "\(.feed_id)\t\(.title)"')

        switch (count $matches)
            case 0
                echo "feedbin_tag: no subscription matches '$arg'" >&2
                set unresolved 1
            case 1
                set --append targets $matches[1]
            case '*'
                echo "feedbin_tag: '$arg' is ambiguous:" >&2
                printf '  %s\n' $matches >&2
                set unresolved 1
        end
    end

    if test $unresolved -ne 0
        return 1
    end

    if set --query _flag_list
        for target in $targets
            set --local fields (string split \t -- $target)
            echo $taggings | jq --raw-output --argjson id $fields[1] --arg title $fields[2] '
                map(select(.feed_id == $id) | .name) | sort
                | "\($title)\t\(if length > 0 then join(", ") else "(untagged)" end)"'
        end
        return 0
    end

    set --local status_code 0
    for target in $targets
        set --local fields (string split \t -- $target)
        set --local feed_id $fields[1]
        set --local title $fields[2]

        for tag in $_flag_tag
            set --local existing (echo $taggings | jq --raw-output --argjson id $feed_id --arg name $tag '
                map(select(.feed_id == $id and .name == $name)) | .[0].id // empty')

            if set --query _flag_remove
                if test -z "$existing"
                    echo "Not tagged $tag: $title"
                    continue
                end
                curl --fail --silent --show-error --output /dev/null \
                    --request DELETE \
                    --user "$user:$pass" \
                    https://api.feedbin.com/v2/taggings/$existing.json
                or begin
                    set status_code 1
                    continue
                end
                echo "Untagged $tag: $title"
            else
                if test -n "$existing"
                    echo "Already tagged $tag: $title"
                    continue
                end
                curl --fail --silent --show-error --output /dev/null \
                    --user "$user:$pass" \
                    --json (jo feed_id=$feed_id name=$tag) \
                    $taggings_url
                or begin
                    set status_code 1
                    continue
                end
                echo "Tagged $tag: $title"
            end
        end
    end

    return $status_code
end

complete -c feedbin_tag -s t -l tag -r -d 'Tag to apply (repeatable)'
complete -c feedbin_tag -s r -l remove -d 'Remove the tag instead of adding it'
complete -c feedbin_tag -s l -l list -d 'List tags, or the tags on the given feeds'
complete -c feedbin_tag -s h -l help -d 'Show usage'
