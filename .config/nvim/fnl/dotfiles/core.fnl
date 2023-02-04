(module dotfiles.core)

;; colorscheme
(set vim.o.termguicolors true)
(set vim.o.background :light)
(vim.cmd.colorscheme :zenwritten)

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

;; defaults, other than end of buffer ' ', rather than the default '~'
(set vim.o.fillchars "eob: ,")

;; Global substitutions by default.
(set vim.o.gdefault true)

;; Ignore case while searching
(set vim.o.ignorecase true)
;; ... except when capitals are used
(set vim.o.smartcase true)

;; Copy the indent of existing lines when autoindenting
(set vim.o.copyindent true)

;; Set lower for the CursorHold autocmd, so that LSP's document highlighting is useful.
(set vim.o.updatetime 100)

;; Helps when doing insert-mode completion
(set vim.o.infercase true)

;; Invisible characters
(set vim.o.list true)
(set vim.o.listchars "tab:→ ,eol:¬,trail:⣿")

;; Don't show the mode on the command line - it's redundant with the status line.
(set vim.o.showmode false)

;; maintain an undofile for undoing actions through neovim loads
(set vim.o.undofile true)

;; On horizontal split, open the split below.
(set vim.o.splitbelow true)
;; On vertical split, open the split to the right.
(set vim.o.splitright true)

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

;; ignore case when completing files / directories in wildmenu
(set vim.o.wildignorecase true)

;; Enable syntax highlighting in markdown code fences.
;; https://github.com/tpope/vim-markdown
(set vim.g.markdown_fenced_languages ["go"])

;; https://github.com/BurntSushi/ripgrep/issues/425
(set vim.o.grepprg "rg --vimgrep --no-heading --smart-case")
(set vim.o.grepformat "%f:%l:%c:%m,%f:%l:%m")

;; %f: relative path to current file
;; %m: modified flag
;; %{FugitiveHead()}: git head branch
;; %=: separation
;; %l: line number
;; %c: column number
;; %{&filetype}: filetype
(set vim.o.statusline "%f%m %{FugitiveHead()}%=%l,%c %{&filetype}")
