function ef --description 'Edit fish config within dotfiles'
    cd ~/.dotfiles
    $EDITOR config.fish
    cd -
end
