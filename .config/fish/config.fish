# https://fishshell.com/docs/current/#configuration

# https://xdgbasedirectoryspecification.com
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_STATE_HOME $HOME/.local/state
# Non-standard, but respected by some tools.
set -gx XDG_BIN_HOME $HOME/.local/bin

# Go environment variables
# $ go help environment
set -gx GOPATH $XDG_CACHE_HOME/gopath
set -gx GOBIN $XDG_BIN_HOME
set -gx GOCACHE $XDG_CACHE_HOME/gocache
set -gx GOMODCACHE $XDG_CACHE_HOME/gomodcache

# https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
set -gx RIPGREP_CONFIG_PATH ~/.config/ripgreprc

# https://wiki.archlinux.org/title/Environment_variables#Default_programs
set -gx EDITOR nvim
# neovim's man plugin - see :h ft-man-plugin
set -gx MANPAGER "nvim +Man!"

# https://github.com/junegunn/fzf?tab=readme-ov-file#environment-variables
set -gx FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude .git'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -l fzf_colors --no-color
set -gx FZF_DEFAULT_OPTS "$fzf_colors"
set -gx FZF_CTRL_T_OPTS "$fzf_colors"

# uv tools / go
fish_add_path $XDG_BIN_HOME
# rust
fish_add_path ~/.cargo/bin
# bun
fish_add_path ~/.cache/.bun/bin

# Setup homebrew environment (PATH-related variables)
# This must be before any command checking, as it sets up the PATH.
if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

if status --is-interactive
    # Use the default theme.
    # https://fishshell.com/docs/4.3/interactive.html#syntax-highlighting
    fish_config theme choose default

    ## `man abbr`
    # https://fishshell.com/docs/current/cmds/prevd.html
    abbr --add - prevd
    # ../nvim/init.fnl
    abbr --add v vim
    # ../git/config
    abbr --add g git
    # https://buf.build/docs/cli/
    abbr --add b buf
    # https://makefiletutorial.com
    abbr --add m make
    # https://just.systems
    abbr --add j just

    # Set up vi key bindings
    # https://fishshell.com/docs/current/interactive.html#vi-mode-commands
    set -g fish_key_bindings fish_vi_key_bindings

    # jump is bound to `z`
    # https://github.com/gsamokovarov/jump#fish
    command -q jump; and jump shell --bind=z fish | source

    # https://direnv.net/docs/hook.html#fish
    command -q direnv; and direnv hook fish | source

    # https://github.com/junegunn/fzf?tab=readme-ov-file#setting-up-shell-integration
    command -q fzf; and fzf --fish | source
end
