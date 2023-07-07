# https://fishshell.com/docs/current/#configuration

# https://xdgbasedirectoryspecification.com
set -qx XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -qx XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -qx XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache
set -qx XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state

set -gx EDITOR nvim
# https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
set -gx RIPGREP_CONFIG_PATH ~/.config/ripgreprc
# neovim's man plugin - see :h ft-man-plugin
set -gx MANPAGER "nvim +Man!"

# https://github.com/charmbracelet/glamour/tree/master/styles/gallery
# Light mode works better with my light background
set -gx GLAMOUR_STYLE light

# Homebrew settings
# https://docs.brew.sh/Manpage#environment
# Disable fancy colors
set -gx HOMEBREW_NO_COLOR 1
set -gx HOMEBREW_NO_EMOJI 1
# Use `bat` for `brew cat`
set -gx HOMEBREW_BAT 1

# pipx
fish_add_path ~/.local/bin
# rust
fish_add_path ~/.cargo/bin
# go
fish_add_path ~/go/bin

function zf_file --description 'Use zf to select a file'
    fd --type file --follow --hidden --exclude .git --strip-cwd-prefix | zf | while read -l r; set result $result $r; end
    if [ -z "$result" ]
      commandline -f repaint
      return
    else
      # Remove last token from commandline.
      commandline -t ""
    end
    for i in $result
      commandline -it -- $prefix
      commandline -it -- (string escape $i)
      commandline -it -- ' '
    end
    commandline -f repaint
end

if status --is-interactive
    # `man abbr`
    abbr --add --global - prevd
    abbr --add --global v vim
    abbr --add --global g git
    abbr --add --global b buf
    abbr --add --global m make
    abbr --add --global x extract
    abbr --add --global c clear
    abbr --add --global j just
    abbr --add --global rd rmdir

    # Set up vi key bindings
    # https://fishshell.com/docs/current/interactive.html#vi-mode-commands
    set -g fish_key_bindings fish_vi_key_bindings

    # set terminal colors
    # https://fishshell.com/docs/current/cmds/fish_config.html
    fish_config theme choose 'Mono Lace'

    # Setup homebrew environment (PATH-related variables)
    # This must be before any command checking, as it sets up the PATH.
    eval (/opt/homebrew/bin/brew shellenv)

    # jump is bound to `z`
    # https://github.com/gsamokovarov/jump#fish
    command -q jump; and jump shell --bind=z fish | source

    # https://direnv.net/docs/hook.html#fish
    command -q direnv; and direnv hook fish | source

    bind \cr history-pager
    bind -M insert \cr history-pager

    bind \ct zf_file
    bind -M insert \ct zf_file
end
