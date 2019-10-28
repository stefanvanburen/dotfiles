set -gx EDITOR nvim

alias v="$EDITOR"

alias m="make"

alias c="clear"

alias md="mkdir -p"
alias rd="rmdir"

alias ...="../.."
alias ....="../../.."

# for direnv
direnv hook fish | source

# for pyenv
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)


# for jump
status --is-interactive; and source (jump shell fish | psub)

# for starship prompt
# eval (starship init fish)
status --is-interactive; and source (starship init fish |psub)

# TODO: local file
set PATH /usr/local/opt/mongodb@3.4/bin /Users/stefan/.local/bin $HOME/.local/bin $HOME/.cargo/bin $PATH
