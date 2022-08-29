(module dotfiles.plugin.treesitter
  {autoload {treesitter "nvim-treesitter.configs"}})

(treesitter.setup
  {:ensure_installed ["clojure"
                      "css"
                      "fennel"
                      "html"
                      "go"
                      "gomod"
                      "markdown"
                      "markdown_inline"
                      "sql"]
   :matchup {:enable true}
   :highlight {:enable true}})
