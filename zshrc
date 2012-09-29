# Oh-my-zsh
ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="dieter"

# Various
alias news="newsbeuter"
alias irc='irssi -c im.bitlbee.org'
alias matrix="cmatrix -bs"
alias wifi="wicd-curses"
alias m="ncmpcpp"
alias h="htop"
alias bat="acpi -b"
alias sl="ls"
alias v="vim"
alias df="df -h --total"
alias du="du -h -d 2 -c"
alias list="ls -alog1"
alias ll="ls -alGh"
alias la="ls -a"
alias l="clear && pwd && ls -FGl"
alias ..="cd .."
alias u="cd .. && l"

# Suffix Aliases
alias -s pdf=evince
alias -s txt=vim
alias -s doc=libreoffice
alias -s odf=libreoffice

# Directories
hash -d src=~/src
hash -d dotfiles=~/dotfiles

# Permissions
alias privatize="sudo chmod 700"
alias publicize="sudo chmod 777"

# Configuration
alias zshrc="vim ~/dotfiles/zshrc"
alias vimrc="vim ~/dotfiles/vimrc"
alias font="setfont /usr/share/kbd/consolefonts/Lat2-Terminus16.psfu.gz"

# Package Manager
alias upd="sudo pacman -Syy"
alias upg="sudo pacman -Syu"
alias gupd="gem update"
alias bupd="brew update"
alias bupg="brew upgrade"

# Hardware
alias sus="sudo pm-suspend"
alias sd="sudo shutdown -h now"
alias rs="sudo shutdown -r now"

# Extended History
EXTENDED_HISTORY="true"

# Dots
COMPLETION_WAITING_DOTS="true"

# Plugins
if [[ $HOME == "/Users/mrtwiddletoes" ]]; then
    plugins=(git extract git-flow pip fasd ruby gem github node npm nyan python taskwarrior vi-mode brew osx)
elif [[ $HOME == "/home/thinkbot" ]]; then
    plugins=(git extract git-flow pip fasd ruby gem github node npm nyan python taskwarrior vi-mode archlinux)
fi

# ZSH
source $ZSH/oh-my-zsh.sh

# Task Warrior Tab Completion
fpath=($fpath /usr/local/share/doc/task/scripts/zsh)
autoload -Uz compinit
compinit
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*' group-name ''
autoload colors
zstyle ':completion:*:*:task:*:arguments' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[bold];$color[blue]" 
zstyle ':completion:*:*:task:*:default' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[green]" 
zstyle ':completion:*:*:task:*:values' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[bold];$color[red]" 
zstyle ':completion:*:*:task:*:commands' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[yellow]" 

# Path
export PATH=~/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:.:/usr/local/MATLAB/R2011a/bin:/home/thinkbot/.gem/ruby/1.9.1/bin:/root/.gem/ruby/1.9.1/bin

# XDG
XDG_CONFIG_HOME=~/.config
XDG_CONFIG_DIRS=~/.config:$XDG_CONFIG_DIRS

unsetopt correctall

case $TERM in
xterm*|rxvt*)
    if which tmux 2>&1 >/dev/null; then
        test -z "$TMUX" && (tmux -2 attach || tmux -2 new-session)
    fi
esac
