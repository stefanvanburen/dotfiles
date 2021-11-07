(module dotfiles.plugin.autopairs
  {autoload {autopairs nvim-autopairs}})

(autopairs.setup
  {:map_cr true
   ;; conflicts with parinfer
   :disable_filetype [:clojure :fennel]})
