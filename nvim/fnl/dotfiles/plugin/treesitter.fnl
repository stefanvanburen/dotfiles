(module dotfiles.plugin.treesitter
  {autoload {treesitter "nvim-treesitter.configs"}})

(treesitter.setup
  {:ensure_installed "maintained"
   :matchup {:enable true}
   :highlight {:enable true}
   :incremental_selection {:enable true
                           :keymaps {:init_selection "gnn"
                                     :node_incremental "grn"
                                     :scope_incremental "grc"
                                     :node_decremental "grm"}}})
