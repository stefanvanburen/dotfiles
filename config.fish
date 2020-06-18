alias gd 'git diff'
alias gs 'git st'
alias x extract
alias ls exa
alias cat bat
alias git hub
alias c clear

alias vim nvim
alias vimrc 'vim ~/.config/nvim/init.vim'
alias fishrc 'vim ~/.config/fish/config.fish'
alias gv 'vim +G +only'
alias vw 'vim -c "cd ~/nv" -c VimwikiIndex -c Rg'

if status --is-interactive
    command -q jump; and source (jump shell fish | psub)
    command -q starship; and starship init fish | source

    command -q direnv; and direnv hook fish | source
end
