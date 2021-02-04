(module dotfiles.module.treesitter
  {require {treesitter "nvim-treesitter.configs"}})

((. treesitter :setup)
 {:ensure_installed "maintained"
  :highlight {:enabled true}})
