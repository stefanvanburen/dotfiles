(module dotfiles.module.core
  {require {nvim aniseed.nvim
            str aniseed.string
            a aniseed.core}
   require-macros [dotfiles.macros]})

;; on resize, resize windows
(nvim.ex.autocmd :VimResized   :* ":wincmd =")

;; show yanked text
(nvim.ex.autocmd :TextYankPost :* "lua require'vim.highlight'.on_yank()")

;; after writing init.lua, recompile
(nvim.ex.autocmd :BufWritePost :init.lua "PackerCompile")

(augroup filetypes
         (do
           (autocmd :FileType :go "set noexpandtab tabstop=4 shiftwidth=4")
           (autocmd :FileType :python "set tabstop=4 shiftwidth=4 expandtab")
           (autocmd :FileType :javascript "set expandtab tabstop=2 shiftwidth=2")
           (autocmd :FileType :typescript "set tabstop=2 shiftwidth=2 expandtab")
           (autocmd :FileType :typescriptreact "set tabstop=2 shiftwidth=2 expandtab")
           (autocmd :FileType :html "set expandtab tabstop=2 shiftwidth=2")
           (autocmd :FileType :css "set expandtab tabstop=2 shiftwidth=2 iskeyword+=-")
           (autocmd :FileType :fish "set expandtab tabstop=4 shiftwidth=4")
           (autocmd :FileType :yaml "set expandtab tabstop=2 shiftwidth=2")
           (autocmd :FileType :gitcommit "set spell")
           (autocmd :FileType :markdown "set spell wrap conceallevel=2")))

;; colorscheme
(set nvim.o.termguicolors true)
(nvim.ex.colorscheme :rams)
(set nvim.o.background :light)

;; don't wrap by default
(nvim.ex.set :nowrap)

;; if wrap is set, break on characters in 'breakat' rather than the last
;; character that will fit on the screen.
;; This _should_ mean that lines generally break on words
(nvim.ex.set :linebreak)
;; on lines that will wrap, they instead 'break' and be visually indented by
;; the showbreak character, followed by the indent.
(nvim.ex.set :breakindent)
(set nvim.o.breakindentopt "shift:2,sbr")
(set nvim.o.showbreak "↳")

;; when using > and <, round the indent to a multiple of shiftwidth
(nvim.ex.set :shiftround)

;; statusline current ' '
;; statusline not current ' '
;; vertical empty (escaped space)
;; fold: filling foldtext
;; diff: deleted lines in diff
(set nvim.o.fillchars
     (str.join "," ["stl: "
                    "stlnc: "
                    "vert:│"
                    "fold:·"
                    "diff:-"]))

;; fold based on syntax cues
(set nvim.o.foldmethod :syntax)
;; turn off folding by default
(nvim.ex.set :nofoldenable)

;; Global substitutions by default.
(nvim.ex.set :gdefault)

;; Don't get rid of hidden buffers
(nvim.ex.set :hidden)

;; show incremental substitutions in a preview window
;; NOTE: trying this out provisionally
(set nvim.o.inccommand "split")

;; Ignore case while searching
(nvim.ex.set :ignorecase)
;; ... except when capitals are used
(nvim.ex.set :smartcase)

;; Copy the indent of existing lines when autoindenting
(nvim.ex.set :copyindent)

;; how long to wait in milliseconds before writing to disk
;; this is set lower to help plugins like vim-gitgutter update their signs
(set nvim.o.updatetime 100)

;; Helps when doing insert-mode completion
(nvim.ex.set :infercase)

;; Don't redraw when using macros.
(nvim.ex.set :nolazyredraw)

;; Invisible characters
(nvim.ex.set :nolist)
(set nvim.o.listchars (str.join "," ["tab:⌁ " "eol:¬" "trail:⣿"]))

;; Don't insert two spaces after punctuation with a join command.
(nvim.ex.set :nojoinspaces)

;; Don't show the mode on the command line - it's redundant with the status line.
(nvim.ex.set :noshowmode)

;; line numbers
;; setting these both together means that the current line number is the actual
;; line number of the file, while the other line numbers are relative.
(nvim.ex.set :number)
(nvim.ex.set :relativenumber)

;; maintain an undofile for undoing actions through neovim loads
(nvim.ex.set :undofile)

;; Show matching brackets briefly.
(nvim.ex.set :showmatch)

;; On horizontal split, open the split below.
(nvim.ex.set :splitbelow)
;; On vertical split, open the split to the right.
(nvim.ex.set :splitright)

;; cobbled from https://github.com/liuchengxu/vim-better-default
;; o: disables
;; c: no ins-completion-menu messages
(set nvim.o.shortmess "atOIoc")

;; turn on mouse support
;; this is useful for resizing windows, using the mouse wheel to scroll, etc
(set nvim.o.mouse "a")

;; always use the system clipboard for operations
; set clipboard+=unnamedplus
(set nvim.o.clipboard "unnamedplus")

;; turn off swapfiles - for now, I find these more of a headache than a benefit
(nvim.ex.set :noswapfile)

;; Convenience for automatic formatting.
;;   r - auto-insert comment leading after <CR> in insert mode
;;   o - auto-insert comment leading after O in normal mode
; set formatoptions+=r
; set formatoptions+=o
(set nvim.o.formatoptions (str.join "," (a.concat (str.split nvim.o.formatoptions ",") ["r" "o"])))

;; allows moving the cursor to where there is no actual character
(set nvim.o.virtualedit "all")

;; ignore case when completing files / directories in wildmenu
(nvim.ex.set :wildignorecase)

;; settings for plugins
(set nvim.g.deoplete#enabled_at_startup 1)

(set nvim.g.go_gopls_enabled 0)

(set nvim.g.ale_disable_lsp 1)

(set nvim.g.dispatch_no_tmux_make 1)

(set nvim.g.Hexokinase_highlighters [:virtual])
(set nvim.g.Hexokinase_ftEnabled [:css :scss])

(set nvim.g.vim_json_syntax_conceal 1)

(set nvim.g.matchup_matchparen_offscreen {})

(set nvim.g.vimtex_compiler_method "tectonic")

(set nvim.g.sneak#s_next 1)

(set nvim.g.pear_tree_repeatable_expand 0)

(set nvim.g.netrw_nogx 1)

(set nvim.g.fzf_layout {:window {:width 1.0 :height 0.5 :yoffset 1.0 :border :top}})

;; disable pear-tree for lispy languages, covered by parinfer
(set nvim.g.pear_tree_ft_disabled [:clojure :fennel])
