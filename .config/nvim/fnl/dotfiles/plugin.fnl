(module dotfiles.plugin
    {autoload {a aniseed.core
               : packer}})

(fn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :dotfiles.plugin. name))]
    (when (not ok?)
      (print (.. "dotfiles error: " val-or-err)))))

(fn use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup
      {1 (fn [use]
           (for [i 1 (a.count pkgs) 2]
             (let [name (. pkgs i)
                   opts (. pkgs (+ i 1))]
               (-?> (. opts :mod) (safe-require-plugin-config))
               (use (a.assoc opts 1 name)))))
       :config {:display {:open_fn (fn []
                                    ((. (require :packer.util)
                                        :float)
                                     {:border :single}))}}}))
  nil)

(use
  ;; Let packer manage itself.
  :wbthomason/packer.nvim {}

  ;; directory / file viewer. Largely replaces netrw.
  :justinmk/vim-dirvish {}

  ;; for `gx`, and `:GBrowse`
  :tyru/open-browser.vim {}

  ;; Adds git added / modified / deleted in the sidebar (amongst other things)
  :lewis6991/gitsigns.nvim {:mod :gitsigns}

  ;; git!
  :tpope/vim-fugitive {}
  ;; GitHub!
  :tpope/vim-rhubarb {}

  ;; syntax for gotmpl files
  :mattn/vim-gotmpl {}

  ;; profiling startup time
  :dstein64/vim-startuptime {}

  ;; configuration in fennel
  :Olical/aniseed {}

  ;; https://github.com/lewis6991/impatient.nvim
  ;; > Speed up loading Lua modules in Neovim to improve startup time.
  :lewis6991/impatient.nvim {}

  ;; lisp languages
  :Olical/conjure {}
  :gpanders/nvim-parinfer {}

  ;; typical lsp configurations
  :neovim/nvim-lspconfig {}
  ;; installation and management of neovim tooling
  :williamboman/mason.nvim {:mod :mason}
  :williamboman/mason-lspconfig.nvim {:mod :mason-lspconfig}

  ;; https://github.com/nvim-treesitter/nvim-treesitter
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"
                                    :mod :treesitter}

  ;; LSP-capabilities for tools that don't support LSP
  :jose-elias-alvarez/null-ls.nvim {:mod :null-ls
                                    :requires [[:nvim-lua/plenary.nvim]]}

  ;; testing / build commands
  :tpope/vim-dispatch {}
  :vim-test/vim-test {}

  :windwp/nvim-autopairs {:mod :autopairs}

  ;; fuzzy find
  :ibhagwan/fzf-lua {:mod :fzf}

  ;; Commenting
  :tpope/vim-commentary {}

  ;; Adds unix shell commands
  :tpope/vim-eunuch {}

  ;; > general-purpose motion plugin for neovim ... streamlined version of lightspeed
  :ggandor/leap.nvim {:mod :leap}
  ;; > f/F/t/T motions on steroids, building on the Leap interface.
  :ggandor/flit.nvim {:mod :flit}

  ;; Deal with parentheses, quotes, etc.
  :tpope/vim-surround {}

  ;; Handy bracket ( ] and [ ) mappings
  :tpope/vim-unimpaired {}

  ;; Easily search for, substitute, and abbreviate multiple variants of a word
  :tpope/vim-abolish {}

  ;; Repeat plugin actions
  :tpope/vim-repeat {}

  ;; colorscheme creation
  :rktjmp/lush.nvim {}

  ;; colorschemes
  :stefanvanburen/rams {}
  "https://git.sr.ht/~p00f/alabaster.nvim" {}
  :jaredgorski/Mies.vim {}
  :mcchrish/zenbones.nvim {})

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
