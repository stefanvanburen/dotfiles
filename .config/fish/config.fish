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
set -q EDITOR
or set -gx EDITOR nvim
# neovim's man plugin - see :h ft-man-plugin
# Only a default: `man` honors MANPAGER even when writing to a pipe, so callers
# that need a non-blocking pager (fish-lsp's hover shells out to
# `__fish_print_help`, which runs `man`) can pass their own value in.
set -q MANPAGER
or set -gx MANPAGER "nvim +Man!"

# https://github.com/junegunn/fzf?tab=readme-ov-file#environment-variables
set -gx FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude .git'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_DEFAULT_OPTS --no-color

# Setup homebrew environment (PATH-related variables)
# This must be before any command checking, as it sets up the PATH, and before
# the fish_add_path calls below: `brew shellenv` prepends, so anything added
# after it takes priority over a brew-installed program of the same name.
if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

# --global keeps these in this file: the default writes the universal
# fish_user_paths, which would hold on to a directory after its line is deleted
# here. --move re-prepends a directory already inherited from a parent shell,
# so nesting shells doesn't reorder PATH.
# uv tools / go
fish_add_path --global --move $XDG_BIN_HOME
# rust
fish_add_path --global --move ~/.cargo/bin

if status --is-interactive
    # Silence the greeting: fish only checks that the value is empty.
    set -g fish_greeting

    ## `man abbr`
    # https://fishshell.com/docs/current/cmds/prevd.html
    abbr --add - prevd
    # ../nvim/init.fnl
    abbr --add v vim
    # ../git/config
    abbr --add g git
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
