(module dotfiles.plugin
    {autoload {a aniseed.core
               packer packer}})

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
            (use (a.assoc opts 1 name))))))))

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
  ;; ]c / [c to go to hunks within a file
  :airblade/vim-gitgutter {}

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

  ;; install LSP servers
  :kabouzeid/nvim-lspinstall {}

  :nvim-treesitter/nvim-treesitter
  {:run ":TSUpdate"
   :config (fn []
             (. (require "nvim-treesitter.configs") :setup)
             {:ensure_installed "maintained"
              :highlight {:enabled true}})}

  ;; Automatically match parenthesis
  :tmsvg/pear-tree {}

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

  ;; adds useful `f` and `t` operators
  :justinmk/vim-sneak {}

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

  ;; colorscheme
  :stefanvanburen/rams.vim {})
