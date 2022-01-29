(module dotfiles.plugin
    {autoload {a aniseed.core
               nvim aniseed.nvim
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

(use
  :wbthomason/packer.nvim {}

  ;; directory / file viewer. Largely replaces netrw.
  :justinmk/vim-dirvish {}

  ;; for `gx`
  :tyru/open-browser.vim {}

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

  ;; lints and fixes text files.
  ;; Also provides an LSP integration, but that is turned off in favor of
  ;; nvim's builtin LSP client.
  :w0rp/ale {}

  ;; Allows for viewing git commit messages related to the current line
  ;; <leader>gm to trigger the window, again to go inside.
  :rhysd/git-messenger.vim {}

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

  :lewis6991/impatient.nvim {}

  ;; lisp languages
  :guns/vim-sexp {}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :Olical/conjure {:ft ["clojure" "fennel"]}
  :eraserhd/parinfer-rust {:run "cargo build --release"}

  ;; typical lsp configurations
  :neovim/nvim-lspconfig {}
  ;; installation and management of LSP servers
  :williamboman/nvim-lsp-installer {}

  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"
                                    :mod :treesitter}

  ;; Automatically match parenthesis
  :tmsvg/pear-tree {}

  ;; testing / build commands
  :tpope/vim-dispatch {}
  :vim-test/vim-test {}
  :radenling/vim-dispatch-neovim {}

  ;; Better :marks experience
  :chentau/marks.nvim {:mod :marks}

  ;; fuzzy find
  :junegunn/fzf {}
  :junegunn/fzf.vim {}

  ;; Commenting
  :tpope/vim-commentary {}

  ;; Adds unix shell commands
  :tpope/vim-eunuch {}

  ;; motion plugin, in the vein of clever-f and vim-sneak
  :ggandor/lightspeed.nvim {}

  ;; Database access
  :tpope/vim-dadbod {:opt true :cmd "DB"}

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

;; This has to be set so the entire package is linted (otherwise, staticcheck)
;; won't grab identifiers declared in other files).
(set nvim.g.ale_go_staticcheck_lint_package 1)

;; disable all linters powered by LSP
;; instead, this is handled by the built-in neovim LSP client
(set nvim.g.ale_disable_lsp 1)

;; ale formatting
(set nvim.g.ale_sign_error "×")
(set nvim.g.ale_sign_warning "→")
(set nvim.g.ale_sign_info "→")
(set nvim.g.ale_echo_msg_format "%linter%: %s")
(set nvim.g.ale_virtualtext_cursor 1)
(set nvim.g.ale_virtualtext_prefix "∴ ")

;; in general, this is the right thing to do
(set nvim.g.ale_fix_on_save 1)

(set nvim.g.ale_linters
     {;; clojure is handled by clojure-lsp, which bakes in clj-kondo:
      ;; https://clojure-lsp.io/settings/#clj-kondo
      :clojure []
      ;; staticcheck is handled by gopls, experimentally.
      ;; We'll see if it becomes not experimental in the future.
      :go []
      ;; linting JS/TS is handled by installing the `eslint` language server.
      :javascript []
      :typescript []
      ;; python, as far as I can tell, does not have great LSP integration. So,
      ;; for now, everything goes through ALE.
      :python [:flake8 :mypy]
      ;; rust is handled by rust-analyzer, which is via the LSP client.
      :rust []})

(set nvim.g.ale_fixers
     {;; Handled via `gopls`.
      :go []
      ;; fixing JS/TS is handled by installing the `eslint` language server.
      :javascript []
      :typescript []
      ;; Similar story as above - not great LSP integration, so use ALE as a fixer.
      :python [:black :isort]})

;; because I commonly zoom tmux windows, and Dispatch will create a new window
;; when within tmux, the default setting would unzoom my tmux. Turn it off.
(set nvim.g.dispatch_no_tmux_make 1)

;; Disable matchup's offscreen feature, which usually replaces the statusline
;; with the match.
(set nvim.g.matchup_matchparen_offscreen {})

(set nvim.g.pear_tree_repeatable_expand 0)
;; disable pear-tree for lispy languages, covered by parinfer
(set nvim.g.pear_tree_ft_disabled [:clojure :fennel])

;; using open-browser.vim for `gx`
(set nvim.g.netrw_nogx 1)

;; vim-test x dispatch
(set nvim.g.test#strategy "dispatch")

;; vim-sexp & vim-sexp-mappings-for-regular-people
(set nvim.g.sexp_filetypes "clojure,lisp,fennel")
;; These mappings conflict with parinfer.
(set nvim.g.sexp_enable_insert_mode_mappings 0)
