(module dotfiles.plugin
    {autoload {: lazy}})

(lazy.setup
  [{:url "https://github.com/justinmk/vim-dirvish"}
   {:url "https://github.com/tyru/open-browser.vim"}
   {:url "https://github.com/lewis6991/gitsigns.nvim" :config true}
   {:url "https://github.com/tpope/vim-fugitive"}
   {:url "https://github.com/tpope/vim-rhubarb"}
   {:url "https://github.com/mattn/vim-gotmpl"}
   {:url "https://github.com/dstein64/vim-startuptime"}
   {:url "https://github.com/Olical/aniseed"}
   {:url "https://github.com/Olical/conjure"}
   {:url "https://github.com/gpanders/nvim-parinfer"}
   {:url "https://github.com/nvim-lua/plenary.nvim"}
   {:url "https://github.com/neovim/nvim-lspconfig"}
   {:url "https://github.com/williamboman/mason.nvim" :config true}
   {:url "https://github.com/williamboman/mason-lspconfig.nvim" :config true}
   {:url "https://github.com/nvim-treesitter/nvim-treesitter"
    :build ":TSUpdate"
    :config {:highlight {:enable true}
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
                                :yaml]}}
   {:url "https://github.com/jose-elias-alvarez/null-ls.nvim"
    :config (fn []
              (let [null-ls (require :null-ls)]
                (null-ls.setup {:sources [null-ls.builtins.diagnostics.buf
                                          null-ls.builtins.formatting.buf
                                          null-ls.builtins.diagnostics.stylelint
                                          null-ls.builtins.diagnostics.shellcheck
                                          null-ls.builtins.formatting.shfmt]})))}
   {:url "https://github.com/tpope/vim-dispatch"}
   {:url "https://github.com/vim-test/vim-test"}
   {:url "https://github.com/echasnovski/mini.nvim"
    :config (fn []
              (let [mini-pairs (require :mini.pairs)
                    mini-trailspace (require :mini.trailspace)
                    mini-comment (require :mini.comment)]
                (mini-pairs.setup)
                (mini-trailspace.setup)
                (mini-comment.setup)))}
   {:url "https://github.com/ibhagwan/fzf-lua"
    :config {:winopts {:border :single}
             :global_git_icons false
             :global_file_icons false}}
   {:url "https://github.com/tpope/vim-eunuch"}
   {:url "https://github.com/ggandor/leap.nvim"
    :config (fn []
              (let [leap (require :leap)]
                (leap.add_default_mappings)))}
   {:url "https://github.com/tpope/vim-surround"}
   {:url "https://github.com/tpope/vim-unimpaired"}
   {:url "https://github.com/tpope/vim-abolish"}
   {:url "https://github.com/tpope/vim-repeat"}
   {:url "https://github.com/rktjmp/lush.nvim"}
   {:url "https://github.com/stefanvanburen/rams"}
   {:url "https://git.sr.ht/~p00f/alabaster.nvim"}
   {:url "https://github.com/jaredgorski/Mies.vim"}
   {:url "https://github.com/mcchrish/zenbones.nvim"}])

;;; settings for plugins

;; because I commonly zoom tmux windows, and Dispatch will create a new window
;; when within tmux, the default setting would unzoom my tmux. Turn it off.
(set vim.g.dispatch_no_tmux_make 1)

;; using open-browser.vim for `gx`
(set vim.g.netrw_nogx 1)

;; vim-test x dispatch
(set vim.g.test#strategy "dispatch")

;; disable vim-surround's default mappings, replacing most of
;; them in mapping.fnl, to work with leap.nvim.
(set vim.g.surround_no_mappings 1)

;; Remove legacy fugitive commands (which only result in warnings, rather than something useful)
(set vim.g.fugitive_legacy_commands 0)
