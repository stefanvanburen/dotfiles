# vim:foldmethod=marker
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

zplug "b4b4r07/enhancd", use:init.sh
zplug "supercrabtree/k"

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Theme
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# Slow!
# zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# }}}

# {{{ scripts

# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://www.iterm2.com/documentation-shell-integration.html
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# https://direnv.net/
# https://github.com/direnv/direnv
eval "$(direnv hook zsh)"

# https://github.com/pypa/pipenv/
eval "$(pipenv --completion)"

# https://github.com/nvbn/thefuck
eval "$(thefuck --alias)"

# https://github.com/Homebrew/homebrew-command-not-found
if brew command command-not-found-init > /dev/null 2>&1; then eval "$(brew command-not-found-init)"; fi

# https://github.com/aykamko/tag
if (( $+commands[tag] )); then
  export TAG_SEARCH_PROG=rg
  tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
  alias rg=tag
fi

# }}}

# {{{ Aliases

# from oh-my-zsh directories.zsh
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='\cd -'

alias md='mkdir -p'
alias rd='rmdir'

# git
if (( $+commands[git] )); then
  alias commit='git commit'
  alias co='git checkout'
fi

if (( $+commands[mmake] )); then
  alias make=mmake
  alias m=mmake
elif (( $+commands[make] )); then
  alias m=make
fi

# relies on k plugin
if (( $+commands[k] )); then
    alias k='k -h'
    alias l=k
fi

alias ll='ls -alGh'
alias u='cd .. && ll'
alias fn='find . -name'
alias h="cd $HOME"

# brew install ccat
if (( $+commands[ccat] )); then
    alias cat='ccat'
fi

# npm install --global clipboard-cli
if (( $+commands[clipboard] )); then
    alias cb='clipboard'
fi

# from zsh_reload plugin
alias so='src'

# taken from oh-my-zsh brew plugin
if (( $+commands[brew] )); then
    alias bubo='brew update && brew outdated'
    alias bubc='brew upgrade && brew cleanup'
    alias bubu='bubo && bubc'
fi

# if (( $+commands[nvim] )); then
#     alias vim='nvim'
#     alias vi='nvim'
#     alias v='nvim'
#     alias vimdiff='nvim -d'
# elif (( $+commands[vim] )); then
#     alias vi='vim'
#     alias v='vim'
# fi

if (( $+commands[vim] )); then
    alias vi='vim'
    alias v='vim'
fi

alias ge="$EDITOR $HOME/.gitconfig"
alias gitconfig="$EDITOR $HOME/.gitconfig"
alias zshrc="$EDITOR $HOME/.dotfiles/zshrc"
alias vimrc="$EDITOR $HOME/.dotfiles/vimrc"
alias ze="$EDITOR $HOME/.dotfiles/zshrc"
alias ve="$EDITOR $HOME/.dotfiles/vimrc"

if (( $+commands[newsbeuter] )); then
    alias news='newsbeuter'
fi

if (( $+commands[tmux] )); then
    function tm() {
        [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
        if [ $1 ]; then
            tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
        fi
        session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
    }
fi

# if (( $+commands[nnn] )); then
#     alias n='nnn'
# fi

if (( $+commands[exa] )); then
    alias ls='exa'
fi

if (( $+commands[git] )); then
    alias g='git'
fi

if (( $+commands[youtube-dl] )); then
    alias ytdl='youtube-dl'
fi

if (( $+commands[you-get] )); then
    alias yg='you-get'
fi

if (( $+commands[mosh] )); then
    alias ssh='mosh'
fi

# -a forces updates
alias brewcup='brew cask upgrade && brew cask cleanup'
alias goup='go get -u all'
alias npmup='npm up -g'
alias yarnup='yarn global upgrade'
alias vimup='vim +PlugUpgrade +PlugUpdate +qall'
alias gemup='gem update'
alias gemups='gem update --system'
# zplug
alias zpup='zplug update'
# mac app store
alias masup='mas upgrade'
# rust
alias rup='rustup update'
# atom
alias aup='apm upgrade --no-confirm'

# }}}

# {{{ Functions

# generates gitignore files
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# }}}

# {{{ Configuration

# {{{ Completion

# Literally the oh-my-zsh lib completion.zsh file with some minor modifications

zmodload -i zsh/complist

WORDCHARS=''

# do not autoselect the first completion entry
unsetopt menu_complete

unsetopt flowcontrol

# show completion menu on successive tab press
setopt auto_menu

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

# {{{ History

# up history size
HISTSIZE=SAVEHIST=100000
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

# }}}

# }}}

# {{{ Misc

# if we type a command that can't be issued, but is a directory, then cd to it
setopt autocd
# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

# }}}

# {{{ Local Configuration

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# }}}
