function ls --wraps=eza --description 'Use eza when available, otherwise builtin ls'
    if command -q eza
        eza $argv
    else
        command ls $argv
    end
end
