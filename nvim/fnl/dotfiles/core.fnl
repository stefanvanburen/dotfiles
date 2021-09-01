(module dotfiles.core
  {autoload {nvim aniseed.nvim
             str aniseed.string}
   require-macros [dotfiles.macros]})

;; on resize, resize windows
(nvim.ex.autocmd :VimResized   :* ":wincmd =")

;; show yanked text
(nvim.ex.autocmd :TextYankPost :* "lua require'vim.highlight'.on_yank()")

;; after writing init.lua, recompile
(nvim.ex.autocmd :BufWritePost :init.lua "PackerCompile")

(augroup filetypes
         (do
           (autocmd :FileType :go "setlocal noexpandtab tabstop=4 shiftwidth=4")
           (autocmd :FileType :python "setlocal tabstop=4 shiftwidth=4 expandtab")
           (autocmd :FileType :javascript "setlocal expandtab tabstop=2 shiftwidth=2")
           (autocmd :FileType :typescript "setlocal tabstop=2 shiftwidth=2 expandtab")
           (autocmd :FileType :typescriptreact "setlocal tabstop=2 shiftwidth=2 expandtab")
           (autocmd :FileType :html "setlocal expandtab tabstop=2 shiftwidth=2")
           (autocmd :FileType :css "setlocal expandtab tabstop=2 shiftwidth=2 iskeyword+=-")
           (autocmd :FileType :scss "setlocal expandtab tabstop=2 shiftwidth=2 iskeyword+=-")
           (autocmd :FileType :fish "setlocal expandtab tabstop=4 shiftwidth=4")
           (autocmd :FileType :yaml "setlocal expandtab tabstop=2 shiftwidth=2")
           (autocmd :FileType :gitcommit "setlocal spell")
           (autocmd :FileType :sql "setlocal wrap")
           (autocmd :FileType :markdown "setlocal spell wrap conceallevel=2")))

(defn- opt [name value]
  (tset vim.o name value))

(defn- wopt [name value]
  (tset vim.wo name value)
  (opt name value))

(defn- bopt [name value]
  (tset vim.bo name value)
  (opt name value))

;; colorscheme
(opt :termguicolors true)
(nvim.ex.colorscheme :rams)
(opt :background :light)

;; don't wrap by default
(wopt :wrap false)

;; always show the completion menu, and when it's brought up, don't select
;; anything by default.
(opt :completeopt (str.join "," ["menuone" "noselect"]))

;; if wrap is set, break on characters in 'breakat' rather than the last
;; character that will fit on the screen.
;; This _should_ mean that lines generally break on words
(wopt :linebreak true)
;; on lines that will wrap, they instead 'break' and be visually indented by
;; the showbreak character, followed by the indent.
(wopt :breakindent true)
(wopt :breakindentopt "shift:2,sbr")
(opt :showbreak "↳")

;; when using > and <, round the indent to a multiple of shiftwidth
(opt :shiftround true)

;; statusline current ' '
;; statusline not current ' '
;; vertical empty (escaped space)
;; fold: filling foldtext
;; diff: deleted lines in diff
(wopt :fillchars (str.join "," ["stl: "
                                "stlnc: "
                                "vert:│"
                                "fold:·"
                                "diff:-"]))

;; fold based on syntax cues
(wopt :foldmethod :syntax)
;; turn off folding by default
(wopt :foldenable false)

;; Global substitutions by default.
(opt :gdefault true)

;; Don't get rid of hidden buffers
(opt :hidden true)

;; show incremental substitutions inline
(opt :inccommand "nosplit")

;; Ignore case while searching
(opt :ignorecase true)
;; ... except when capitals are used
(opt :smartcase true)

;; Copy the indent of existing lines when autoindenting
(opt :copyindent true)

;; how long to wait in milliseconds before writing to disk
;; this is set lower to help plugins like vim-gitgutter update their signs
(opt :updatetime 100)

;; Helps when doing insert-mode completion
(bopt :infercase true)

;; Don't redraw when using macros.
(opt :lazyredraw false)

;; Invisible characters
(wopt :list false)
(wopt :listchars (str.join "," ["tab:⌁ " "eol:¬" "trail:⣿"]))

;; Don't insert two spaces after punctuation with a join command.
(opt :joinspaces false)

;; Don't show the mode on the command line - it's redundant with the status line.
(opt :showmode false)

;; line numbers
;; setting these both together means that the current line number is the actual
;; line number of the file, while the other line numbers are relative.
(wopt :number true)
(wopt :relativenumber true)

;; maintain an undofile for undoing actions through neovim loads
(bopt :undofile true)

;; Show matching brackets briefly.
(opt :showmatch true)

;; On horizontal split, open the split below.
(opt :splitbelow true)
;; On vertical split, open the split to the right.
(opt :splitright true)

;; cobbled from https://github.com/liuchengxu/vim-better-default
;; o: disables
;; c: no ins-completion-menu messages
(opt :shortmess "atOIoc")

;; turn on mouse support
;; this is useful for resizing windows, using the mouse wheel to scroll, etc
(opt :mouse "a")

;; always use the system clipboard for operations
; set clipboard+=unnamedplus
(opt :clipboard "unnamedplus")

;; turn off swapfiles - for now, I find these more of a headache than a benefit
(bopt :swapfile false)

;; Convenience for automatic formatting.
;;   r - auto-insert comment leading after <CR> in insert mode
;;   o - auto-insert comment leading after O in normal mode
;;   n - recognize numbered lists in text
(bopt :formatoptions "tcqjron")

;; allows moving the cursor to where there is no actual character
(opt :virtualedit "all")

;; ignore case when completing files / directories in wildmenu
(opt :wildignorecase true)

;;; settings for plugins

; (set nvim.g.go_gopls_enabled 1)
;; because we've disabled gopls, use goimports as fixer on save.
(set nvim.g.go_fmt_command "goimports")
;; run goimports on save for go files
(set nvim.g.go_fmt_autosave 1)

;; This has to be set so the entire package is linted (otherwise, staticcheck)
;; won't grab identifiers declared in other files).
(set nvim.g.ale_go_staticcheck_lint_package 1)

(set nvim.g.ale_disable_lsp 1)
(set nvim.g.ale_sign_error "×")
(set nvim.g.ale_sign_warning "→")
(set nvim.g.ale_sign_info "→")
(set nvim.g.ale_echo_msg_format "%linter%: %s")

;; in general, this is the right thing to do
(set nvim.g.ale_fix_on_save 1)

(set nvim.g.ale_virtualtext_cursor 1)
(set nvim.g.ale_virtualtext_prefix  "∴ ")
(set nvim.g.ale_linters {:clojure [:clj-kondo]
                         :go [:gopls :staticcheck]
                         :javascript [:eslint :xo]
                         :javascriptreact [:eslint :xo]
                         :typescript [:eslint :xo]
                         :typescriptreact [:eslint :xo]
                         :python [:flake8 :mypy]
                         :rust [:cargo :analyzer]})

(set nvim.g.ale_fixers {:go [:goimports]
                        :javascript [:prettier :eslint :xo]
                        :javascriptreact [:prettier :eslint :xo]
                        :typescript [:prettier :eslint :xo]
                        :typescriptreact [:xo]
                        :python [:black :isort]
                        :cpp [:clang-format]})

;; because I commonly zoom tmux windows, and Dispatch will create a new window
;; when within tmux, the default setting would unzoom my tmux. Turn it off.
(set nvim.g.dispatch_no_tmux_make 1)

(set nvim.g.Hexokinase_highlighters [:virtual])
(set nvim.g.Hexokinase_ftEnabled [:css :scss])

(set nvim.g.vim_json_syntax_conceal 1)

(set nvim.g.matchup_matchparen_offscreen {})

(set nvim.g.vimtex_compiler_method "tectonic")

(set nvim.g.sneak#s_next 1)

(set nvim.g.pear_tree_repeatable_expand 0)
;; disable pear-tree for lispy languages, covered by parinfer
(set nvim.g.pear_tree_ft_disabled [:clojure :fennel])

(set nvim.g.netrw_nogx 1)

;; fzf
(set nvim.g.fzf_layout {:window {:width 1.0 :height 0.5 :yoffset 1.0 :border :top}})

;; vim-test x dispatch
(set nvim.g.test#strategy "dispatch")

;; conjure
(set nvim.g.conjure#extract#tree_sitter#enabled true)
