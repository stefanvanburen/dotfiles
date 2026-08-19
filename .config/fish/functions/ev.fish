function ev --description 'Edit neovim config file'
    # Edit from inside the directory rather than by absolute path, so the
    # editor's working directory is the config itself.
    cd ~/.config/nvim
    or return
    $EDITOR init.fnl
    cd -
end
