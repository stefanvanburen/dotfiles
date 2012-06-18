# Oh-my-zsh
ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="miloshadzic"

# Various
alias news="newsbeuter"
alias bat="acpi -b"
alias sl="ls"
alias v="vim"
alias df="df -h"
alias list="ls -laog1"
alias ll="ls -alGh"
alias ls="ls -Gh"
alias du="du -h -d 2"
alias ..="cd .."
alias matrix="cmatrix -bs"

# Permissions
alias privatize="sudo chmod 600"
alias publicize="sudo chmod 777"

# Configuration
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias theme="vim ~/dotfiles/theme.lua"
alias rcl="vim ~/dotfiles/rc.lua"
alias rc="sudo vim /etc/rc.conf"
alias xinitrc="vim ~/.xinitrc"
alias taskrc="vim ~/.taskrc"
alias tmuxconf="vim ~/.tmux.conf"
alias font="setfont /usr/share/kbd/consolefonts/Lat2-Terminus16.psfu.gz"

# Package manager
alias update="sudo pacman -Syy"
alias upgrade="sudo pacman -Syu"

# Hardware
alias sus="sudo pm-suspend"
alias shutdown="sudo shutdown now"
alias restart="sudo shutdown -r now"

# Extended history
EXTENDED_HISTORY="true"

# Dots
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(git taskwarrior extract)

source $ZSH/oh-my-zsh.sh
source ~/.oh-my-zsh/plugins/git-flow/git-flow.plugin.zsh

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
