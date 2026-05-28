function ls --wraps=eza --description 'Use eza (with hyperlinks) when available, otherwise builtin ls'
    if command -q eza
        eza --hyperlink $argv
    else
        command ls $argv
    end
end
