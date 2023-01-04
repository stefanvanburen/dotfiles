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
  :wbthomason/packer.nvim {} ; Let packer manage itself.
  :justinmk/vim-dirvish {}
  :tyru/open-browser.vim {}
  :lewis6991/gitsigns.nvim {:mod :gitsigns}
  :tpope/vim-fugitive {}
  :tpope/vim-rhubarb {}
  :mattn/vim-gotmpl {}
  :dstein64/vim-startuptime {}
  :Olical/aniseed {}
  :lewis6991/impatient.nvim {}
  :Olical/conjure {}
  :gpanders/nvim-parinfer {}
  :neovim/nvim-lspconfig {}
  :williamboman/mason.nvim {:mod :mason}
  :williamboman/mason-lspconfig.nvim {:mod :mason-lspconfig}
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate" :mod :treesitter}
  :jose-elias-alvarez/null-ls.nvim {:mod :null-ls :requires [[:nvim-lua/plenary.nvim]]}
  :tpope/vim-dispatch {}
  :vim-test/vim-test {}
  :echasnovski/mini.nvim {:mod :mini}
  :ibhagwan/fzf-lua {:mod :fzf}
  :tpope/vim-commentary {}
  :tpope/vim-eunuch {}
  :ggandor/leap.nvim {:mod :leap}
  :tpope/vim-surround {}
  :tpope/vim-unimpaired {}
  :tpope/vim-abolish {}
  :tpope/vim-repeat {}
  :rktjmp/lush.nvim {}
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
