# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# smt for git, funky for non-git
# Edited cypher but it looks bad now
ZSH_THEME="miloshadzic"

alias ta="task"
alias te="vim ~/.taskrc"
alias tw="t update"
alias news="newsbeuter"
alias bat="acpi -b"
alias list='ls -laog1'
alias privatize='sudo chmod 600'
alias publicize='sudo chmod 777'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias irc='irssi -c im.bitlbee.org'
alias cowsay='cowsay -b -W 90' 
alias cowthink='cowthink -b -W 90'
alias cowsayl='cowsay | lolcat'
alias cowthinkl='cowthink | lolcat'
alias information='bat -a; cal -a -s 50; fortune | cowsay -f vader-koala | lolcat -a -s 70; calendar -a -s 70'
alias sl='ls'
alias sus='sudo pm-suspend'
alias v='vim'
alias ze='vim ~/.zshrc'
alias ve='vim ~/.vimrc'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias autoclean='sudo apt-get autoclean'
alias autoremove='sudo apt-get autoremove'
alias mine='java -Xmx1024M -Xms512M -cp ~/usb/games/minecraft/minecraft.jar net.minecraft.LauncherFrame'
alias shutdown='sudo shutdown now'
alias restart='sudo shutdown -r now'
alias matrix='cmatrix'
alias cdb='cd -'
alias df='df -h'
alias ll='ls -alGh'
alias ls='ls -Gh'
alias du='du -h -d 2'

# From the oh-my-zsh 'lol' plugin, just to keep aliases in one file
# LOL!!1
# Source: http://aur.archlinux.org/packages/lolbash/lolbash/lolbash.sh
alias wtf='dmesg'
alias onoz='cat /var/log/errors.log'
alias rtfm='man'
alias visible='echo'
alias invisible='cat'
alias moar='more'
alias tldr='less'
alias alwayz='tail -f'
alias icanhas='mkdir'
alias gimmeh='touch'
alias donotwant='rm'
alias dowant='cp'
alias gtfo='mv'
alias nowai='chmod'
alias hai='cd'
alias iz='ls'
alias plz='pwd'
alias ihasbucket='df -h'
alias inur='locate'
alias iminurbase='finger'
alias btw='nice'
alias obtw='nohup'
alias nomz='ps -aux'
alias nomnom='killall'
alias byes='exit'
alias cya='reboot'
alias kthxbai='halt'

EXTENDED_HISTORY="true"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git nyan battery)

source $ZSH/oh-my-zsh.sh

# Task Warrior Tab Completion
fpath=($fpath /usr/local/share/doc/task/scripts/zsh)
autoload -Uz compinit
compinit
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*' group-name ''
# Colors for Tab Completion
autoload colors
zstyle ':completion:*:*:task:*:arguments' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[bold];$color[blue]" 
zstyle ':completion:*:*:task:*:default' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[green]" 
zstyle ':completion:*:*:task:*:values' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[bold];$color[red]" 
zstyle ':completion:*:*:task:*:commands' list-colors "=(#b) #([^-]#)*=$color[cyan]=$color[yellow]" 

# Customize to your needs...
export PATH=~/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:.:/usr/local/MATLAB/R2011a/bin
XDG_CONFIG_HOME=~/.config
XDG_CONFIG_DIRS=~/.config:$XDG_CONFIG_DIRS
