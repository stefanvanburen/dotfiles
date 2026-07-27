# Mutes feeds in Feedbin. A muted feed stays subscribed, but drops out of the
# sidebar and stops contributing to unread counts.
#
# There is no public API for this — the v2 API only lets you rename a
# subscription. The web app uses `PATCH /subscriptions/<feed_id>/toggle_mute`,
# which needs a session cookie plus a CSRF token, so this logs in by scraping
# the login form the same way overcast_add does.
#
# That route toggles rather than sets, so we read the current state first. The
# logged-in homepage embeds the full list as `"muted_feeds":[...]` in its user
# data blob, which is the only place feed-level mute state is exposed.
#
# Mute *filters* (Feedbin's "mute words") are a different feature, and those do
# have an API: POST /v2/actions.json with action_type=mute.
#
# Password is stored in the macOS login keychain. To set it up once:
#   security add-generic-password -a stefan@vanburen.xyz -s feedbin-api -w 'YOUR_PASSWORD'
function feedbin_mute --description 'Mutes or unmutes Feedbin feeds.'
    argparse --exclusive unmute,list h/help u/unmute l/list -- $argv
    or return 1

    if set --query _flag_help
        echo "Usage: feedbin_mute [--unmute] <url, title or feed id>..."
        echo "       feedbin_mute --list"
        echo
        echo "Feeds are matched against your subscriptions by feed ID, exact feed or"
        echo "site URL, then by substring of the URL or title. Muting is idempotent."
        return 0
    end

    if not set --query _flag_list; and test (count $argv) -eq 0
        echo "feedbin_mute: no feeds given (see --help)" >&2
        return 1
    end

    set --local user stefan@vanburen.xyz
    set --local pass (security find-generic-password -s feedbin-api -w)

    set --local subscriptions (curl --fail --silent --show-error --compressed \
        --user "$user:$pass" \
        https://api.feedbin.com/v2/subscriptions.json)
    or return 1

    # Log in to the web app: the mute state and the toggle both live there.
    set --local cookies (mktemp)
    set --local login_page (curl --fail --silent --show-error --compressed \
        --cookie-jar $cookies \
        https://feedbin.com/login)
    or begin
        rm -f $cookies
        return 1
    end

    set --local token (string match --regex --groups-only 'name="authenticity_token" value="([^"]+)' -- $login_page)
    if test -z "$token"
        echo "feedbin_mute: could not find the login form's authenticity token" >&2
        rm -f $cookies
        return 1
    end

    # A successful login 302s to the homepage; don't follow it, it's 8MB.
    curl --fail --silent --show-error --output /dev/null \
        --cookie $cookies --cookie-jar $cookies \
        --data-urlencode email=$user \
        --data-urlencode password=$pass \
        --data-urlencode authenticity_token=$token \
        https://feedbin.com/sessions
    or begin
        rm -f $cookies
        return 1
    end

    # Rails hands the CSRF token back in a cookie for its own JS to use.
    set --local csrf (string match --regex --groups-only '\s+XSRF-TOKEN\s+(\S+)' < $cookies |
        string unescape --style=url)
    if test -z "$csrf"
        echo "feedbin_mute: could not find the CSRF token after logging in" >&2
        rm -f $cookies
        return 1
    end

    set --local muted_raw (curl --fail --silent --show-error --compressed --cookie $cookies https://feedbin.com/ |
        string match --regex --groups-only '"muted_feeds":\[([0-9,]*)\]')
    if test $status -ne 0
        echo "feedbin_mute: could not read the current mute state" >&2
        rm -f $cookies
        return 1
    end
    set --local muted_ids (string split --no-empty , -- "$muted_raw")

    if set --query _flag_list
        rm -f $cookies
        echo $subscriptions | jq --raw-output --argjson muted "[$muted_raw]" '
            map(select(.feed_id as $id | $muted | index($id)))
            | sort_by(.title | ascii_downcase)
            | .[] | "\(.feed_id)\t\(.title)"'
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
                echo "feedbin_mute: no subscription matches '$arg'" >&2
                set unresolved 1
            case 1
                set --append targets $matches[1]
            case '*'
                echo "feedbin_mute: '$arg' is ambiguous:" >&2
                printf '  %s\n' $matches >&2
                set unresolved 1
        end
    end

    if test $unresolved -ne 0
        rm -f $cookies
        return 1
    end

    set --local status_code 0
    for target in $targets
        set --local fields (string split \t -- $target)
        set --local feed_id $fields[1]
        set --local title $fields[2]

        if set --query _flag_unmute
            if not contains -- $feed_id $muted_ids
                echo "Already unmuted: $title"
                continue
            end
        else if contains -- $feed_id $muted_ids
            echo "Already muted: $title"
            continue
        end

        curl --fail --silent --show-error --output /dev/null \
            --request PATCH \
            --header "X-CSRF-Token: $csrf" \
            --cookie $cookies \
            https://feedbin.com/subscriptions/$feed_id/toggle_mute
        or begin
            set status_code 1
            continue
        end

        if set --query _flag_unmute
            echo "Unmuted: $title"
        else
            echo "Muted: $title"
        end
    end

    rm -f $cookies
    return $status_code
end

complete -c feedbin_mute -s u -l unmute -d 'Unmute instead of mute'
complete -c feedbin_mute -s l -l list -d 'List currently muted feeds'
complete -c feedbin_mute -s h -l help -d 'Show usage'
