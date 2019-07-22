alias g="hub"
alias git="hub"

alias m="mmake"
alias make="mmake"

alias md="mkdir -p"
alias rd="rmdir"

direnv hook fish | source

status --is-interactive; and source (jump shell fish | psub)
