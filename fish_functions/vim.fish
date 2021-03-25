function vim --wraps=$EDITOR --description 'Edit file with $EDITOR'
    $EDITOR $argv;
end
