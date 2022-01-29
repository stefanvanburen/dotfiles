(module dotfiles.plugin.treesitter
  {autoload {treesitter "nvim-treesitter.configs"}})

(treesitter.setup
  {:ensure_installed "maintained"
   :matchup {:enable true}
   :highlight {:enable true}})
