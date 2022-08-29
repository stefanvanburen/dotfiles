(module dotfiles.plugin.treesitter
  {autoload {treesitter "nvim-treesitter.configs"}})

(treesitter.setup
  {:ensure_installed ["clojure"
                      "css"
                      "fennel"
                      "fish"
                      "html"
                      "gitignore"
                      "go"
                      "gomod"
                      "help"
                      "javascript"
                      "json"
                      "markdown"
                      "markdown_inline"
                      "proto"
                      "sql"
                      "yaml"]
   :matchup {:enable true}
   :highlight {:enable true}})
