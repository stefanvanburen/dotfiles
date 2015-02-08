# .zshrc

# {{{ Oh My Zsh

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="zetetic"
DISABLE_UPDATE_PROMPT=true
plugins=(brew cp fasd gem git lein meteor pip themes tmux tmuxinator vi-mode vundle)
export PATH=$HOME/src/bin:$PATH
source $ZSH/oh-my-zsh.sh

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
# {{{ OSX

if [[ "$OSTYPE" == darwin* ]]; then
    # OSX Specific stuff
fi

#}}}

