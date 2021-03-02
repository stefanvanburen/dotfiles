alias x extract
alias ls exa
alias cat bat
alias vim nvim
alias c clear
alias j just
alias mv 'mv -iv'
alias cp 'cp -iv'
alias md 'mkdir -vp'

alias ev 'vim ~/.config/nvim/init.lua'
alias ef 'vim ~/.config/fish/config.fish'
alias eg 'git config --edit --global'

alias gv 'vim +G +only'

set -gx EDITOR nvim
# NOTE: keep in sync with install.conf.yaml
set -gx RIPGREP_CONFIG_PATH ~/.config/ripgreprc
# https://github.com/sharkdp/bat#man
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

set -gx FZF_DEFAULT_COMMAND 'fd --type file --follow --hidden --exclude .git'
set -gx FZF_DEFAULT_OPTS    '--height 40% --layout=reverse'
set -gx FZF_CTRL_T_COMMAND  'fd --type file --follow --hidden --exclude .git'
set -gx FZF_CTRL_T_OPTS     '--no-height --layout=reverse'

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

    # jump is bound to `z`
    command -q jump; and source (jump shell --bind=z fish | psub)

    command -q starship; and starship init fish | source

    command -q direnv; and direnv hook fish | source
end
