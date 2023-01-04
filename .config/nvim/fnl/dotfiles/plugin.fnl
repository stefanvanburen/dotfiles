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
  "https://github.com/wbthomason/packer.nvim" {} ; Let packer manage itself.
  "https://github.com/justinmk/vim-dirvish" {}
  "https://github.com/tyru/open-browser.vim" {}
  "https://github.com/lewis6991/gitsigns.nvim" {:mod :gitsigns}
  "https://github.com/tpope/vim-fugitive" {}
  "https://github.com/tpope/vim-rhubarb" {}
  "https://github.com/mattn/vim-gotmpl" {}
  "https://github.com/dstein64/vim-startuptime" {}
  "https://github.com/Olical/aniseed" {}
  "https://github.com/lewis6991/impatient.nvim" {}
  "https://github.com/Olical/conjure" {}
  "https://github.com/gpanders/nvim-parinfer" {}
  "https://github.com/neovim/nvim-lspconfig" {}
  "https://github.com/williamboman/mason.nvim" {:mod :mason}
  "https://github.com/williamboman/mason-lspconfig.nvim" {:mod :mason-lspconfig}
  "https://github.com/nvim-treesitter/nvim-treesitter" {:run ":TSUpdate" :mod :treesitter}
  "https://github.com/jose-elias-alvarez/null-ls.nvim" {:mod :null-ls :requires [[:nvim-lua/plenary.nvim]]}
  "https://github.com/tpope/vim-dispatch" {}
  "https://github.com/vim-test/vim-test" {}
  "https://github.com/echasnovski/mini.nvim" {:mod :mini}
  "https://github.com/ibhagwan/fzf-lua" {:mod :fzf}
  "https://github.com/tpope/vim-commentary" {}
  "https://github.com/tpope/vim-eunuch" {}
  "https://github.com/ggandor/leap.nvim" {:mod :leap}
  "https://github.com/tpope/vim-surround" {}
  "https://github.com/tpope/vim-unimpaired" {}
  "https://github.com/tpope/vim-abolish" {}
  "https://github.com/tpope/vim-repeat" {}
  "https://github.com/rktjmp/lush.nvim" {}
  "https://github.com/stefanvanburen/rams" {}
  "https://git.sr.ht/~p00f/alabaster.nvim" {}
  "https://github.com/jaredgorski/Mies.vim" {}
  "https://github.com/mcchrish/zenbones.nvim" {})

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
