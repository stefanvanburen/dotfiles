if status --is-interactive
    command -q jump; and source (jump shell fish | psub)
    command -q starship; and starship init fish | source
end
