# Oh-my-zsh
ZSH=$HOME/.oh-my-zsh

# Theme; old themes: dieter, agnoster, pygmalion, miloshadzic
ZSH_THEME="agnoster"

# Plugins
plugins=(brew colored-man extract fasd gem git github git-extras git-flow pip python taskwarrior tmux vundle)

# ZSH
source $ZSH/oh-my-zsh.sh

# Various Aliases
alias sl="ls"
alias df="df -h --total"
alias list="ls -alog1"
alias ll="ls -alGh"
alias la="ls -a"
alias l="clear && pwd && ls -FGl"
alias u="cd .. && l"
alias ae="alias edit"
alias ar="alias reload"
alias du="du -h -d 2 -c -a"

# Applications
alias irc='irssi'
alias h="htop"

# Configuration
alias zshrc="vim ~/dotfiles/zshrc"
alias vimrc="vim ~/dotfiles/vimrc"
alias dot="vim ~/random/.dot.txt"

# Package Manager
alias upd="brew update"
alias upg="brew upgrade"
alias gupd="sudo gem update"

# Extended History
EXTENDED_HISTORY="true"

# Dots
COMPLETION_WAITING_DOTS="true"

# Path
export PATH=.:~/src/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/.gem/ruby/1.9.1/bin:/root/.gem/ruby/1.9.1/bin

# XDG
XDG_CONFIG_HOME=~/.config
XDG_CONFIG_DIRS=~/.config:$XDG_CONFIG_DIRS

# No corrections
unsetopt correctall

export DYLD_FORCE_FLAT_NAMESPACE=1

# Don't ask me about updating oh-my-zsh
DISABLE_UPDATE_PROMPT=true
