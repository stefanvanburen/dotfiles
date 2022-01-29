(module dotfiles.plugin
    {autoload {a aniseed.core
               nvim aniseed.nvim
               str aniseed.string
               packer packer}})

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

(def- lisp-filetypes [:clojure :fennel :lisp])

(use
  :wbthomason/packer.nvim {}

  ;; directory / file viewer. Largely replaces netrw.
  :justinmk/vim-dirvish {}

  ;; Adds git added / modified / deleted in the sidebar (amongst other things)
  :lewis6991/gitsigns.nvim
  {:requires [[:nvim-lua/plenary.nvim]]
   :mod :gitsigns}

  ;; Better whitespace highlighting / provides :StripWhitespace
  :ntpeters/vim-better-whitespace {}

  ;; git!
  :tpope/vim-fugitive {}
  ;; GitHub!
  :tpope/vim-rhubarb {}

  ;; Speed up filetype loading.
  :nathom/filetype.nvim {}

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
  ;; https://github.com/othree/html5.vim
  ;; HTML5 and SVG autocomplete and syntax highlighting
  :othree/html5.vim {}
  ;; https://github.com/hail2u/vim-css3-syntax
  ;; Unsure if this plugin is _much_ better than the default CSS files, but is
  ;; well maintained.
  ;; https://github.com/hail2u/vim-css3-syntax/issues/65
  :hail2u/vim-css3-syntax {}
  ;; https://github.com/pangloss/vim-javascript
  ;; "Vastly improved Javascript indentation and syntax support in Vim."
  :pangloss/vim-javascript {}
  ;; https://github.com/tmux-plugins/vim-tmux
  ;; "vim plugin for tmux.conf"
  ;; Simple, useful. Not updated all that often, but probably fine? And I doubt
  ;; there's a built-in runtime file for .tmux.conf?
  :tmux-plugins/vim-tmux {}

  ;; up-to-date git filetypes
  :tpope/vim-git {}

  ;; https://github.com/fatih/vim-go
  ;; "Vim development plugin for Go"
  :fatih/vim-go {:run ":GoInstallBinaries"}

  ;; profiling startup time
  :dstein64/vim-startuptime {}

  ;; configuration in fennel
  :Olical/aniseed {}

  ;; https://github.com/lewis6991/impatient.nvim
  ;; > Speed up loading Lua modules in Neovim to improve startup time.
  :lewis6991/impatient.nvim {}

  ;; lisp languages
  :guns/vim-sexp {:ft lisp-filetypes}
  :tpope/vim-sexp-mappings-for-regular-people {:ft lisp-filetypes}
  :Olical/conjure {:ft lisp-filetypes}
  :eraserhd/parinfer-rust {:run "cargo build --release"
                           :ft lisp-filetypes}

  ;; typical lsp configurations
  :neovim/nvim-lspconfig {}
  ;; installation and management of LSP servers
  :williamboman/nvim-lsp-installer {}

  ;; https://github.com/nvim-treesitter/nvim-treesitter
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"
                                    :mod :treesitter}

  ;; Automatically match parenthesis
  :tmsvg/pear-tree {}

  ;; testing / build commands
  :tpope/vim-dispatch {}
  :vim-test/vim-test {}

  ;; fuzzy find
  :junegunn/fzf {}
  :junegunn/fzf.vim {}

  ;; Commenting
  :tpope/vim-commentary {}

  ;; Adds unix shell commands
  :tpope/vim-eunuch {}

  ;; motion plugin, in the vein of clever-f and vim-sneak
  :ggandor/lightspeed.nvim {}

  ;; Deal with parentheses, quotes, etc.
  :tpope/vim-surround {}

  ;; Repeat plugin maps
  :tpope/vim-repeat {}

  ;; Handy bracket ( ] and [ ) mappings
  :tpope/vim-unimpaired {}

  ;; enhanced version of matchit plugin
  :andymass/vim-matchup {}

  ;; Easily search for, substitute, and abbreviate multiple variants of a word
  :tpope/vim-abolish {}

  ;; colorscheme creation
  :rktjmp/lush.nvim {}

  ;; colorscheme
  :stefanvanburen/rams {})

;;; settings for plugins

;; run goimports on save for go files
(set nvim.g.go_fmt_autosave 1)

;; because I commonly zoom tmux windows, and Dispatch will create a new window
;; when within tmux, the default setting would unzoom my tmux. Turn it off.
(set nvim.g.dispatch_no_tmux_make 1)

;; Disable matchup's offscreen feature, which usually replaces the statusline
;; with the match.
(set nvim.g.matchup_matchparen_offscreen {})

(set nvim.g.pear_tree_repeatable_expand 0)
;; disable pear-tree for lispy languages, covered by parinfer
(set nvim.g.pear_tree_ft_disabled lisp-filetypes)

;; using open-browser.vim for `gx`
(set nvim.g.netrw_nogx 1)

;; vim-test x dispatch
(set nvim.g.test#strategy "dispatch")

;; vim-sexp & vim-sexp-mappings-for-regular-people
(set nvim.g.sexp_filetypes (str.join "," lisp-filetypes))
;; These mappings conflict with parinfer.
(set nvim.g.sexp_enable_insert_mode_mappings 0)
