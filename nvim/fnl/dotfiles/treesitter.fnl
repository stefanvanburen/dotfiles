(module dotfiles.treesitter
  {autoload {treesitter "nvim-treesitter.configs"}})

((. treesitter :setup)
 {:ensure_installed "maintained"
  :highlight {:enabled true}})
