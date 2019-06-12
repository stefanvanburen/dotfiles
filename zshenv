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

export PURE_PROMPT_SYMBOL='▵'
export PURE_PROMPT_VICMD_SYMBOL='▿'

export TERM="screen-256color"

# switching back to nvim
export EDITOR='nvim'
export VISUAL="$EDITOR"

# {{{ Go

export GOPATH="$HOME/src/go"
export PATH="$PATH:$GOPATH/bin"
# turn modules on
# https://github.com/golang/go/wiki/Modules#how-to-install-and-activate-module-support
export GO111MODULE=auto
export GOPROXY=https://proxy.golang.org

# }}}

export PATH="/usr/local/opt/grep/libexec/gnubin:/usr/local/sbin:/usr/local/bin:$HOME/.cargo/bin:$HOME/bin:$HOME/.local/bin:$PATH"

# }}}

# {{{ nnn

export NNN_USE_EDITOR=1

# }}}

# {{{ FZF

export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--reverse --no-height --border --ansi --preview 'bat --color=always {}'"
export FZF_DEFAULT_OPTS="--height 40% --border --reverse --ansi"

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
