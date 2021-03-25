function gv --wraps=$EDITOR --description 'Open $EDITOR to Fugitive status'
    $EDITOR +G +only $argv;
end
