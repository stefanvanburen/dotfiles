# dot zshenv

# {{{ Typical

export PAGER='less'
# wholesale copied from prezto's config; but at least explained:
# -F : exit if less than a full screen
# -g : highlight only the particular string found by last search command, not all of them
# -i : ignore case
# -M : long prompt
# -R : only output ANSI "color" escape sequences in raw form
# -S : chop long lines - truncate long lines rather than wrapping them
# -w : briefly highlight the first new line after moving forward a page
# -X : no init (???)
# -z-4 : scroll by (length of page) - 4
export LESS='-F -g -i -M -R -S -w -X -z-4'

export PURE_PROMPT_SYMBOL='∆'

# vim > nvim, for now
export EDITOR='vim'
export VISUAL="$EDITOR"

# {{{ Go

export GOPATH="$HOME/src/go"
export PATH="$PATH:$GOPATH/bin"

# }}}

export PATH="$PATH:/usr/local/sbin:/usr/local/bin:$HOME/.cargo/bin"

# }}}

# {{{ nnn

export NNN_USE_EDITOR=1

# }}}

# {{{ FZF

export FZF_DEFAULT_COMMAND='fd --type file --color=always --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --border --reverse --ansi'

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
