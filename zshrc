# Oh-my-zsh
ZSH=$HOME/.oh-my-zsh

# Theme; old themes: dieter, agnoster, pygmalion, miloshadzic
ZSH_THEME="miloshadzic"

# Plugins
plugins=(archlinux command-not-found extract fasd gem git github git-extras git-flow pip node npm nyan python ruby taskwarrior vi-mode)

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
alias news="newsbeuter"
alias bat="acpi -b"
alias wifi="wicd-curses"
alias m="ncmpcpp"
alias irc='irssi'
alias h="htop"

# Suffix Aliases
alias -s txt=vim
alias -s doc=libreoffice
alias -s odf=libreoffice
alias -s pdf=evince

# Directories
hash -d src=~/src
hash -d dot=~/dotfiles
hash -d dr=~/Dropbox

# Permissions
alias privatize="sudo chmod 700"
alias publicize="sudo chmod 777"

# Configuration
alias zshrc="vim ~/dotfiles/zshrc"
alias font="setfont /usr/share/kbd/consolefonts/Lat2-Terminus16.psfu.gz"
alias vimrc="vim ~/dotfiles/vimrc.linux"

# Package Manager
alias upd="sudo pacman -Syy"
alias upg="sudo pacman -Syu"
alias gupd="sudo gem update"

# Hardware
alias sus="systemctl suspend"
alias sd="systemctl poweroff"
alias rs="systemctl reboot"

# Extended History
EXTENDED_HISTORY="true"

# Dots
COMPLETION_WAITING_DOTS="true"

# Path
export PATH=.:~/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/.gem/ruby/1.9.1/bin:/root/.gem/ruby/1.9.1/bin

# XDG
XDG_CONFIG_HOME=~/.config
XDG_CONFIG_DIRS=~/.config:$XDG_CONFIG_DIRS

# No corrections
unsetopt correctall

# Automatically start tmux if our term is rxvt
case $TERM in
rxvt*)
    if which tmux 2>&1 >/dev/null; then
        test -z "$TMUX" && (tmux -2 attach || tmux -2 new-session)
    fi
esac
