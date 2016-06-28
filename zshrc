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

alias vim=nvim
alias vi=nvim
alias vimdiff=nvim -d
alias zshrc="vim $HOME/.dotfiles/zshrc"
alias vimrc="vim $HOME/.dotfiles/vimrc"
alias so="source $HOME/.zshrc"

# }}}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim:foldmethod=marker
