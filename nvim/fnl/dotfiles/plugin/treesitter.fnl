(module dotfiles.plugin.treesitter
  {autoload {treesitter "nvim-treesitter.configs"}})

(treesitter.setup
  {:ensure_installed "maintained"
   :autotag {:enable true
             :filetypes [:html]}
   :matchup {:enable true}
   :highlight {:enable true}})
