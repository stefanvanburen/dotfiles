if status --is-interactive
    command -q jump; and source (jump shell fish | psub)
    command -q starship; and starship init fish | source

    command -q pyenv; and source (pyenv init -|psub); and source (pyenv virtualenv-init -|psub)
    command -q direnv; and direnv hook fish | source
end
