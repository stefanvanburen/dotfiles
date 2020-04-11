# bootstrap fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# enable fish's vi key bindings
fish_vi_key_bindings

set -gx VISUAL nvim
set -gx EDITOR nvim

# https://docs.python.org/3/using/cmdline.html#envvar-PYTHONDONTWRITEBYTECODE
set -gx PYTHONDONTWRITEBYTECODE 1

# https://github.com/sharkdp/bat#man
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# default git base branch
# https://blog.jez.io/cli-code-review/
set -gx REVIEW_BASE "master"

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

alias vimrc="$EDITOR ~/.vimrc"
alias fishrc="$EDITOR ~/.config/fish/config.fish"

if status --is-interactive
    abbr --add --global - 'prevd'
    abbr --add --global v $EDITOR
    abbr --add --global g git

    command -q pyenv; and source (pyenv init -|psub); and source (pyenv virtualenv-init -|psub)
    source (jump shell fish | psub)

    starship init fish | source

    direnv hook fish | source

    # for iterm
    source ~/.iterm2_shell_integration.(basename $SHELL)
end

set PATH $VOLTA_HOME/bin $HOME/bin $HOME/go/bin $HOME/.local/bin $HOME/.cargo/bin /usr/local/sbin $PATH

# local things
if test -e "$HOME/.extra.fish"
    source ~/.extra.fish
end
