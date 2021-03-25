function gv --wraps='$EDITOR +G +only' --description 'Open $EDITOR to Fugitive status'
    $EDITOR +G +only $argv;
end
