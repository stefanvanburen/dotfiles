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
   ;; when using nvim-parinfer, this errors when uncommenting certain
   ;; forms. disabling for now.
   :matchup {:enable false}
   :highlight {:enable true}})
