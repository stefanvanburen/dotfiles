alias gd 'git diff'
alias gs 'git st'

if status --is-interactive
    command -q jump; and source (jump shell fish | psub)
    command -q starship; and starship init fish | source

    command -q direnv; and direnv hook fish | source
end
