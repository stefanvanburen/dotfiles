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
