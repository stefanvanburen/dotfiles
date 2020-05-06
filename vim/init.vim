" init dot vim

" I'm never going to install these providers
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0

let g:python3_host_skip_check = 1
if executable('python3')
  let g:python3_host_prog = exepath('python3')
endif

" disable builtin plugins that I don't use
let g:loaded_2html_plugin     = 1
let g:loaded_getscriptPlugin  = 1
let g:loaded_gzip             = 1
let g:loaded_logipat          = 1
let g:loaded_rrhelper         = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tarPlugin        = 1
let g:loaded_vimballPlugin    = 1
let g:loaded_zipPlugin        = 1

" always reset autocmds when sourcing vimrc
augroup vimrc
  autocmd!
augroup END

syntax enable

" Leader is space key
let g:mapleader = "\<Space>"

" LocalLeader is the comma key
let g:maplocalleader = ","

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

scriptencoding utf-8
call plug#begin(stdpath('data') . '/plugged')

" colorscheme
Plug 'lifepillar/vim-colortemplate', { 'for': 'colortemplate' }
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
  " virtual is cool, but it only works for one color per line (the first one detected)
  let g:Hexokinase_highlighters = ['background']
  let g:Hexokinase_ftEnabled = ['css', 'colortemplate']

Plug 'itchyny/lightline.vim'
  let g:lightline = { 'colorscheme': 'ayu_light' }

Plug 'machakann/vim-highlightedyank'

" directory / file viewer. Largely replaces netrw.
" netrw still loads as it's useful for it's `gx` binding for opening URLs, and
" providing the backend for :Gbrowse for fugitive
Plug 'justinmk/vim-dirvish'

" Shows registers in a sidebar
" Access via '"' or '@' in normal mode, or <C-r> in insert mode
" Toggle fullscreen with <space>
Plug 'junegunn/vim-peekaboo'

" Better whitespace highlighting / provides :StripWhitespace
Plug 'ntpeters/vim-better-whitespace'
  nnoremap <silent> <leader>sw :StripWhitespace<cr>

Plug 'airblade/vim-gitgutter'
  let g:gitgutter_sign_modified = '▵'

" Git commit browser
Plug 'junegunn/gv.vim', { 'on': ['GV'] }
  nnoremap <leader>gv :GV<cr>

Plug 'tpope/vim-fugitive'
  nnoremap <leader>gb :Gbrowse<cr>
  nnoremap <leader>gd :Gdiff<cr>
  " Bring up git status vertically
  nnoremap <silent> <leader>gs :vertical Git<cr>

" Extends vim-fugitive for GitHub
Plug 'tpope/vim-rhubarb'

" Enhances git commit writing
Plug 'rhysd/committia.vim'

" github filetype
Plug 'jez/vim-github-hub'

" reveal last commit message (default binding: <Leader>gm)
Plug 'rhysd/git-messenger.vim', { 'on': 'GitMessenger' }

" HTML5
Plug 'othree/html5.vim', { 'for': 'html' }

" Javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': [ 'javascriptreact', 'typescriptreact' ] }

" typescript
Plug 'HerringtonDarkholme/yats.vim', { 'for': [ 'typescript', 'typescriptreact' ] }

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  let g:go_fmt_command = 'goimports'

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

Plug 'guns/vim-sexp' | Plug 'tpope/vim-sexp-mappings-for-regular-people'

" Clojure
Plug 'Olical/conjure', { 'for': 'clojure' }

" Automatically match parenthesis
Plug  'jiangmiao/auto-pairs'

Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do' : { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
  nnoremap <leader><Enter> :Files<cr>
  nnoremap <leader>f :GitFiles<cr>
  nnoremap <leader><leader> :Buffers<cr>
  nnoremap <leader>se :Rg<cr>
  " Empty value to disable preview window altogether
  let g:fzf_preview_window = ''
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

Plug 'alok/notational-fzf-vim', { 'on': 'NV' }
  let g:nv_search_paths = ['~/nv']
  nnoremap <silent> <c-s> :NV<cr>

Plug 'w0rp/ale'
  let g:ale_sign_error = '×'
  let g:ale_sign_warning = '→'
  let g:ale_sign_info = '→'
  let g:ale_echo_msg_format = '%linter%: %s'

  " In general, this is the right thing to do.
  let g:ale_fix_on_save = 1

  let g:ale_virtualtext_cursor = 1
  let g:ale_virtualtext_prefix = '∴ '

  nnoremap <silent> <leader>af :ALEFix<cr>
  nmap <silent> [w <Plug>(ale_previous_wrap)
  nmap <silent> ]w <Plug>(ale_next_wrap)

" Lightweight improvement of search
Plug 'junegunn/vim-slash'
if has('timers')
  " Blink 2 times with 50ms interval
  noremap <expr> <plug>(slash-after) slash#blink(2, 50)
endif

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1

" Commenting
Plug 'tpope/vim-commentary'

" Adds unix shell commands
Plug 'tpope/vim-eunuch'

" tmux / vim navigation
Plug 'christoomey/vim-tmux-navigator'
  " Disable tmux navigator when zooming the Vim pane
  let g:tmux_navigator_disable_when_zoomed = 1

" Deal with parentheses, quotes, etc.
Plug 'tpope/vim-surround'

" heuristically set buffer options
" Plug 'tpope/vim-sleuth'

" Repeat plugin maps
Plug 'tpope/vim-repeat'

" Handy bracket ( ] and [ ) mappings
Plug 'tpope/vim-unimpaired'

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

" statusline current ^
" statusline not current =
" vertical empty (escaped space)
" fold: filling foldtext
" diff: deleted lines in diff
set fillchars=stl:^,stlnc:=,vert:│,fold:·,diff:-

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
set listchars=tab:→\ ,eol:¬,extends:»,precedes:«,nbsp:␣

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

" On horizontal split, open the split below.
set splitbelow
" On veritcal split, open the split to the right.
set splitright

" cobbled from https://github.com/liuchengxu/vim-better-default
" o: disables
" c: no ins-completion-menu messages
set shortmess=atOIoc

" turn on mouse support
" this is useful for resizing windows, using the mouse wheel to scroll, etc
set mouse=a

" always use the system clipboard for operations
set clipboard+=unnamedplus

" Convenience for automatic formatting.
"   r - auto-insert comment leading after <CR> in insert mode
"   o - auto-insert comment leading after O in normal mode
set formatoptions+=r
set formatoptions+=o

" allows moving the cursor to where there is no actual character
set virtualedit=all

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

" save
" :update only writes if there are changes
nnoremap <silent> <leader>w :update<cr>

nnoremap <silent> <leader>q :q<cr>

nnoremap <silent> <leader>so :source $MYVIMRC<cr>
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
" Uses the vimrc augroup
autocmd vimrc VimResized * :wincmd =

" only show trailing characters when not in insert mode
autocmd vimrc InsertEnter * set listchars-=trail:⣿
autocmd vimrc InsertLeave * set listchars+=trail:⣿

" vim: foldlevel=99:foldmethod=marker:expandtab:sw=2
