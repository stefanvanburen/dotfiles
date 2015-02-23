# .zshrc

# {{{ OSX

if [[ "$OSTYPE" == darwin* ]]; then
    source $HOME/dotfiles/zshrc.osx
fi

#}}}
# {{{ Arch

if [[ "$OSTYPE" == linux* ]]; then
    source $HOME/dotfiles/zshrc.arch
fi

# }}}
# {{{ Various Aliases

alias df="df -h --total"
alias u="cd .. && l"
alias du="du -h -c"
alias sl="ls"
alias ll="ls -alGh"

# }}}
# {{{ Configuration

alias zshrc="vim $HOME/dotfiles/zshrc"
alias vimrc="vim $HOME/dotfiles/vimrc"
alias so="source $HOME/.zshrc"

# }}}
# {{{ Environment

export EDITOR='vim'

# }}}

