# Oh-my-zsh
ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="dieter"

# Plugins
if [[ $HOME == "/Users/mrtwiddletoes" ]]; then
    plugins=(git extract git-flow pip fasd ruby gem github node npm nyan python taskwarrior vi-mode brew osx)
elif [[ $HOME == "/home/thinkbot" ]]; then
    plugins=(git extract git-flow pip fasd ruby gem github node npm nyan python taskwarrior vi-mode archlinux)
elif [[ $HOME == "/home/foxer" ]]; then
	plugins=(git extract git-flow pip fasd ruby gem github node npm nyan python taskwarrior vi-mode archlinux)
fi

# ZSH
source $ZSH/oh-my-zsh.sh

# Various
alias irc='irssi -c im.bitlbee.org'
alias matrix="cmatrix -bs"
alias h="htop"
alias sl="ls"
alias df="df -h --total"
alias list="ls -alog1"
alias ll="ls -alGh"
alias la="ls -a"
alias l="clear && pwd && ls -FGl"
alias u="cd .. && l"
if [[ $HOME == "/home/thinkbot" ]]; then
    alias du="du -h -d 2 -c -a"
    alias news="newsbeuter"
    alias bat="acpi -b"
    alias wifi="wicd-curses"
    alias m="ncmpcpp"
elif [[ $HOME == "/home/foxer" ]]; then
    alias du="du -h -d 2 -c -a"
    alias news="newsbeuter"
    alias bat="acpi -b"
    alias wifi="wicd-curses"
    alias m="ncmpcpp"
elif [[ $HOME == "/Users/mrtwiddletoes" ]]; then
    alias du="du -h -d 2 -c"
fi

# Suffix Aliases
alias -s txt=vim
alias -s doc=libreoffice
alias -s odf=libreoffice
if [[ $HOME == "/home/thinkbot" ]]; then
    alias -s pdf=evince
elif [[ $HOME == "/home/foxer" ]]; then
    alias -s pdf=evince
fi

# Directories
hash -d src=~/src
hash -d dot=~/dotfiles
hash -d dr=~/Dropbox

# Permissions
alias privatize="sudo chmod 700"
alias publicize="sudo chmod 777"

# Configuration
alias zshrc="vim ~/dotfiles/zshrc"
alias vimrc="vim ~/dotfiles/vimrc"
if [[ $HOME == "/home/thinkbot" ]]; then
    alias font="setfont /usr/share/kbd/consolefonts/Lat2-Terminus16.psfu.gz"
elif [[ $HOME == "/home/foxer" ]]; then
    alias font="setfont /usr/share/kbd/consolefonts/Lat2-Terminus16.psfu.gz"
fi

# Package Manager
if [[ $HOME == "/Users/mrtwiddletoes" ]]; then
    alias upd="brew update"
    alias upg="brew upgrade"
    alias gupd="sudo gem update"
elif [[ $HOME == "/home/thinkbot" ]]; then
    alias upd="sudo pacman -Syy"
    alias upg="sudo pacman -Syu"
    alias gupd="gem update"
elif [[ $HOME == "/home/foxer" ]]; then
    alias upd="sudo pacman -Syy"
    alias upg="sudo pacman -Syu"
    alias gupd="gem update"
fi

# Hardware
if [[ $HOME == "/home/thinkbot" ]]; then
    alias sus="sudo pm-suspend"
    alias sd="sudo shutdown -h now"
    alias rs="sudo shutdown -r now"
elif [[ $HOME == "/home/foxer" ]]; then
    alias sd="sudo shutdown -h now"
    alias rs="sudo shutdown -r now"
fi

# Extended History
EXTENDED_HISTORY="true"

# Dots
COMPLETION_WAITING_DOTS="true"

# Path
export PATH=.:~/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/.gem/ruby/1.9.1/bin:/root/.gem/ruby/1.9.1/bin

# XDG
if [[ $HOME == "/home/thinkbot" ]]; then
    XDG_CONFIG_HOME=~/.config
    XDG_CONFIG_DIRS=~/.config:$XDG_CONFIG_DIRS
fi

# No corrections
unsetopt correctall

# Automatically start tmux if our term is xterm or rxvt
case $TERM in
xterm*|rxvt*)
    if which tmux 2>&1 >/dev/null; then
        test -z "$TMUX" && (tmux -2 attach || tmux -2 new-session)
    fi
esac
