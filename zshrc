# dot zshrc

# {{{ zplug

export ZPLUG_HOME="/usr/local/opt/zplug"
source $ZPLUG_HOME/init.zsh

zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/fasd", from:oh-my-zsh
zplug "plugins/github", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/taskwarrior", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/zsh_reload", from:oh-my-zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "supercrabtree/k"

# Theme
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# }}}

# {{{ scripts

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# }}}

# {{{ other

eval "$(thefuck --alias)"

# }}}

# {{{ Aliases

# from oh-my-zsh directories.zsh
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'

alias md='mkdir -p'
alias rd='rmdir'

alias ll='ls -alGh'
alias u='cd .. && ll'
alias fn='find . -name'

alias sh='space-hogs'
alias cat='ccat'

# from zsh_reload plugin
alias so='src'

# taken from oh-my-zsh brew plugin
alias bubo='brew update && brew outdated'
alias bubc='brew upgrade && brew cleanup'
alias bubu='bubo && bubc'

alias vim='nvim'
alias vi='nvim'
alias vimdiff='nvim -d'

alias zshrc="$EDITOR $HOME/.dotfiles/zshrc"
alias vimrc="$EDITOR $HOME/.dotfiles/vimrc"

alias news='newsbeuter'
alias rm=trash
alias rip='java -jar ~/src/bin/ripme.jar'
alias 750='750words'
alias make='mmake'
alias mux='tmux'
alias n='nnn'
alias ls='exa'
alias cb='clipboard'

alias brewcup='brew cu -y -a'
alias pip3up='pip3 list --outdated --format=legacy | cut -d " " -f1 | xargs -n1 pip3 install -U'
alias pip2up='pip2 list --outdated --format=legacy | cut -d " " -f1 | xargs -n1 pip2 install -U'
alias goup='go get -u all'
alias npmup='npm up -g'
alias vimup='vim +PlugUpgrade +PlugUpdate +qall'
alias gemup='gem update'
alias gemups='gem update --system'
alias zpup='zplug update'
alias masup='mas upgrade'
alias rup='rustup update'
alias aup='apm upgrade --no-confirm'

alias up='bubu && brewcup && pip3up && pip2up && npmup && vimup && gemup && gemups && zpup && masup && rup && aup && goup'

clone() {
    git clone git@github.com:$1/$2.git
}

# }}}

# {{{ Configuration

# {{{ Literally the oh-my-zsh lib completion.zsh file with some minor modifications

zmodload -i zsh/complist

WORDCHARS=''

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select

# case insensitive (all), partial-word and substring completion
if [[ "$CASE_SENSITIVE" = true ]]; then
  zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
  if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
  else
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
  fi
fi
unset CASE_SENSITIVE HYPHEN_INSENSITIVE

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

if [[ $COMPLETION_WAITING_DOTS = true ]]; then
  expand-or-complete-with-dots() {
    # toggle line-wrapping off and back on again
    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti rmam
    print -Pn "%{%F{red}......%f%}"
    [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti smam

    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi

# }}}

### History
# add timestamp to history
setopt extended_history
# don't store the "history" command when calling it
setopt hist_no_store
# don't store a command if it's a duplicate of a previous command
setopt hist_ignore_dups
# add history to history file incrementally, rather than when the shell exits
setopt inc_append_history
# share histories throughout shells
setopt share_history
# remove superfluous blanks from command line added to history list
setopt hist_reduce_blanks

# Misc
# if we type a command that can't be issued, but is a directory, then cd to it
setopt autocd

# }}}

eval "$(direnv hook zsh)"

# vim:foldmethod=marker
