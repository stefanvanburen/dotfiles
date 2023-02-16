(module dotfiles.plugin
    {autoload {: lazy}})

(lazy.setup
  [{:url "https://github.com/justinmk/vim-dirvish"}
   ;; required by vim-fugitive
   {:url "https://github.com/tyru/open-browser.vim"}
   {:url "https://github.com/lewis6991/gitsigns.nvim"
    :config
    #(let [gitsigns (require :gitsigns)]
       (gitsigns.setup
         {:attach_to_untracked false
          :on_attach
          ;; https://github.com/lewis6991/gitsigns.nvim#keymaps
          (fn [bufnr]
           (let [map (fn [mode l r ?opts]
                       (let [opts (or ?opts {})]
                         (set opts.buffer bufnr)
                         (vim.keymap.set mode l r opts)))]
             ;; Navigation
             (map "n" "]c" (fn []
                             (if (= vim.wo.diff true)
                               "]c"
                               (do
                                 (vim.schedule #(gitsigns.next_hunk))
                                 "<Ignore>")))
                   {:expr true})
             (map "n" "[c" (fn []
                             (if (= vim.wo.diff true)
                               "[c"
                               (do
                                 (vim.schedule #(gitsigns.prev_hunk))
                                 "<Ignore>")))
                   {:expr true})
             ;; Actions
             (map ["n" "v"] "<leader>hs" gitsigns.stage_hunk)
             (map ["n" "v"] "<leader>hr" gitsigns.reset_hunk)
             (map "n" "<leader>hS" gitsigns.stage_buffer)
             (map "n" "<leader>hR" gitsigns.reset_buffer)
             (map "n" "<leader>hu" gitsigns.undo_stage_hunk)
             (map "n" "<leader>hp" gitsigns.preview_hunk)
             (map "n" "<leader>hb" #(gitsigns.blame_line {:full true}))
             (map "n" "<leader>tb" gitsigns.toggle_current_line_blame)
             (map "n" "<leader>hd" gitsigns.diffthis)
             (map "n" "<leader>hD" #(gitsigns.diffthis "~"))
             (map "n" "<leader>td" gitsigns.toggle_deleted)
             ;; Text object
             (map ["o" "x"] "ih" ":<C-U>Gitsigns select_hunk<CR>")))}))}
   {:url "https://github.com/tpope/vim-fugitive"
    ;; Remove legacy fugitive commands (which only result in warnings, rather than something useful)
    :config #(set vim.g.fugitive_legacy_commands 0)}
   {:url "https://github.com/tpope/vim-rhubarb"}
   {:url "https://github.com/mattn/vim-gotmpl"}
   {:url "https://github.com/fladson/vim-kitty"}
   {:url "https://github.com/NoahTheDuke/vim-just"}
   {:url "https://github.com/Olical/aniseed"}
   {:url "https://github.com/Olical/conjure"}
   {:url "https://github.com/gpanders/nvim-parinfer"}
   {:url "https://github.com/nvim-lua/plenary.nvim"}
   {:url "https://github.com/neovim/nvim-lspconfig"}
   {:url "https://github.com/williamboman/mason.nvim" :config true}
   {:url "https://github.com/williamboman/mason-lspconfig.nvim" :config true}
   {:url "https://github.com/nvim-treesitter/nvim-treesitter"
    :build ":TSUpdate"
    :config #(let [treesitter (require "nvim-treesitter.configs")]
              (treesitter.setup
                {;; https://github.com/nvim-treesitter/nvim-treesitter#highlight
                 :highlight {:enable true}
                 ;; Add support for treesitter indentation using the `=` operator.
                 ;; https://github.com/nvim-treesitter/nvim-treesitter#indentation
                 :indent {:enable true}
                 ;; https://github.com/andymass/vim-matchup#tree-sitter-integration
                 :matchup {:enable true}
                 :ensure_installed
                 [;;; These four are required to be installed.
                  ;;; See https://github.com/nvim-treesitter/nvim-treesitter/issues/3970#issuecomment-1377126359
                  ;; https://github.com/tree-sitter/tree-sitter-c
                  :c
                  ;; https://github.com/MunifTanjim/tree-sitter-lua
                  :lua
                  ;; https://github.com/vigoux/tree-sitter-viml
                  :vim
                  ;; https://github.com/neovim/tree-sitter-vimdoc
                  :help

                  ;; https://github.com/sogaiu/tree-sitter-clojure
                  :clojure
                  ;; https://github.com/stsewd/tree-sitter-comment
                  ;; parses comments
                  :comment
                  ;; https://github.com/tree-sitter/tree-sitter-css
                  :css
                  ;; https://github.com/the-mikedavis/tree-sitter-diff
                  :diff
                  ;; https://github.com/travonted/tree-sitter-fennel
                  :fennel
                  ;; https://github.com/ram02z/tree-sitter-fish
                  :fish
                  ;; https://github.com/tree-sitter/tree-sitter-html
                  :html
                  ;; https://github.com/gbprod/tree-sitter-gitcommit
                  :gitcommit
                  ;; https://github.com/the-mikedavis/tree-sitter-git-rebase
                  :git_rebase
                  ;; https://github.com/ObserverOfTime/tree-sitter-gitattributes
                  :gitattributes
                  ;; https://github.com/tree-sitter/tree-sitter-go
                  :go
                  ;; https://github.com/camdencheek/tree-sitter-go-mod
                  :gomod
                  ;; https://github.com/tree-sitter/tree-sitter-javascript
                  :javascript
                  ;; https://github.com/tree-sitter/tree-sitter-json
                  :json
                  ;; https://github.com/alemuller/tree-sitter-make
                  :make
                  ;; https://github.com/MDeiml/tree-sitter-markdown
                  :markdown
                  :markdown_inline
                  ;; https://github.com/mitchellh/tree-sitter-proto
                  ;; Not very well maintained - regular highlighting looks fine for now, disabling.
                  ; :proto
                  ;; https://github.com/tree-sitter/tree-sitter-python
                  :python
                  ;; https://github.com/derekstride/tree-sitter-sql
                  :sql
                  ;; https://github.com/ikatyang/tree-sitter-toml
                  :toml
                  ;; https://github.com/ikatyang/tree-sitter-yaml
                  :yaml
                  ;; https://github.com/maxxnino/tree-sitter-zig
                  :zig]}))}
   {:url "https://github.com/jose-elias-alvarez/null-ls.nvim"
    :config #(let [null-ls (require :null-ls)]
               (null-ls.setup {:sources [null-ls.builtins.diagnostics.buf
                                         null-ls.builtins.formatting.buf
                                         null-ls.builtins.diagnostics.markdownlint_cli2
                                         null-ls.builtins.diagnostics.stylelint
                                         null-ls.builtins.diagnostics.shellcheck
                                         null-ls.builtins.formatting.shfmt]}))}
   {:url "https://github.com/echasnovski/mini.nvim"
    :config #(let [mini-pairs (require :mini.pairs)
                   mini-trailspace (require :mini.trailspace)
                   mini-comment (require :mini.comment)
                   mini-surround (require :mini.surround)]
                (mini-pairs.setup)
                (mini-trailspace.setup)
                (mini-comment.setup)
                (mini-surround.setup
                  {:mappings {:add            :gza
                              :delete         :gzd
                              :find           :gzf
                              :find_left      :gzF
                              :highlight      :gzh
                              :replace        :gzr
                              :update_n_lines :gzn}}))}
   {:url "https://github.com/ibhagwan/fzf-lua"
    :opts {:winopts {:border :single}
           :global_git_icons false
           :global_file_icons false}}
   {:url "https://github.com/tpope/vim-eunuch"}
   {:url "https://github.com/andymass/vim-matchup"
    :config #(set vim.g.matchup_matchparen_offscreen {})}
   {:url "https://github.com/ggandor/leap.nvim"
    ;; https://github.com/ggandor/leap.nvim#dependencies
    :dependencies {:url "https://github.com/tpope/vim-repeat"}
    :config #(let [leap (require :leap)]
               (leap.add_default_mappings))}
   {:url "https://github.com/tpope/vim-unimpaired"}
   {:url "https://github.com/tpope/vim-abolish"}
   {:url "https://github.com/tpope/vim-repeat"}
   {:url "https://github.com/rktjmp/lush.nvim"}
   {:url "https://github.com/stefanvanburen/rams"}
   {:url "https://git.sr.ht/~p00f/alabaster.nvim"}
   {:url "https://github.com/mcchrish/zenbones.nvim"
    ;; https://github.com/mcchrish/zenbones.nvim/blob/main/doc/zenbones.md#configuration
    :config #(set vim.g.zenwritten_italic_comments false)}])
