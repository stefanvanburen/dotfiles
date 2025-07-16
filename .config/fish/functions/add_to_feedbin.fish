# https://github.com/feedbin/feedbin-api/blob/master/content/subscriptions.md#create-subscription
function add_to_feedbin --description 'Adds URLs to Feedbin. URLs can be either the fully-qualified feed URL, or the URL to the website.'
    set --local user (op item get 'Feedbin' --fields username)
    set --local pass (op item get 'Feedbin' --fields password --reveal)
    set --local feedbin_url https://api.feedbin.com/v2/subscriptions.json
    for url in $argv
        curl --user "$user:$pass" --json (jo feed_url=$url) $feedbin_url
    end
end
