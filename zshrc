# vim:foldmethod=marker
# dot zshrc

# {{{ zplug

# using the homebrew zplug
export ZPLUG_HOME="/usr/local/opt/zplug"
source $ZPLUG_HOME/init.zsh

# This seems to cause more trouble than it's worth
# zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# adds `x` command for unarchiving various formats
zplug "plugins/extract", from:oh-my-zsh
# initializes fasd; extra aliases
# turning this off to use jump
# zplug "plugins/fasd", from:oh-my-zsh
# use `hub` for `git` if it's installed; extra aliases
zplug "plugins/github", from:oh-my-zsh
# initializes pyenv
zplug "plugins/pyenv", from:oh-my-zsh
# handles ssh-agent
zplug "plugins/ssh-agent", from:oh-my-zsh
# adds t alias, taskwarrior completions
# not really using taskwarrior much anymore
# zplug "plugins/taskwarrior", from:oh-my-zsh
# sets up vi-mode for the command line
zplug "plugins/vi-mode", from:oh-my-zsh
# adds `src` alias for reloading zsh session
# zplug "plugins/zsh_reload", from:oh-my-zsh

# Not really useful
# zplug "b4b4r07/enhancd", use:init.sh
# k is pretty slow
# zplug "supercrabtree/k"

# zplug "zsh-users/zsh-completions"
# zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# zplug 'wfxr/forgit', defer:1

# Theme
# required for pure
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

# https://github.com/nvbn/thefuck
eval "$(thefuck --alias)"

# https://github.com/gsamokovarov/jump
eval "$(jump shell)"

# https://github.com/Homebrew/homebrew-command-not-found
# Is this worth it?
# if brew command command-not-found-init > /dev/null 2>&1; then eval "$(brew command-not-found-init)"; fi

# https://github.com/aykamko/tag
if (( $+commands[tag] )); then
  export TAG_SEARCH_PROG=rg
  tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
  alias rg=tag
fi

# Set up hub wrapper for git, if it is available; https://github.com/github/hub
if (( $+commands[hub] )); then
  alias g=hub
  alias git=hub
elif (( $+commands[git] )); then
  alias g='git'
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
# k is slow
# if (( $+commands[k] )); then
#     alias k='k -h'
#     alias l=k
# fi

alias ll='ls -alGh'
alias u='cd .. && ll'
alias fn='find . -name'
alias h="cd $HOME"

if (( $+commands[bat] )); then
    # brew install bat
    alias cat='bat'
elif (( $+commands[ccat] )); then
    # brew install ccat
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

alias gitconfig="$EDITOR $HOME/.gitconfig"
alias zshrc="$EDITOR $HOME/.dotfiles/zshrc"
alias vimrc="$EDITOR $HOME/.dotfiles/vimrc"
alias ge=gitconfig
alias ze=zshrc
alias ve=vimrc


alias s='spotify'

alias w='curl wttr.in/Boston'

# force these to be $EDITOR
alias vim="$EDITOR"
alias nv="$EDITOR"

if (( $+commands[newsboat] )); then
    alias news='newsboat'
elif (( $+commands[newsbeuter] )); then
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

if (( $+commands[nnn] )); then
    alias n='nnn'
fi

if (( $+commands[exa] )); then
    alias ls='exa'
    alias l='exa --long --git'
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

# {{{ Misc

alias c=cheat
alias tl=tldr
# needs https://github.com/sindresorhus/clipboard-cli
alias cb='clipboard'

alias gs='g st'
alias v="$EDITOR"

function _root () {
        cd $(git rev-parse --show-toplevel)
}
alias root=_root

function _mcd () {
        md $1 && cd $1
}
alias mcd=_mcd

# }}}

# }}}

# {{{ Functions

# generates gitignore files
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# initializes a private repo on github and opens the page
# relies on `hub` for `git create`
function initialize() {
  git init && git commit --allow-empty -m "Initial commit" && git create -p -o
}

# mf opens "Matching Files" to a regex / string given to rg
# TODO: vim always complains about this given that rg might not
# return anything, or hang
function mf() { rg -l $1 | xargs $EDITOR }

# https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
# Seems to break things?
# fancy-ctrl-z () {
#   if [[ $#BUFFER -eq 0 ]]; then
#     BUFFER="fg"
#     zle accept-line
#   else
#     zle push-input
#     zle clear-screen
#   fi
# }
# zle -N fancy-ctrl-z
# bindkey '^Z' fancy-ctrl-z

# from https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
# https://junegunn.kr/2016/07/fzf-git/
# GIT heart FZF
# -------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}


join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local char
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h
unset -f bind-git-helper

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
# add `cd` directories to the `dirs` stack
setopt auto_pushd
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
