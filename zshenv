# dot zshenv

# {{{ Typical

export PAGER='less'
export EDITOR='nvim'
export PATH="/usr/local/sbin:$HOME/src/bin:$HOME/src/bp:$HOME/src/go/bin:$HOME/.cargo/bin:$PATH"

# }}}

# {{{ Go

export GOPATH="$HOME/src/go"

# }}}

export FZF_DEFAULT_COMMAND='ag -g --hidden --ignore .git ""'

# {{{ ZSH options

export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# }}}

# {{{ Cheat

export CHEATCOLORS=true

# }}}

# {{{ Local Configuration

[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

# }}}

# {{{ RVM

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# }}}
