(module dotfiles.plugin.treesitter
  {autoload {treesitter "nvim-treesitter.configs"}})

(treesitter.setup
  {:ensure_installed "maintained"
   :autotag {:enable true
             :filetypes [:html]}
   :matchup {:enable true}
   :highlight {:enable true
               ;; for zk
               :additional_vim_regex_highlighting ["markdown"]}
   :incremental_selection {:enable true
                           :keymaps {:init_selection "gnn"
                                     :node_incremental "grn"
                                     :scope_incremental "grc"
                                     :node_decremental "grm"}}})
