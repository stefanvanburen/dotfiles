# .zshrc

export ZSH=$HOME/.oh-my-zsh

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

source $ZSH/oh-my-zsh.sh

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
alias vim=nvim
alias vi=nvim

# }}}
# {{{ Environment

export EDITOR='nvim'

# }}}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim:foldmethod=marker
