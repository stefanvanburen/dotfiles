# https://github.com/feedbin/feedbin-api/blob/master/content/subscriptions.md#create-subscription
#
# Password is stored in the macOS login keychain. To set it up once:
#   security add-generic-password -a stefan@vanburen.xyz -s feedbin-api -w 'YOUR_PASSWORD'
function add_to_feedbin --description 'Adds URLs to Feedbin. URLs can be either the fully-qualified feed URL, or the URL to the website.'
    set --local user stefan@vanburen.xyz
    set --local pass (security find-generic-password -s feedbin-api -w)
    set --local feedbin_url https://api.feedbin.com/v2/subscriptions.json
    for url in $argv
        curl --user "$user:$pass" --json (jo feed_url=$url) $feedbin_url
    end
end
