" init dot vim

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

Plug 'itchyny/lightline.vim'

" disable netrw_
" :help netrw-noload
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

Plug 'justinmk/vim-dirvish'

" open URLs
Plug 'tyru/open-browser.vim'
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)

" Shows mappings, registers, etc
Plug 'junegunn/vim-peekaboo'

" Better whitespace highlighting / provides :StripWhitespace
Plug 'ntpeters/vim-better-whitespace'
  nmap <silent> <leader>sw :StripWhitespace<cr>

" displays git changes in the gutter
" also installs hunk operations, prefixed with <leader>h
" :help gitgutter-mappings
Plug 'airblade/vim-gitgutter'

Plug 'junegunn/gv.vim', { 'on': ['GV'] }
  nmap <leader>gv :GV<cr>

Plug 'tpope/vim-fugitive'
  nmap <leader>gd :Gdiff<cr>
  " Bring up git status vertically
  nmap <silent> <leader>gs :vertical Git<cr>

" Extends vim-fugitive for GitHub
Plug 'tpope/vim-rhubarb'

" Enhances git commit writing
Plug 'rhysd/committia.vim'

" github filetype
Plug 'jez/vim-github-hub'

" reveal last commit message (default binding: <Leader>gm)
Plug 'rhysd/git-messenger.vim'

" Javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': [ 'typescriptreact', 'javascriptreact' ] }

" typescript
Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescriptreact'] }

" Vue.js
" TODO: Remove once I stop using Vue
Plug 'posva/vim-vue', { 'for': 'vue' }

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

" Clojure
Plug 'Olical/conjure', { 'for': 'clojure', 'tag': 'v2.1.2', 'do': 'bin/compile' }
  let g:conjure_log_direction = "horizontal"
" Automatically match parenthesis
Plug 'jiangmiao/auto-pairs', { 'for': 'clojure' }

" Colorscheme
Plug 'lifepillar/vim-gruvbox8'

Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do' : { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
  nnoremap <leader><Enter> :GFiles<cr>
  nnoremap <leader>f :Files<cr>
  nnoremap <leader>gf :GFiles?<cr>
  nnoremap <leader><leader> :Buffers<cr>
  nnoremap <leader>se :Rg<cr>
  " Empty value to disable preview window altogether
  let g:fzf_preview_window = ''
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

Plug 'alok/notational-fzf-vim'
  let g:nv_search_paths = ['~/nv']
  nnoremap <silent> <c-s> :NV<cr>

Plug 'w0rp/ale'
  let g:ale_sign_error = '→'
  let g:ale_sign_warning = '→'
  let g:ale_sign_info = '→'
  let g:ale_echo_msg_error_str = 'E'
  let g:ale_echo_msg_warning_str = 'W'
  let g:ale_echo_msg_format = '[%linter%] %s'

  nnoremap <silent> <leader>af :ALEFix<cr>
  nmap <silent> [w <Plug>(ale_previous_wrap)
  nmap <silent> ]w <Plug>(ale_next_wrap)

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

" tmux / vim navigation
Plug 'christoomey/vim-tmux-navigator'
  " Disable tmux navigator when zooming the Vim pane
  let g:tmux_navigator_disable_when_zoomed = 1

" Deal with parentheses, quotes, etc.
Plug 'machakann/vim-sandwich'

" heuristically set buffer options
Plug 'tpope/vim-sleuth'

" Repeat plugin maps
Plug 'tpope/vim-repeat'

" Handy bracket ( ] and [ ) mappings
Plug 'tpope/vim-unimpaired'

" Easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

call plug#end()

set termguicolors
colorscheme gruvbox8

" on lines that will wrap, they instead 'break' and be visually indented by
" the showbreak character, followed by the indent.
set breakindent
set breakindentopt=shift:2,sbr
set showbreak=↳

" Highlight the line where the cursor is
set cursorline

" statusline current ^
" statusline not current =
" vertical empty (escaped space)
" fold: filling foldtext
" diff: deleted lines in diff
set fillchars=stl:^,stlnc:=,vert:\ ,fold:·,diff:-

" Global substitutions by default.
set gdefault

" Don't get rid of hidden buffers.
set hidden

" Show the results of a substitution in a separate preview buffer
set inccommand=split

" Ignore case while searching
set ignorecase
" ... except when capitals are used
set smartcase

" how long to wait in milliseconds before writing to disk
" this is set lower to help plugins like vim-gitgutter update their signs
set updatetime=100

" Helps when doing insert-mode completion
set infercase

" Don't redraw when using macros.
set lazyredraw

" Display invisible characters
set list
set listchars=tab:→-,eol:¬,trail:⋅

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

" cobbled from https://github.com/liuchengxu/vim-better-default/blob/6acbe5236238340e64164f5823d1319886b88868/plugin/default.vim#L43
" o: disables
" c: no ins-completion-menu messages
set shortmess=atOIoc

" Don't syntax highlight after 200 columns (for larger files).
set synmaxcol=200

" Highlight fenced code in markdown
" https://til.hashrocket.com/posts/e8915e62c0-highlight-markdown-fenced-code-syntax-in-vim
let g:markdown_fenced_languages = ['html', 'vim', 'go', 'python', 'bash=sh']

" maximum popup menu height of 20 items
set pumheight=20

" turn on mouse support
set mouse=a

" always use the clipboard for operations
set clipboard+=unnamedplus

" allows moving the cursor to where there is no actual character
set virtualedit=all

nnoremap ; :

nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap j gj
vnoremap k gk

" Navigate between matching brackets
nnoremap <tab> %
vnoremap <tab> %

" edit init.vim
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>

nnoremap <leader>w :w<cr>

nnoremap <leader>so :source $MYVIMRC<cr>
nnoremap <leader>sp :setlocal spell!<cr>

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

inoremap <silent> jk <esc>
inoremap <silent> kj <esc>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" similar to vmap but only for visual mode - NOT select mode
xnoremap < <gv
xnoremap > >gv

" Resize splits when window is resized
augroup window
  autocmd VimResized * :wincmd =
augroup END

" vim: foldlevel=99:foldmethod=marker:expandtab:sw=2
