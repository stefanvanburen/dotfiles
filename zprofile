[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx
wiki() {
    dig +short txt $1.wp.dg.cx
}
