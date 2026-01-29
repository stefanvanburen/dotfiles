function pr-reviews --description 'Get GitHub PR reviews from the last N days'
    # Parse arguments
    set -l days 1

    for arg in $argv
        if string match -qr '^\d+$' -- $arg
            set days $arg
        else
            echo (__pr_reviews_red "Error: Invalid argument '$arg'")
            return 1
        end
    end

    # Calculate timestamp
    set -l timestamp (date -u -v-"$days"d +"%Y-%m-%d")
    set -l timestamp_iso "$timestamp"T00:00:00Z

    # Show what we're fetching
    if test $days -eq 1
        echo "Fetching PR reviews from the last 24 hours (since $timestamp)..."
    else
        echo "Fetching PR reviews from the last $days days (since $timestamp)..."
    end
    echo ""

    # Get current user's login
    set -l viewer_login (gh api user --jq '.login' 2>&1)
    if test $status -ne 0
        echo (__pr_reviews_red "Error: Failed to authenticate with GitHub")
        echo "Make sure you're logged in with 'gh auth login'"
        return 1
    end

    # Fetch reviews with GraphQL
    set -l search_query "is:pr reviewed-by:$viewer_login updated:>=$timestamp"
    set -l graphql_result (gh api graphql -f query='
        query($searchQuery: String!) {
            search(query: $searchQuery, type: ISSUE, first: 100) {
                nodes {
                    ... on PullRequest {
                        title
                        url
                        author {
                            login
                        }
                        repository {
                            nameWithOwner
                        }
                        state
                        merged
                        reviews(first: 100) {
                            nodes {
                                author {
                                    login
                                }
                                state
                                submittedAt
                            }
                        }
                    }
                }
            }
        }
    ' -f searchQuery="$search_query" 2>&1)

    if test $status -ne 0
        echo (__pr_reviews_red "Error: Failed to fetch reviews from GitHub")
        echo $graphql_result
        return 1
    end

    # Process results
    set -l reviews (echo $graphql_result | jq --arg user "$viewer_login" --arg since "$timestamp_iso" '
        .data.search.nodes | map(
            . as $pr |
            ($pr.reviews.nodes | map(select(.author.login == $user and .submittedAt >= $since)) | sort_by(.submittedAt) | reverse | first) as $review |
            if $review then
                {
                    title: $pr.title,
                    url: $pr.url,
                    author: $pr.author.login,
                    repo: $pr.repository.nameWithOwner,
                    state: (if $pr.merged then "MERGED" elif $pr.state == "OPEN" then "OPEN" else "CLOSED" end),
                    review_state: $review.state,
                    submitted_at: $review.submittedAt
                }
            else
                empty
            end
        )
    ' 2>&1)

    if test $status -ne 0
        echo (__pr_reviews_red "Error: Failed to process review data")
        echo $reviews
        return 1
    end

    # Check if we have any reviews
    set -l review_count (echo $reviews | jq 'length' 2>/dev/null)
    if test $status -ne 0; or test "$review_count" = 0
        echo "No reviews found in the specified time period."
        return 0
    end

    # Display reviews
    echo $reviews | jq -r --arg login "$viewer_login" --arg since "$timestamp_iso" '.[] | select(.author != $login) | select(. != null) |
        [
            .title,
            .author,
            .review_state,
            .state,
            .submitted_at,
            .url
        ] | @tsv' | while read -l line
        set -l fields (string split \t -- $line)
        set -l title $fields[1]
        set -l author $fields[2]
        set -l review_state $fields[3]
        set -l pr_state $fields[4]
        set -l submitted_at $fields[5]
        set -l url $fields[6]

        echo (__pr_reviews_bold $title)" - "(__pr_reviews_cyan $review_state)" ("(__pr_reviews_yellow $pr_state)")"
        echo "  by $author - "(__pr_reviews_format_timestamp $submitted_at)
        echo "  "(__pr_reviews_blue $url)
        echo ""
    end
end

# Color and formatting helper functions
function __pr_reviews_bold
    printf "\033[1m%s\033[0m" $argv[1]
end

function __pr_reviews_cyan
    printf "\033[36m%s\033[0m" $argv[1]
end

function __pr_reviews_yellow
    printf "\033[33m%s\033[0m" $argv[1]
end

function __pr_reviews_blue
    printf "\033[34m%s\033[0m" $argv[1]
end

function __pr_reviews_red
    printf "\033[31m%s\033[0m" $argv[1]
end

function __pr_reviews_format_timestamp
    set -l timestamp $argv[1]
    date -j -f "%Y-%m-%dT%H:%M:%SZ" "$timestamp" "+%b %d at %-I:%M %p %Z" 2>/dev/null
end
