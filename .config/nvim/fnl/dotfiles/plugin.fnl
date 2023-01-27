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
                {:highlight {:enable true}
                 :ensure_installed
                 [:c ; must be installed
                  :clojure
                  :comment ; parse comments
                  :css
                  :fennel
                  :fish
                  :html
                  :gitignore
                  :go
                  :gomod
                  :help ; must be installed
                  :javascript
                  :json
                  :markdown
                  :markdown_inline
                  :proto
                  :python
                  :sql
                  :vim ; must be installed
                  :yaml]}))}
   {:url "https://github.com/jose-elias-alvarez/null-ls.nvim"
    :config #(let [null-ls (require :null-ls)]
               (null-ls.setup {:sources [null-ls.builtins.diagnostics.buf
                                         null-ls.builtins.formatting.buf
                                         null-ls.builtins.diagnostics.stylelint
                                         null-ls.builtins.diagnostics.shellcheck
                                         null-ls.builtins.formatting.shfmt]}))}
   {:url "https://github.com/echasnovski/mini.nvim"
    :config #(let [mini-pairs (require :mini.pairs)
                   mini-trailspace (require :mini.trailspace)
                   mini-comment (require :mini.comment)]
                (mini-pairs.setup)
                (mini-trailspace.setup)
                (mini-comment.setup))}
   {:url "https://github.com/ibhagwan/fzf-lua"
    :opts {:winopts {:border :single}
           :global_git_icons false
           :global_file_icons false}}
   {:url "https://github.com/tpope/vim-eunuch"}
   {:url "https://github.com/ggandor/leap.nvim"
    :config #(let [leap (require :leap)]
               (leap.add_default_mappings))}
   {:url "https://github.com/tpope/vim-surround"
    ;; disable vim-surround's default mappings, replacing most of
    ;; them in mapping.fnl, to work with leap.nvim.
    :config #(set vim.g.surround_no_mappings 1)}
   {:url "https://github.com/tpope/vim-unimpaired"}
   {:url "https://github.com/tpope/vim-abolish"}
   {:url "https://github.com/tpope/vim-repeat"}
   {:url "https://github.com/rktjmp/lush.nvim"}
   {:url "https://github.com/stefanvanburen/rams"}
   {:url "https://git.sr.ht/~p00f/alabaster.nvim"}
   {:url "https://github.com/mcchrish/zenbones.nvim"}])
