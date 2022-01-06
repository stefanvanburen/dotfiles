function ea --description 'Edit alacritty config within dotfiles'
    cd ~/.dotfiles
    $EDITOR alacritty.yml
    cd -
end
