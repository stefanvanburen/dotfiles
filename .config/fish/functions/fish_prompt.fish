# Configure fish_git_prompt to include the upstream ahead/behind indicator.
# These run once when this file is autoloaded (the first time fish_prompt is called).
set -g __fish_git_prompt_showupstream auto
set -g __fish_git_prompt_char_upstream_ahead "⇡"
set -g __fish_git_prompt_char_upstream_behind "⇣"
set -g __fish_git_prompt_char_upstream_diverged "⇡⇣"
set -g __fish_git_prompt_char_upstream_equal ""

function fish_prompt --description "Overridden fish_prompt function"
    # Capture $status FIRST — any subsequent command clobbers it.
    set --function last_status $status

    # SSH host indicator (only when connected via SSH)
    set --function host
    set -q SSH_TTY; and set host (set_color yellow)"$hostname"(set_color normal)":"

    # Background job count
    set --function jobs
    set --local njobs (count (jobs -g))
    test $njobs -gt 0; and set jobs (set_color cyan)"[$njobs] "

    # Quote each variable: in fish an unquoted empty variable expands to zero
    # arguments (not one empty arg), which would misalign the format spec.
    printf '\n%s%s%s %s\n' "$host" (prompt_pwd) (fish_git_prompt) "$jobs"

    set --function prompt_character '$'
    if test $last_status -ne 0
        printf '%s%s%s ' (set_color --bold red) $prompt_character (set_color normal)
    else
        echo "$prompt_character "
    end
end
