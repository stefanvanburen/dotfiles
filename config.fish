alias x extract
alias ls exa
alias cat bat
alias c clear
alias j just
alias mv 'mv -iv'
alias cp 'cp -iv'
alias md 'mkdir -vp'

alias vim nvim
alias vimrc 'vim ~/.config/nvim/init.vim'
alias fishrc 'vim ~/.config/fish/config.fish'
alias ge 'git config --edit --global'
alias gv 'vim +G +only'

set -gx EDITOR nvim
# NOTE: keep in sync with install.conf.yaml
set -gx RIPGREP_CONFIG_PATH ~/.config/ripgreprc

if status --is-interactive
    # jump is bound to `z`
    command -q jump; and source (jump shell --bind=z fish | psub)
    command -q starship; and starship init fish | source

    command -q direnv; and direnv hook fish | source
end
