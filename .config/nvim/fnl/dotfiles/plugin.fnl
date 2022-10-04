(module dotfiles.plugin
    {autoload {a aniseed.core
               str aniseed.string
               : packer}})

(defn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :dotfiles.plugin. name))]
    (when (not ok?)
      (print (.. "dotfiles error: " val-or-err)))))

(defn- use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name)))))))
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

  ;;; language support
  ;;; neovim has a variety of supported languages, but the ones included in
  ;;; https://github.com/neovim/neovim/tree/master/runtime/ftplugin are
  ;;; typically out of date, or don't exist, and so many languages need plugins
  ;;; to stay up-to-date.

  ;; https://github.com/blankname/vim-fish
  ;; at one point, this seemed to be the most up to date fork of dag/vim-fish,
  ;; but now I'm not so sure. Unfortunately there isn't a better one that I
  ;; know of.
  :blankname/vim-fish {}
  ;; https://github.com/ericpruitt/tmux.vim
  ;; "Vim syntax file for tmux configuration files"
  :ericpruitt/tmux.vim {}
  ;; https://github.com/wfxr/protobuf.vim
  ;; "protobuf with gRPC, grpc-gateway and grpc-swagger support"
  :wfxr/protobuf.vim {}
  ;; https://github.com/lifepillar/pgsql.vim
  ;; "Vim PostgreSQL syntax plugin"
  :lifepillar/pgsql.vim {}

  ;; syntax for gotmpl files
  :mattn/vim-gotmpl {}

  ;; Run `goimports` on save.
  :mattn/vim-goimports {:run ":MasonInstall goimports"
                        :requires [[:williamboman/mason.nvim]]}

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
  :clojure-vim/clojure.vim {}

  ;; installation and management of tooling
  :williamboman/mason.nvim {:requires [[:williamboman/mason-lspconfig.nvim]]
                            :mod :mason}

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

  ;; "general-purpose motion plugin for neovim ... streamlined version of lightspeed"
  :ggandor/leap.nvim {:mod :leap}

  ;; Deal with parentheses, quotes, etc.
  :tpope/vim-surround {}

  ;; Handy bracket ( ] and [ ) mappings
  :tpope/vim-unimpaired {}

  ;; enhanced version of matchit plugin
  :andymass/vim-matchup {}

  ;; Easily search for, substitute, and abbreviate multiple variants of a word
  :tpope/vim-abolish {}

  ;; colorscheme creation
  :rktjmp/lush.nvim {}

  ;; colorschemes
  :stefanvanburen/rams {}
  :mcchrish/zenbones.nvim {})

;;; settings for plugins

;; because I commonly zoom tmux windows, and Dispatch will create a new window
;; when within tmux, the default setting would unzoom my tmux. Turn it off.
(set vim.g.dispatch_no_tmux_make 1)

;; Disable matchup's offscreen feature, which usually replaces the statusline
;; with the match.
(set vim.g.matchup_matchparen_offscreen {})

;; using open-browser.vim for `gx`
(set vim.g.netrw_nogx 1)

;; vim-test x dispatch
(set vim.g.test#strategy "dispatch")

;; disable vim-surround's default mappings, replacing most of
;; them in mapping.fnl, to work with leap.nvim.
(set vim.g.surround_no_mappings 1)

;; default *.sql files to postgres filetype
(set vim.g.sql_type_default "pgsql")
