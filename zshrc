# .zshrc

source ~/.zshrc.local

# {{{ Various Aliases

alias df="df -h --total"
alias u="cd .. && l"
alias du="du -h -c"
alias sl="ls"
alias ll="ls -alGh"

# }}}
# {{{ Configuration

alias zshrc="vim $HOME/.dotfiles/zshrc"
alias vimrc="vim $HOME/.dotfiles/vimrc"
alias so="source $HOME/.zshrc"

# }}}
# {{{ Environment

export EDITOR='nvim'

# }}}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim:foldmethod=marker
