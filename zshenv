# dot zshenv

# {{{ Typical

export PAGER='less'
# export LESS='-FMiX'
export PURE_PROMPT_SYMBOL='∞'

# if (( $+commands[nvim] )); then
#     export EDITOR='nvim'
# elif (( $+commands[vim] )); then
#     export EDITOR='vim'
# fi
export EDITOR='vim'

export PATH="/usr/local/sbin:/usr/local/bin:$HOME/src/bin:$HOME/src/bp:$HOME/src/go/bin:$HOME/.cargo/bin:$HOME/.fastlane/bin:$PATH"

# }}}

# {{{ Go

export GOPATH="$HOME/src/go"

# }}}

# {{{ FZF

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# }}}

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
