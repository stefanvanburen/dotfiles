# Oh-my-zsh
ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="agnoster"

# Plugins
plugins=(brew colored-man extract fasd gem git github git-extras git-flow pip python taskwarrior vundle)

# ZSH
source $ZSH/oh-my-zsh.sh

# Various Aliases
alias df="df -h --total"
alias u="cd .. && l"
alias du="du -h -d 2 -c -a"

# Applications
alias irc='irssi'
alias h="htop"
alias tmux="tmux -2"

# Configuration
alias zshrc="vim ~/dotfiles/zshrc"
alias vimrc="vim ~/dotfiles/vimrc"
alias dot="vim ~/random/.dot.txt"

# Package Manager
alias upd="brew update"
alias upg="brew upgrade"
alias gupd="sudo gem update"

# Don't ask me about updating oh-my-zsh
DISABLE_UPDATE_PROMPT=true

# Path
export PATH=.:~/src/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# No corrections
unsetopt correctall

export DYLD_FORCE_FLAT_NAMESPACE=1
