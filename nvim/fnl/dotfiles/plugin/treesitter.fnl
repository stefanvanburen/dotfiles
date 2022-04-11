(module dotfiles.plugin.treesitter
  {autoload {treesitter "nvim-treesitter.configs"}})

(treesitter.setup
  {:ensure_installed ["go"] ; TODO: what languages?
   :matchup {:enable true}
   :highlight {:enable true}})
