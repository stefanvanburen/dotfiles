# .zshrc
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

source $ZSH/oh-my-zsh.sh

# {{{ Various Aliases

alias u="cd .. && l"
alias sl="ls"
alias ll="ls -alGh"

alias vim=nvim
alias vi=nvim
alias vimdiff=nvim -d

alias zshrc="vim $HOME/.dotfiles/zshrc"
alias vimrc="vim $HOME/.dotfiles/vimrc"
alias so="source $HOME/.zshrc"

# }}}
# {{{ Configuration

# reload completions on installation
zstyle ':completion:*' rehash true
# don't share history across terminals
unsetopt share_history

# }}}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim:foldmethod=marker
