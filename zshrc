# dot zshrc

# {{{ zplug

export ZPLUG_HOME="/usr/local/opt/zplug"
source $ZPLUG_HOME/init.zsh

zplug "plugins/battery", from:oh-my-zsh
zplug "plugins/branch", from:oh-my-zsh
zplug "plugins/brew", from:oh-my-zsh
zplug "plugins/cargo", from:oh-my-zsh
zplug "plugins/cask", from:oh-my-zsh
zplug "plugins/catimg", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/compleat", from:oh-my-zsh
zplug "plugins/copydir", from:oh-my-zsh
zplug "plugins/copyfile", from:oh-my-zsh
zplug "plugins/cp", from:oh-my-zsh
zplug "plugins/dircycle", from:oh-my-zsh
zplug "plugins/dirhistory", from:oh-my-zsh
zplug "plugins/dirpersist", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/emoji", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/fasd", from:oh-my-zsh
zplug "plugins/gem", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/git-extras", from:oh-my-zsh
zplug "plugins/github", from:oh-my-zsh
zplug "plugins/go", from:oh-my-zsh
zplug "plugins/golang", from:oh-my-zsh
zplug "plugins/gpg-agent", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/httpie", from:oh-my-zsh
zplug "plugins/iwhois", from:oh-my-zsh
zplug "plugins/lein", from:oh-my-zsh
zplug "plugins/lighthouse", from:oh-my-zsh
zplug "plugins/lol", from:oh-my-zsh
zplug "plugins/man", from:oh-my-zsh
zplug "plugins/nmap", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/nyan", from:oh-my-zsh
zplug "plugins/osx", from:oh-my-zsh
zplug "plugins/pass", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/profiles", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/redis-cli", from:oh-my-zsh
zplug "plugins/rsync", from:oh-my-zsh
zplug "plugins/taskwarrior", from:oh-my-zsh
zplug "plugins/thefuck", from:oh-my-zsh
zplug "plugins/themes", from:oh-my-zsh
zplug "plugins/tig", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/tmuxinator", from:oh-my-zsh
zplug "plugins/torrent", from:oh-my-zsh
zplug "plugins/vagrant", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/wd", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
zplug "plugins/zsh-navigation-tools", from:oh-my-zsh
zplug "plugins/zsh_reload", from:oh-my-zsh

zplug "b4b4r07/emoji-cli"
zplug "b4b4r07/enhancd", use:init.sh

zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

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

# }}}

# {{{ Aliases

alias u="cd .. && l"
alias sl="ls"
alias ll="ls -alGh"

alias vim=nvim
alias vi=nvim
alias vimdiff=nvim -d

alias zshrc="vim $HOME/.dotfiles/zshrc"
alias vimrc="vim $HOME/.dotfiles/vimrc"
alias so="source $HOME/.zshrc"
alias news=newsbeuter
alias rm=trash
alias rip="java -jar ~/src/bin/ripme.jar"
alias cb=clipboard
alias 750=750words
alias make=mmake
alias n='nnn -d'

alias pip3up='pip3 list --outdated | cut -d " " -f1 | xargs -n1 pip3 install -U'
alias pipup='pip list --outdated | cut -d " " -f1 | xargs -n1 pip install -U'
alias goup='go get -u all'
alias npmup='npm up -g'
alias vimup='vim +PlugUpgrade +PlugUpdate +qall'
alias gemup='gem update'
alias gemups='gem update --system'
alias zpup='zplug update'

# }}}

# {{{ Environment

export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS='--reverse --inline-info'

# }}}

# {{{ Configuration

# reload completions on installation
zstyle ':completion:*' rehash true
# don't share history across terminals
# unsetopt share_history

# }}}

# vim:foldmethod=marker
