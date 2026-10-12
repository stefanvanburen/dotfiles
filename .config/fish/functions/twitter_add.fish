function twitter_add --description 'Subscribes to Twitter/X users in Feedbin via Stream Spigot, tagged twitter.'
    for arg in $argv
        set --local username (string replace --regex '^(https?://)?(www\.|mobile\.)?(x|twitter)\.com/' '' -- $arg \
            | string replace --regex '[/?#].*$' '' \
            | string trim --left --chars @)
        set --local feed_url "https://www.streamspigot.com/tweeter-feeder/feed?usernames=$username"

        # feedbin_add prints the new subscription; an existing one comes back
        # as a redirect without it, so fall back to matching the feed URL.
        set --local feed_id (feedbin_add $feed_url | jq --raw-output '.feed_id // empty' 2>/dev/null)
        if test -z "$feed_id"
            set feed_id $feed_url
        end
        feedbin_tag --tag twitter $feed_id
    end
end
