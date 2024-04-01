function fish_prompt
    set --function last_status $status

    printf '\n%s%s\n' (prompt_pwd) (fish_git_prompt)

    set --function prompt_character '$'
    if test $last_status -ne 0
        set_color --bold red
    end

    echo "$prompt_character "
end
