# dot zshenv

# {{{ Typical

export PAGER='less'
# export LESS='-FMiX'
export PURE_PROMPT_SYMBOL='∆'

export EDITOR='nvim'

export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# }}}

# {{{ nnn

export NNN_USE_EDITOR=1

# }}}

# {{{ Go

export GOPATH="$HOME/src/go"

# }}}

# {{{ FZF

export FZF_DEFAULT_COMMAND='rg --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# removing --reverse
export FZF_DEFAULT_OPTS='--height 40% --border'

# }}}

# {{{ ZSH options

export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# }}}

# {{{ Cheat

export CHEATCOLORS=true

# }}}

# {{{ rg

export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# }}}

# {{{ Local Configuration

[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

# }}}
