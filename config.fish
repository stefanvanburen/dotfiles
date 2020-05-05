# enable fish's vi key bindings
fish_vi_key_bindings

set -gx EDITOR nvim

set -gx MANPAGER 'nvim +Man!'
set -gx MANWIDTH 999

# https://volta.sh/
set -gx VOLTA_HOME "$HOME/.volta"

# fzf commands
set -gx FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_CTRL_T_OPTS "--no-height --layout=reverse"
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse"

alias git="hub"

alias vim="nvim"

alias b="buku -a"

alias x="extract"

alias ls="exa"

alias c="clear"

alias md="mkdir -p"
alias rd="rmdir"

# https://github.com/sharkdp/bat
# Note that bat is configured in the bat_config file in dotfiles
alias cat="bat"

function sudo!!
    eval sudo $history[1]
end

alias vimrc="$EDITOR ~/.config/nvim/init.vim"
alias fishrc="$EDITOR ~/.config/fish/config.fish"

if status --is-interactive
    abbr --add --global - 'prevd'
    abbr --add --global v $EDITOR
    abbr --add --global g git

    command -q pyenv; and source (pyenv init -|psub); and source (pyenv virtualenv-init -|psub)
    command -q jump; and source (jump shell fish | psub)

    command -q starship; and starship init fish | source

    command -q direnv; and direnv hook fish | source

    # for iterm
    source ~/.iterm2_shell_integration.fish
end

set PATH $VOLTA_HOME/bin $HOME/bin $HOME/go/bin $HOME/.local/bin $HOME/.cargo/bin /usr/local/sbin $PATH

# local things
if test -e "$HOME/.extra.fish"
    source ~/.extra.fish
end
