(module dotfiles.plugin.treesitter)

(local config
  ;; when using nvim-parinfer, this errors when uncommenting certain
  ;; forms. disabling for now.
  {:matchup {:enable false}
   :highlight {:enable true}
   :ensure_installed [:clojure
                      :comment ; parse comments
                      :css
                      :fennel
                      :fish
                      :html
                      :gitignore
                      :go
                      :gomod
                      :help
                      :javascript
                      :json
                      :markdown
                      :markdown_inline
                      :proto
                      :sql
                      :yaml]})

(let [(ok? treesitter) (pcall require "nvim-treesitter.configs")]
  (when ok?
    (treesitter.setup config)))
