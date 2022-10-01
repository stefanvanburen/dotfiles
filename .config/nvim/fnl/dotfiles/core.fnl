(module dotfiles.core
  {autoload {str aniseed.string}})

;; colorscheme
(set vim.o.termguicolors true)
(set vim.o.background :light)
(vim.cmd.colorscheme :rams)

;; don't wrap by default
(set vim.o.wrap false)

;; always show the completion menu, and when it's brought up, don't select
;; anything by default.
(set vim.o.completeopt (str.join "," ["menuone" "noselect"]))

;; if wrap is set, break on characters in 'breakat' rather than the last
;; character that will fit on the screen.
;; This _should_ mean that lines generally break on words
(set vim.o.linebreak true)
;; on lines that will wrap, they instead 'break' and be visually indented by
;; the showbreak character, followed by the indent.
(set vim.o.breakindent true)
(set vim.o.breakindentopt "shift:2,sbr")
(set vim.o.showbreak "↳")

;; when using > and <, round the indent to a multiple of shiftwidth
(set vim.o.shiftround true)

;; statusline current ' '
;; statusline not current ' '
;; end of buffer ' ', rather than the default '~'
;; vertical empty (escaped space)
;; fold: filling foldtext
;; diff: deleted lines in diff
(let [fillchars {:stl   " "
                 :stlnc " "
                 :eob   " "
                 :vert  "│"
                 :fold  "·"
                 :diff  "-"}]
  (set vim.o.fillchars
        (str.join ","
                  (icollect [k v (pairs fillchars)]
                    (str.join ":" [k v])))))

;; fold based on syntax cues
(set vim.o.foldmethod :syntax)
;; turn off folding by default
(set vim.o.foldenable false)

;; Global substitutions by default.
(set vim.o.gdefault true)

;; Ignore case while searching
(set vim.o.ignorecase true)
;; ... except when capitals are used
(set vim.o.smartcase true)

;; Copy the indent of existing lines when autoindenting
(set vim.o.copyindent true)

;; how long to wait in milliseconds before writing to disk
;; this is set lower to help plugins like vim-gitgutter update their signs
(set vim.o.updatetime 100)

;; Helps when doing insert-mode completion
(set vim.o.infercase true)

;; Don't redraw when using macros.
(set vim.o.lazyredraw false)

;; Invisible characters
(set vim.o.list true)
(let [listchars {:tab "→ "
                 :eol "¬"
                 :trail "⣿"}]
  (set vim.o.listchars
        (str.join ","
                  (icollect [k v (pairs listchars)]
                       (str.join ":" [k v])))))

;; Don't show the mode on the command line - it's redundant with the status line.
(set vim.o.showmode false)

;; line numbers
;; setting these both together means that the current line number is the actual
;; line number of the file, while the other line numbers are relative.
(set vim.o.number true)
(set vim.o.relativenumber true)

;; maintain an undofile for undoing actions through neovim loads
(set vim.o.undofile true)

;; Show matching brackets briefly.
(set vim.o.showmatch true)

;; On horizontal split, open the split below.
(set vim.o.splitbelow true)
;; On vertical split, open the split to the right.
(set vim.o.splitright true)

;; cobbled from https://github.com/liuchengxu/vim-better-default
;; c: no ins-completion-menu messages
(set vim.o.shortmess "atOIoc")

;; turn on mouse support
;; this is useful for resizing windows, using the mouse wheel to scroll, etc
(set vim.o.mouse "a")

;; always use the system clipboard for operations
(set vim.o.clipboard "unnamedplus")

;; turn off swapfiles - for now, I find these more of a headache than a benefit
(set vim.o.swapfile false)

;; Convenience for automatic formatting.
;;   t - auto-wrap text using textwidth
;;   c - auto-wrap comments using textwidth, inserting the current comment leader automatically.
;;   q - allow formatting of comments with `gq`
;;   j - where it makes sense, remove a comment leader when joining lines
;;   r - auto-insert comment leading after <cr> in insert mode
;;   o - auto-insert comment leading after O in normal mode
;;   n - recognize numbered lists in text
;;   p - don't break lines at single spaces that follow periods
(set vim.o.formatoptions "tcqjronp")

;; allows moving the cursor to where there is no actual character
;; virtualedit=all has a bug when paired with vim.highlight.on_yank
;; See: https://github.com/neovim/neovim/issues/13317
;; For now, leave it as the default, "".
(set vim.o.virtualedit "")

;; ignore case when completing files / directories in wildmenu
(set vim.o.wildignorecase true)

;; Enable syntax highlighting in markdown code fences.
;; https://github.com/tpope/vim-markdown
(set vim.g.markdown_fenced_languages ["go"])
