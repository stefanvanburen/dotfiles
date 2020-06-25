" init dot vim

" I'm never going to install these providers
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0

let g:python3_host_skip_check = 1
if executable('python3')
  let g:python3_host_prog = exepath('python3')
endif

" always reset autocmds when sourcing vimrc
augroup vimrc
  autocmd!
augroup END

syntax enable

" since I'm using fish, it's safer for shell to be /bin/sh since some plugins
" will execute commands using shell
" Note that this makes :terminal run /bin/sh, but I don't use :terminal.
" set shell=/bin/sh

" Leader is space key
let g:mapleader = "\<Space>"

" LocalLeader is the comma key
let g:maplocalleader = ","

" bootstrap vim-plug, if not installed.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug
nnoremap <leader>pc :PlugClean<cr>
nnoremap <leader>pg :PlugUpgrade<cr>
nnoremap <leader>ps :PlugStatus<cr>
nnoremap <leader>pu :PlugUpdate<cr>

call plug#begin(stdpath('data') . '/plugged')

" colorscheme
Plug 'lifepillar/vim-colortemplate', { 'on': 'ColorTemplate', 'for': 'colortemplate' }
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase', 'for': ['css', 'colortemplate'] }
  " virtual is cool, but it only works for one color per line (the first one detected)
  let g:Hexokinase_highlighters = ['background']
  let g:Hexokinase_ftEnabled = ['css', 'colortemplate']

" highlight yanked text briefly
Plug 'machakann/vim-highlightedyank'

" directory / file viewer. Largely replaces netrw.
" netrw still loads as it's useful for it's `gx` binding for opening URLs, and
" providing the backend for :Gbrowse for fugitive
Plug 'justinmk/vim-dirvish'

Plug 'lervag/wiki.vim'
  let g:wiki_root = '~/Documents/notes/'
  let g:wiki_filetypes = ['md']
  " only enable wiki mappings in the wiki filetype
  let g:wiki_mappings_use_defaults = 'local'

" Shows registers in a sidebar
" Access via '"' or '@' in normal mode, or <C-r> in insert mode
" Toggle fullscreen with <space>
Plug 'junegunn/vim-peekaboo'

" Better whitespace highlighting / provides :StripWhitespace
Plug 'ntpeters/vim-better-whitespace'
  nnoremap <silent> <leader>sw :StripWhitespace<cr>

Plug 'tpope/vim-fugitive'
  nnoremap <leader>gb :GBrowse<cr>
  xnoremap <Leader>gb :'<'>GBrowse<CR>

  nnoremap <leader>gy :.GBrowse!<cr>
  xnoremap <Leader>gy :'<'>GBrowse!<CR>

  nnoremap <leader>gd :Gdiff<cr>
  " Bring up git status vertically
  nnoremap <silent> <leader>gs :vertical Git<cr>

" Extends vim-fugitive for GitHub
Plug 'tpope/vim-rhubarb'

" Enhances git commit writing
Plug 'rhysd/committia.vim'

" github filetype
Plug 'jez/vim-github-hub'

" up-to-date git filetypes
Plug 'tpope/vim-git'

" fish
Plug 'NovaDev94/vim-fish'

" HTML5
Plug 'othree/html5.vim', { 'for': 'html' }

" Javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': [ 'javascriptreact', 'typescriptreact' ] }

" typescript
Plug 'HerringtonDarkholme/yats.vim', { 'for': [ 'typescript', 'typescriptreact' ] }

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  let g:go_fmt_command = 'gopls'
  let g:go_imports_mode = 'gopls'
  let g:go_imports_autosave = 1

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" for tmux.conf files
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }

" TOML
Plug 'cespare/vim-toml', { 'for': 'toml' }

" Python
Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

" Asciidoc{,tor}
Plug 'habamax/vim-asciidoctor', { 'for': 'asciidoctor' }

" Clojure
Plug 'Olical/conjure', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }

" Automatically match parenthesis
Plug 'tmsvg/pear-tree'
  let g:pear_tree_repeatable_expand = 0

Plug 'tpope/vim-dispatch'
  let g:dispatch_no_tmux_make = 1

" Search
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
  " mnemonic 'git grep'
  nnoremap <leader>gg :Grepper -tool git<cr>
  " mnemonic 'ripgrep'
  nnoremap <leader>rg :Grepper -tool rg<cr>
  nmap gs <plug>(GrepperOperator)
  xmap gs <plug>(GrepperOperator)

" Fuzzy find
Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do' : { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
  nnoremap <leader>f :Files<cr>
  nnoremap <leader><Enter> :GitFiles<cr>
  nnoremap <leader><leader> :Buffers<cr>
  nnoremap <leader>se :Rg<cr>

  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

  command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

Plug 'takac/vim-hardtime'
  let g:hardtime_default_on = 1
  " default keys without '-', which is used to activate vim-dirvish
  let g:list_of_normal_keys = ["h", "j", "k", "l", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
  let g:hardtime_timeout = 2000

Plug 'alok/notational-fzf-vim'
  let g:nv_search_paths = ["~/Documents/notes"]
  nnoremap <C-l> :NV<CR>

" Lightweight improvement of search
Plug 'junegunn/vim-slash'
if has('timers')
  " Blink 2 times with 50ms interval
  noremap <expr> <plug>(slash-after) slash#blink(2, 50)
endif

" Commenting
Plug 'tpope/vim-commentary'

" Adds unix shell commands
Plug 'tpope/vim-eunuch'

" Deal with parentheses, quotes, etc.
Plug 'tpope/vim-surround'

" Repeat plugin maps
Plug 'tpope/vim-repeat'

" Handy bracket ( ] and [ ) mappings
Plug 'tpope/vim-unimpaired'

" enhanced version of matchit plugin
Plug 'andymass/vim-matchup'

" Easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

call plug#end()

set termguicolors
set background=light
colorscheme rams

" don't wrap by default
set nowrap

" if wrap is set, break on characters in 'breakat' rather than the last
" character that will fit on the screen.
" This _should_ mean that lines generally break on words
set linebreak
" on lines that will wrap, they instead 'break' and be visually indented by
" the showbreak character, followed by the indent.
set breakindent
set breakindentopt=shift:2,sbr
set showbreak=↳

" when using > and <, round the indent to a multiple of shiftwidth
set shiftround

" statusline current " "
" statusline not current " "
" vertical empty (escaped space)
" fold: filling foldtext
" diff: deleted lines in diff
set fillchars=stl:\ ,stlnc:\ ,vert:│,fold:·,diff:-

" Global substitutions by default.
set gdefault

" Don't get rid of hidden buffers.
set hidden

" Show substitution results incrementally
set inccommand=nosplit

" Ignore case while searching
set ignorecase
" ... except when capitals are used
set smartcase

" Copy the indent of existing lines when autoindenting
set copyindent

" how long to wait in milliseconds before writing to disk
" this is set lower to help plugins like vim-gitgutter update their signs
set updatetime=100

" Helps when doing insert-mode completion
set infercase

" Don't redraw when using macros.
set lazyredraw

" Display invisible characters
set list
set listchars=tab:⌁\ ,eol:¬,trail:⣿

set grepprg=rg\ --vimgrep

" Don't insert two spaces after punctuation with a join command.
set nojoinspaces

" Don't show the mode on the command line - it's redundant with the status line.
set noshowmode

" line numbers
" setting these both together means that the current line number is the actual
" line number of the file, while the other line numbers are relative.
set number
set relativenumber

" maintain an undofile for undoing actions through neovim loads
set undofile

" Show matching brackets briefly.
set showmatch

" always show the menu - useful when the preview displays more information
set completeopt+=menuone,noselect

" On horizontal split, open the split below.
set splitbelow
" On vertical split, open the split to the right.
set splitright

" cobbled from https://github.com/liuchengxu/vim-better-default
" o: disables
" c: no ins-completion-menu messages
set shortmess=atOIoc

" no statusline
set laststatus=0

" turn on mouse support
" this is useful for resizing windows, using the mouse wheel to scroll, etc
set mouse=a

" always use the system clipboard for operations
set clipboard+=unnamedplus

" turn off swapfiles - for now, I find these more of a headache than a benefit
set noswapfile

" Convenience for automatic formatting.
"   r - auto-insert comment leading after <CR> in insert mode
"   o - auto-insert comment leading after O in normal mode
set formatoptions+=r
set formatoptions+=o

" allows moving the cursor to where there is no actual character
set virtualedit=all

" ignore case when completing files / directories in wildmenu
set wildignorecase

" I don't use ';' often enough
nnoremap ; :

" always move by visual lines, rather than real lines
" this is useful when 'wrap' is set.
nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap j gj
vnoremap k gk

" Navigate between matching brackets
" These are specifically not `noremap`s because we want to be bound to
" whatever % is (usually a plugin, matchit / matchup).
nmap <tab> %
vmap <tab> %

" edit init.vim
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>

" write to disk
nnoremap <leader>w :w<cr>

nnoremap <silent> <leader>q :q<cr>

nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <silent> <leader>sp :setlocal spell!<cr>

nnoremap <silent> <leader>cl :close<cr>
nnoremap <silent> <leader>ss :split<cr>
nnoremap <silent> <leader>vs :vsplit<cr>

" tab mappings
nnoremap <silent> ]r :tabn<cr>
nnoremap <silent> [r :tabp<cr>
nnoremap <silent> <leader>tn :tabnew<cr>

" Use Q to repeat last macro, rather than going into ex mode
nnoremap Q @@

" Swap the behavior of the ^ and 0 operators
" ^ Usually goes to the first non-whitespace character, while 0 goes to the
" first column in the line. ^ is more useful, but harder to hit, so swap it
" with 0
nnoremap 0 ^
nnoremap ^ 0

" always center the screen after any movement command
nnoremap <C-d> <C-d>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
nnoremap <C-u> <C-u>zz

nnoremap g;  g;zvzz
nnoremap g,  g,zvzz

nnoremap <silent> <leader>/ :nohlsearch<cr>

" easier way to exit insert mode - pressing 'jk' or 'kj' quickly
inoremap <silent> jk <esc>
inoremap <silent> kj <esc>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" similar to vmap but only for visual mode - NOT select mode
" maintains the currently visual selection between invocations of '<' and '>'
xnoremap < <gv
xnoremap > >gv

" Resize splits when window is resized
autocmd vimrc VimResized * :wincmd =

" weirdly enough, most of the *.html files I interact with are go templates.
" For now, default them to being vim-go's `gohtmltmpl` filetype.
autocmd vimrc BufRead,BufNewFile *.html setfiletype gohtmltmpl

" vim: foldlevel=99:foldmethod=marker:expandtab:sw=2
