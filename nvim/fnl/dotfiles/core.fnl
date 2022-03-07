(module dotfiles.core
  {autoload {nvim aniseed.nvim
             str aniseed.string}})

(defn- opt [name value]
  (nvim.set_option name value))

(defn- wopt [name value]
  (nvim.win_set_option 0 name value)
  (opt name value))

(defn- bopt [name value]
  (nvim.buf_set_option 0 name value)
  (opt name value))

;; colorscheme
(opt :termguicolors true)
(opt :background :light)
(nvim.ex.colorscheme :rams)

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
  (wopt :fillchars
        (str.join ","
                  (icollect [k v (pairs fillchars)]
                    (str.join ":" [k v])))))

;; fold based on syntax cues
(wopt :foldmethod :syntax)
;; turn off folding by default
(wopt :foldenable false)

;; Global substitutions by default.
(opt :gdefault true)

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
(wopt :list true)
(let [listchars {:tab "→ "
                 :eol "¬"
                 :trail "⣿"}]
  (wopt :listchars
        (str.join ","
                  (icollect [k v (pairs listchars)]
                       (str.join ":" [k v])))))

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
;; c: no ins-completion-menu messages
(opt :shortmess "atOIoc")

;; turn on mouse support
;; this is useful for resizing windows, using the mouse wheel to scroll, etc
(opt :mouse "a")

;; always use the system clipboard for operations
(opt :clipboard "unnamedplus")

;; turn off swapfiles - for now, I find these more of a headache than a benefit
(bopt :swapfile false)

;; Convenience for automatic formatting.
;;   t - auto-wrap text using textwidth
;;   c - auto-wrap comments using textwidth, inserting the current comment leader automatically.
;;   q - allow formatting of comments with `gq`
;;   j - where it makes sense, remove a comment leader when joining lines
;;   r - auto-insert comment leading after <cr> in insert mode
;;   o - auto-insert comment leading after O in normal mode
;;   n - recognize numbered lists in text
;;   p - don't break lines at single spaces that follow periods
(bopt :formatoptions "tcqjronp")

;; allows moving the cursor to where there is no actual character
(opt :virtualedit "all")

;; ignore case when completing files / directories in wildmenu
(opt :wildignorecase true)
