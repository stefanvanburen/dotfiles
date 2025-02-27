function fish_prompt --description "Overridden fish_prompt function"
    set --function last_status $status

    # https://fishshell.com/docs/current/cmds/prompt_pwd.html
    # https://fishshell.com/docs/current/cmds/fish_git_prompt.html
    printf '\n%s%s\n' (prompt_pwd) (fish_git_prompt)

    set --function prompt_character '$'
    if test $last_status -ne 0
        printf '%s%s%s ' (set_color --bold red) $prompt_character (set_color normal)
    else
        echo "$prompt_character "
    end
end
