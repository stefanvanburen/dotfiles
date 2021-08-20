function ev --description 'Edit neovim config files'
    cd ~/.dotfiles/nvim; $EDITOR fnl/dotfiles/core.fnl; cd -
end
