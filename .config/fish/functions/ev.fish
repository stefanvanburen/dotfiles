function ev --description 'Edit neovim config files'
    $EDITOR -c "lua require('fzf-lua').files({cwd = '~/.config/nvim'})"
end
