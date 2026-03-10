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

    # Collect rows for two-pass alignment
    set -l row_titles
    set -l row_urls
    set -l row_authors
    set -l row_review_states
    set -l row_pr_states
    set -l row_timestamps
    echo $reviews | jq -r --arg login "$viewer_login" '.[] | select(.author != $login) | select(. != null) |
        [
            .title,
            .author,
            .review_state,
            .state,
            .submitted_at,
            .url
        ] | @tsv' | while read -l line
        set -l fields (string split \t -- $line)
        set -a row_titles $fields[1]
        set -a row_authors $fields[2]
        set -a row_review_states $fields[3]
        set -a row_pr_states $fields[4]
        set -a row_timestamps $fields[5]
        set -a row_urls $fields[6]
    end

    # Find max visible title width
    set -l esc \e
    set -l st $esc\\
    set -l max_title_width 0
    for title in $row_titles
        set -l w (string length --visible $title)
        if test $w -gt $max_title_width
            set max_title_width $w
        end
    end

    # Display reviews
    for i in (seq (count $row_titles))
        set -l title $row_titles[$i]
        set -l url $row_urls[$i]
        set -l author $row_authors[$i]
        set -l review_state $row_review_states[$i]
        set -l pr_state $row_pr_states[$i]
        set -l submitted_at $row_timestamps[$i]

        # Color code review state
        set -l review_color
        switch $review_state
            case APPROVED
                set review_color (__pr_reviews_green $review_state)
            case COMMENTED
                set review_color (__pr_reviews_cyan $review_state)
            case CHANGES_REQUESTED
                set review_color (__pr_reviews_red $review_state)
            case '*'
                set review_color $review_state
        end

        # Color code PR state
        set -l pr_color
        switch $pr_state
            case MERGED
                set pr_color (__pr_reviews_purple $pr_state)
            case CLOSED
                set pr_color (__pr_reviews_red $pr_state)
            case OPEN
                set pr_color (__pr_reviews_yellow $pr_state)
            case '*'
                set pr_color $pr_state
        end

        set -l colored_title (__pr_reviews_blue $title)
        set -l hyperlink "$esc]8;;$url$st$colored_title$esc]8;;$st"
        set -l invis (math (string length $colored_title) - (string length --visible $colored_title))
        set -l padded (string pad --right --width (math $max_title_width + $invis) $hyperlink)
        echo "$padded  $review_color  ($pr_color)  $author  "(__pr_reviews_format_timestamp $submitted_at)
    end
end

# Color and formatting helper functions
function __pr_reviews_green
    printf "\033[32m%s\033[0m" $argv[1]
end

function __pr_reviews_cyan
    printf "\033[36m%s\033[0m" $argv[1]
end

function __pr_reviews_yellow
    printf "\033[33m%s\033[0m" $argv[1]
end

function __pr_reviews_purple
    printf "\033[35m%s\033[0m" $argv[1]
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
