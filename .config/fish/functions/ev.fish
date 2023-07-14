function ev --description 'Edit neovim config file'
    cd ~/.config/nvim; and $EDITOR init.fnl; cd -
end
