function pr-reviews --description 'Get GitHub PR reviews in the last 24 hours'
    # Color helper functions
    function bold
        printf "\033[1m%s\033[0m" $argv[1]
    end

    function cyan
        printf "\033[36m%s\033[0m" $argv[1]
    end

    function yellow
        printf "\033[33m%s\033[0m" $argv[1]
    end

    function blue
        printf "\033[34m%s\033[0m" $argv[1]
    end

    # Convert ISO timestamp to human-friendly format
    function format_timestamp
        set -l timestamp $argv[1]
        # Convert ISO 8601 timestamp to readable format
        date -j -f "%Y-%m-%dT%H:%M:%SZ" "$timestamp" "+%b %d at %-I:%M %p %Z" 2>/dev/null
    end

    # Get timestamp from 24 hours ago
    set TIMESTAMP (date -u -v-24H +"%Y-%m-%d")

    echo "Fetching PR reviews from the last 24 hours (since $TIMESTAMP)..."
    echo ""

    # Get current user's login
    set VIEWER_LOGIN (gh api user --jq '.login')

    # Use GraphQL to fetch everything in one call (includes private repos)
    set TIMESTAMP_ISO "$TIMESTAMP"T00:00:00Z
    set SEARCH_QUERY "is:pr reviewed-by:$VIEWER_LOGIN updated:>=$TIMESTAMP"

    # Fetch all data with GraphQL
    set graphql_result (gh api graphql -f query='
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
    ' -f searchQuery="$SEARCH_QUERY")

    # Process with jq separately
    set REVIEWS (echo $graphql_result | jq --arg user "$VIEWER_LOGIN" --arg since "$TIMESTAMP_ISO" '
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
    ')

    # Count reviews by type
    set TOTAL (echo $REVIEWS | jq 'length')
    set MY_PRS (echo $REVIEWS | jq --arg login "$VIEWER_LOGIN" '[.[] | select(.author == $login)] | length')
    set OTHERS_PRS (echo $REVIEWS | jq --arg login "$VIEWER_LOGIN" '[.[] | select(.author != $login)] | length')
    set APPROVED (echo $REVIEWS | jq '[.[] | select(.review_state == "APPROVED")] | length')
    set COMMENTED (echo $REVIEWS | jq '[.[] | select(.review_state == "COMMENTED")] | length')
    set CHANGES_REQUESTED (echo $REVIEWS | jq '[.[] | select(.review_state == "CHANGES_REQUESTED")] | length')

    # Print summary
    echo "═══════════════════════════════════════════════════════════════"
    echo "                    PR Review Summary"
    echo "═══════════════════════════════════════════════════════════════"
    echo "Total Reviews:       $TOTAL"
    echo "  Your PRs:          $MY_PRS"
    echo "  Others' PRs:       $OTHERS_PRS"
    echo ""
    echo "Approved:            $APPROVED"
    echo "Commented:           $COMMENTED"
    echo "Changes Requested:   $CHANGES_REQUESTED"
    echo "═══════════════════════════════════════════════════════════════"
    echo ""

    # Print PRs created by others
    set OTHERS_COUNT (echo $REVIEWS | jq --arg login "$VIEWER_LOGIN" '[.[] | select(.author != $login)] | length')
    if test $OTHERS_COUNT -gt 0
        echo "┌─────────────────────────────────────────────────────────────┐"
        set -l count_str (string length -- $OTHERS_COUNT)
        set -l padding (math 22 - $count_str)
        printf "│              Reviews on Others' PRs (%d)%*s│\n" $OTHERS_COUNT $padding ""
        echo "└─────────────────────────────────────────────────────────────┘"

        echo $REVIEWS | jq -r --arg login "$VIEWER_LOGIN" '.[] | select(.author != $login) | select(. != null) |
            [
                .title,
                .repo,
                .author,
                .review_state,
                .state,
                .submitted_at,
                .url
            ] | @tsv' | while read -l line
            set -l fields (string split \t -- $line)
            set -l title $fields[1]
            set -l repo $fields[2]
            set -l author $fields[3]
            set -l review_state $fields[4]
            set -l pr_state $fields[5]
            set -l submitted_at $fields[6]
            set -l url $fields[7]

            echo ""
            echo (bold $title)
            echo "  Repository:  $repo"
            echo "  Author:      $author"
            echo "  Review Type: "(cyan $review_state)
            echo "  PR State:    "(yellow $pr_state)
            echo "  Reviewed At: "(format_timestamp $submitted_at)
            echo "  URL:         "(blue $url)
            echo "  ───────────────────────────────────────────────────────────────"
        end
        echo ""
    end

    set MY_COUNT (echo $REVIEWS | jq --arg login "$VIEWER_LOGIN" '[.[] | select(.author == $login)] | length')
    if test $MY_COUNT -gt 0
        echo "┌─────────────────────────────────────────────────────────────┐"
        set -l count_str (string length -- $MY_COUNT)
        set -l padding (math 21 - $count_str)
        printf "│              Reviews on Your Own PRs (%d)%*s│\n" $MY_COUNT $padding ""
        echo "└─────────────────────────────────────────────────────────────┘"

        echo $REVIEWS | jq -r --arg login "$VIEWER_LOGIN" '.[] | select(.author == $login) | select(. != null) |
            [
                .title,
                .repo,
                .review_state,
                .state,
                .submitted_at,
                .url
            ] | @tsv' | while read -l line
            set -l fields (string split \t -- $line)
            set -l title $fields[1]
            set -l repo $fields[2]
            set -l review_state $fields[3]
            set -l pr_state $fields[4]
            set -l submitted_at $fields[5]
            set -l url $fields[6]

            echo ""
            echo (bold $title)
            echo "  Repository:  $repo"
            echo "  Review Type: "(cyan $review_state)
            echo "  PR State:    "(yellow $pr_state)
            echo "  Reviewed At: "(format_timestamp $submitted_at)
            echo "  URL:         "(blue $url)
            echo "  ───────────────────────────────────────────────────────────────"
        end
        echo ""
    end
end
