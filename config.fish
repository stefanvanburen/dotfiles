# bootstrap fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

set -gx EDITOR nvim
# https://github.com/venantius/ultra/issues/108#issuecomment-522347422
set -gx LEIN_USE_BOOTCLASSPATH no

alias vim="$EDITOR"
abbr v vim

alias m="make"
alias make="mmake"

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
set PATH /usr/local/opt/mongodb-community@3.4/bin /Users/stefan/.local/bin $HOME/.local/bin $HOME/.cargo/bin $PATH

# for iterm
source ~/.iterm2_shell_integration.(basename $SHELL)

# for asdf
# NOTE: still can't really use for python as it doesn't have great integration
# with pyenv quite yet
source /usr/local/opt/asdf/asdf.fish
