# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# smt for git, funky for non-git
# Edited cypher but it looks bad now
ZSH_THEME="miloshadzic"

# Various
alias t="task"
alias news="newsbeuter"
alias matrix='ncmatrix -abls -I wlan0 -R blue -T red'
alias bat="acpi -b"
alias sl='ls'
alias v='vim'
alias df='df -h'
alias list='ls -laog1'
alias ll='ls -alGh'
alias ls='ls -Gh'
alias du='du -h -d 2'
alias c='clear'
alias ..='cd ..'

# Permissions
alias privatize='sudo chmod 600'
alias publicize='sudo chmod 777'

# Configuration
alias ze='vim ~/.zshrc'
alias ve='vim ~/.vimrc'
alias te="vim ~/dotfiles/theme.lua"
alias rc="vim ~/dotfiles/rc.lua"
alias re="sudo vim /etc/rc.conf"
alias xe="vim ~/.xinitrc"

# Package manager
alias update='sudo pacman -Syy'
alias upgrade='sudo pacman -Syu'

# Hardware
alias sus='sudo pm-suspend'
alias shutdown='sudo shutdown now'
alias restart='sudo shutdown -r now'

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
export PATH=~/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:.:/usr/local/MATLAB/R2011a/bin:/home/thinkbot/.gem/ruby/1.9.1/bin
XDG_CONFIG_HOME=~/.config
XDG_CONFIG_DIRS=~/.config:$XDG_CONFIG_DIRS
