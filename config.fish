# alacritty doesn't render emojis quite right, so for now, disable the greeting altogether
# https://github.com/alacritty/alacritty/issues/1864
# set fish_greeting "🐠"
set fish_greeting

if status --is-interactive
    alias git="hub"

    alias vim="nvim"

    alias vimrc="$EDITOR ~/.config/nvim/init.vim"
    alias fishrc="$EDITOR ~/.config/fish/config.fish"

    alias x="extract"

    alias ls="exa"

    alias c="clear"

    alias md="mkdir -p"
    alias rd="rmdir"

    command -q mmake; and alias make="mmake"

    # https://github.com/sharkdp/bat
    # Note that bat is configured in the bat_config file in dotfiles
    command -q bat; and alias cat="bat"

    command -q pyenv; and source (pyenv init -|psub); and source (pyenv virtualenv-init -|psub)
    command -q jump; and source (jump shell fish | psub)
    command -q starship; and starship init fish | source
    command -q direnv; and direnv hook fish | source
end
