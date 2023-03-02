function fish_prompt --description 'Fallback prompt, in the case starship is not installed'
    printf '\f\r%s\f\r; ' (prompt_pwd)
end
