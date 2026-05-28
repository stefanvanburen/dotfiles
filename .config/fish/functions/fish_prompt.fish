# Configure fish_git_prompt to include the upstream ahead/behind indicator.
# These run once when this file is autoloaded (the first time fish_prompt is called).
set -g __fish_git_prompt_showupstream auto
set -g __fish_git_prompt_char_upstream_ahead "⇡"
set -g __fish_git_prompt_char_upstream_behind "⇣"
set -g __fish_git_prompt_char_upstream_diverged "⇡⇣"
set -g __fish_git_prompt_char_upstream_equal ""

function fish_prompt --description "Overridden fish_prompt function"
    # Capture $status and $pipestatus FIRST — any subsequent command clobbers them.
    set --function last_status $status
    set --function last_pipestatus $pipestatus

    # SSH host indicator (only when connected via SSH)
    set --function host
    set -q SSH_TTY; and set host (set_color yellow)"$hostname"(set_color normal)":"

    # Background job count
    set --function jobs
    set --local njobs (count (jobs -g))
    test $njobs -gt 0; and set jobs (set_color cyan)"[$njobs] "

    # Last command duration if >1s
    set --function duration
    if test "$CMD_DURATION" -gt 1000
        set --local secs (math --scale=1 $CMD_DURATION/1000 % 60)
        set --local mins (math --scale=0 $CMD_DURATION/60000 % 60)
        set --local hours (math --scale=0 $CMD_DURATION/3600000)
        set --local dur
        test $hours -gt 0; and set -a dur $hours"h"
        test $mins -gt 0; and set -a dur $mins"m"
        test $secs -gt 0; and set -a dur $secs"s"
        set duration (set_color cyan)(string join '' $dur)" "
    end

    # Pipestatus: shown only if a pipeline ran and any stage failed
    set --function pipe
    if test (count $last_pipestatus) -gt 1
        for code in $last_pipestatus
            if test $code -ne 0
                set --local codes (string join '|' $last_pipestatus)
                set pipe (set_color red)" [$codes]"(set_color normal)
                break
            end
        end
    end

    printf '\n%s%s%s%s %s%s\n' $host (prompt_pwd) (fish_git_prompt) $pipe $jobs $duration

    set --function prompt_character '$'
    if test $last_status -ne 0
        printf '%s%s%s ' (set_color --bold red) $prompt_character (set_color normal)
    else
        echo "$prompt_character "
    end
end
