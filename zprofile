# dot zprofile

# {{{ Tabs

# set tabs to 4 in the terminal
tabs -4

# }}}

# {{{ Local Configuration

[[ -f ~/.zprofile.local ]] && source ~/.zprofile.local

# }}}

export PATH="$HOME/.cargo/bin:$PATH:$HOME/bin"
