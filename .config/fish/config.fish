# https://fishshell.com/docs/current/#configuration

# https://xdgbasedirectoryspecification.com
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_STATE_HOME $HOME/.local/state
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set bin $HOME/.local/bin

# Go environment variables
# $ go help environment
set -gx GOPATH $XDG_CACHE_HOME/gopath
set -gx GOBIN $bin
set -gx GOCACHE $XDG_CACHE_HOME/gocache
set -gx GOMODCACHE $XDG_CACHE_HOME/gomodcache

# https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
set -gx RIPGREP_CONFIG_PATH ~/.config/ripgreprc

set -gx EDITOR nvim
# neovim's man plugin - see :h ft-man-plugin
set -gx MANPAGER "nvim +Man!"

# https://github.com/charmbracelet/glamour/tree/master/styles/gallery
# Light mode works better with my light background
set -gx GLAMOUR_STYLE light

# Don't write .pyc files.
# https://docs.python.org/3/using/cmdline.html#envvar-PYTHONDONTWRITEBYTECODE
set -gx PYTHONDONTWRITEBYTECODE 1

set -gx FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude .git'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -l fzf_colors '--color=light'
set -gx FZF_DEFAULT_OPTS "$fzf_colors"
set -gx FZF_CTRL_T_OPTS "$fzf_colors"

# uv tools / go
fish_add_path $bin
# rust
fish_add_path ~/.cargo/bin

# Setup homebrew environment (PATH-related variables)
# This must be before any command checking, as it sets up the PATH.
eval (/opt/homebrew/bin/brew shellenv)

if status --is-interactive
    # `man abbr`
    abbr --add - prevd
    abbr --add v vim
    abbr --add g git
    abbr --add b buf
    abbr --add m make
    abbr --add c clear
    abbr --add j just
    abbr --add rd rmdir

    # Set up vi key bindings
    # https://fishshell.com/docs/current/interactive.html#vi-mode-commands
    set -g fish_key_bindings fish_vi_key_bindings

    # jump is bound to `z`
    # https://github.com/gsamokovarov/jump#fish
    command -q jump; and jump shell --bind=z fish | source

    # https://direnv.net/docs/hook.html#fish
    command -q direnv; and direnv hook fish | source

    fzf --fish | source
end
