# NOTE: When setting up a new system, make sure to run fish_config
# and choose "Mono Lace" under colors, to set the terminal colors.

set -gx EDITOR nvim
# NOTE: keep in sync with install.conf.yaml
set -gx RIPGREP_CONFIG_PATH ~/.config/ripgreprc
# https://github.com/sharkdp/bat#man
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# https://github.com/charmbracelet/glamour/tree/master/styles/gallery
# Light mode works better with my light background
set -gx GLAMOUR_STYLE light

# use `fd` instead of `find` by default with fzf.
set fzf_default_command 'fd --type file --follow --hidden --exclude .git'

set -gx FZF_DEFAULT_COMMAND $fzf_default_command
set -gx FZF_CTRL_T_COMMAND  $fzf_default_command

# reverse fzf's layout - by default, the input is at the bottom of the screen - I prefer it at the top.
# turn off info and color in fzf's output (including the `bat` preview)
set -gx FZF_DEFAULT_OPTS '--layout=reverse --no-info --no-color'
set -gx FZF_CTRL_T_OPTS  "--layout=reverse --no-info --no-color --preview 'bat --line-range :500 {}'"

# In general, try to disable color in the terminal.
# `fd` supports this; I'm sure others do as well.
set -gx NO_COLOR

# Homebrew settings
# Disable fancy colors and analytics
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx HOMEBREW_NO_COLOR 1
set -gx HOMEBREW_NO_EMOJI 1

# fish_add_path requires fish 3.2.0
# pipx
fish_add_path ~/.local/bin
# rust
fish_add_path ~/.cargo/bin
# go
fish_add_path ~/go/bin
# volta
fish_add_path ~/.volta/bin
# my scripts
fish_add_path ~/bin

if status --is-interactive
    # `man abbr`
    abbr --add --global - prevd
    abbr --add --global v vim
    abbr --add --global g git
    abbr --add --global tm tmux
    abbr --add --global x extract
    abbr --add --global c clear
    abbr --add --global j just
    abbr --add --global rd rmdir

    # jump is bound to `z`
    command -q jump; and source (jump shell --bind=z fish | psub)

    command -q starship; and starship init fish | source

    command -q direnv; and direnv hook fish | source
end
