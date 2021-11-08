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

  :rrethy/vim-hexokinase {:run "make hexokinase"
                          :opt true
                          :ft ["css" "scss"]}

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

  ;; Better commit message editing
  :rhysd/committia.vim {}

  ;; git!
  :tpope/vim-fugitive {}
  ;; GitHub!
  :tpope/vim-rhubarb {}

  :w0rp/ale {}

  ;; Allows for viewing git commit messages related to the current line
  ;; <leader>gm to trigger the window, again to go inside.
  :rhysd/git-messenger.vim {}

  ;; language support
  :blankname/vim-fish {}
  :othree/html5.vim {}
  :hail2u/vim-css3-syntax {}
  :pangloss/vim-javascript {}
  :maxmellon/vim-jsx-pretty {}
  :HerringtonDarkholme/yats.vim {}
  :plasticboy/vim-markdown {}
  :cespare/vim-toml {}
  :rust-lang/rust.vim {:ft ["rust"]}
  :ziglang/zig.vim {}
  :tmux-plugins/vim-tmux {}
  :hashivim/vim-terraform {}
  ;; up-to-date git filetypes
  :tpope/vim-git {}

  :fatih/vim-go {:run ":GoInstallBinaries"}

  ;; profiling startup time
  :dstein64/vim-startuptime {}

  ;; configuration in fennel
  :Olical/aniseed {}

  ;; lisp languages
  :guns/vim-sexp {}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :Olical/conjure {:ft ["clojure" "fennel"]}
  :eraserhd/parinfer-rust {:run "cargo build --release"}

  ;; faster version of filetype.vim
  ;; sets vim.g.did_load_filetypes in init.lua
  :nathom/filetype.nvim {}

  ;; typical lsp configurations
  :neovim/nvim-lspconfig {}

  :williamboman/nvim-lsp-installer {}

  :nvim-treesitter/nvim-treesitter
  {:run ":TSUpdate"
   :config (fn []
             (. (require "nvim-treesitter.configs") :setup)
             {:ensure_installed "maintained"
              :autotag {:enable true}
              :highlight {:enabled true}})}

  ;; Automatically match parenthesis and tags
  :windwp/nvim-autopairs {:mod :autopairs}
  :windwp/nvim-ts-autotag {:mod :autotag}

  ;; testing / build commands
  :tpope/vim-dispatch {}
  :vim-test/vim-test {}
  :radenling/vim-dispatch-neovim {}

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

(nvim.ex.colorscheme :rams)

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

(set nvim.g.ale_linters {:clojure []
                         :go [:staticcheck]
                         :python [:flake8 :mypy]
                         :rust []})

(set nvim.g.ale_fixers {:go []
                        :python [:black :isort]
                        :cpp [:clang-format]})

;; because I commonly zoom tmux windows, and Dispatch will create a new window
;; when within tmux, the default setting would unzoom my tmux. Turn it off.
(set nvim.g.dispatch_no_tmux_make 1)

;; Disable matchup's offscreen feature, which usually replaces the statusline
;; with the match.
(set nvim.g.matchup_matchparen_offscreen {})

;; using open-browser.vim for `gx`
(set nvim.g.netrw_nogx 1)

;; vim-test x dispatch
(set nvim.g.test#strategy "dispatch")
