" dot vimrc

" {{{ Plug

set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/syntastic'
"Plug 'whatyouhide/vim-lengthmatters'
"Plug 'xolox/vim-easytags'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'andrewradev/splitjoin.vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'edkolev/tmuxline.vim'
Plug 'farseer90718/vim-taskwarrior'
Plug 'fatih/vim-go'
Plug 'jceb/vim-orgmode'
Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do' : './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-github-dashboard'
Plug 'junegunn/vim-peekaboo'
Plug 'kchmck/vim-coffee-script'
Plug 'keith/investigate.vim'
Plug 'klen/python-mode', { 'for' : 'python' }
Plug 'lokaltog/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree', { 'on' : 'UndotreeToggle' }
Plug 'mhinz/vim-startify'
Plug 'myusuf3/numbers.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rdnetto/YCM-Generator', { 'branch' : 'stable' }
Plug 'reedes/vim-wordy'
Plug 'rust-lang/rust.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'ryanss/vim-hackernews'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fireplace', { 'for' : 'clojure' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc'
Plug 'zah/nimrod.vim', { 'for' : 'nim' }

call plug#end()
filetype plugin indent on

" }}}
" {{{ Basic things

syntax enable

colorscheme solarized

let g:mapleader = "\<Space>" " Leader is space key

" }}}
" {{{ Settings

set autoindent
set autoread                                " Read changes in files during editing.
set autowriteall
set background=dark
set backspace=eol,indent,start              " Make backspacing work regularly.
set colorcolumn=100
set cinoptions=N-s
set expandtab
set foldenable
set formatoptions=c,q,r,t,j,o               "
set hidden
set history=10000
set hlsearch
set ignorecase
set incsearch
set laststatus=2                            " Always show the last command.
set lazyredraw                              " Don't redraw when using macros.
set list                                    " Displays invisible characters.
set listchars=tab:→-,eol:¬,trail:⋅
set magic                                   " For regex
set mat=2                                   " Number of tenths of a second to blink
set modelines=1
set nobackup
set nojoinspaces                            " Don't insert two spaces after punctuation with a join command
set nostartofline
set noswapfile
set nowrap
set number
set ruler
set scrolljump=8
set scrolloff=3
set shiftwidth=4
set showcmd
set showmatch
set showmode
set showtabline=2                           " Always show tabs in vim
set smartcase
set smartindent
set splitbelow                              " On horizontal split, open the split below.
set splitright                              " On veritcal split, open the split to the right.
set t_Co=256
set tabstop=4
set tags+=tags;$HOME
set title
set ttimeout
set ttimeoutlen=100
set ttyfast
set textwidth=0
set undodir=~/.vim/undodir
set undofile
set visualbell
set wildignore+=*.o,*.pyc,*.DS_STORE,*.db,*~
set wildmenu
set wildmode=list:longest,full

" }}}
" {{{ Plugin Configuration

let g:airline_theme                              = 'solarized'
let g:airline_powerline_fonts                    = 0
let g:airline#extensions#tabline#enabled         = 1
let g:airline#extensions#tabline#show_tab_nr     = 1
let g:airline#extensions#tabline#show_tab_type   = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

let g:EasyMotion_do_mapping       = 0
let g:EasyMotion_smartcase        = 1
let g:EasyMotion_keys             = 'asdfghjkl;qwertyuiopzxcvbnm'
let g:EasyMotion_enter_jump_first = 1

let g:easytags_async = 1

let g:indent_guides_guide_size = 1

let g:go_fmt_autosave = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_list_type = 'quickfix'

let g:lengthmatters_on_by_default = 0

let g:pymode_folding = 0

let g:syntastic_vim_checkers = ['vint']
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:undotree_WindowLayout = 2

let g:user_emmet_install_global = 0

let g:ycm_collect_identifiers_from_tags_files = 1

" }}}
" {{{ Highlights

hi IncSearch       ctermbg=1 ctermfg=4
hi MatchParen      ctermbg=1 ctermfg=4
hi VertSplit       ctermbg=1
hi Visual          ctermbg=1 ctermfg=4

" }}}
" {{{ Mappings

" Normal Mode:
nmap ; :
nmap < <<
nmap > >>
nmap <leader>/ :nohl<cr>
nmap <leader>W :%s/\s+$//<cr>:let @/=''<cr>
nmap <leader>a :Ag<cr>
nmap <leader>e :e $MYVIMRC<cr>
nmap <leader>m :mksession<cr>
nmap <leader>o :source $MYVIMRC<cr>
nmap <leader>p :setlocal spell!<cr>
nmap <leader>q :q<cr>
nmap <leader>r :retab<cr>
nmap <leader>s :%s/
nmap <leader>v :vsplit<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>t :TagbarToggle<cr>
nmap <leader>w :up<cr>
nmap <tab> %
nmap Y :normal y$<cr>
nmap p gp
nmap P gP
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l
nnoremap <leader>f <c-w>w
nnoremap <leader>V V`]
nnoremap <leader>l :set list!<cr>
nnoremap 0 ^
nnoremap ^ 0
nnoremap g= gg=Gg``

" Buffers:
nnoremap ]b :bn<cr>
nnoremap [b :bp<cr>
nnoremap - :bp<cr>
nnoremap + :bn<cr>
nnoremap <leader>d :bd<cr>

" Tabs:
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" Quickfix:
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" Command Mode:
cmap %s/ %s/\v
cmap w!! w !sudo tee % >/dev/null
cnoremap jk <esc>
cnoremap kj <esc>

" Insert Mode:
inoremap jk <esc>
inoremap kj <esc>

" Visual And Select Mode:
xnoremap < <gv
xnoremap > >gv

" Visual Mode:
vnoremap / /\v
vmap <tab> %
vmap <leader>s :s/
vmap s :!sort<cr>
vmap u :!sort -u<cr>

" Plugin Specific:
nmap <leader>1 <plug>AirlineSelectTab1
nmap <leader>2 <plug>AirlineSelectTab2
nmap <leader>3 <plug>AirlineSelectTab3
nmap <leader>4 <plug>AirlineSelectTab4
nmap <leader>5 <plug>AirlineSelectTab5
nmap <leader>6 <plug>AirlineSelectTab6
nmap <leader>7 <plug>AirlineSelectTab7
nmap <leader>8 <plug>AirlineSelectTab8
nmap <leader>9 <plug>AirlineSelectTab9
nmap <leader>- <plug>AirlineSelectPrevTab
nmap <leader>+ <plug>AirlineSelectNextTab

map <leader>h :GitGutterLineHighlightsToggle<cr>

vmap v <plug>(expand_region_expand)
vmap <C-v> <plug>(expand_region_shrink)

nmap s <plug>(easymotion-s2)
nmap t <plug>(easymotion-t2)
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)
map / <plug>(easymotion-sn)
omap / <plug>(easymotion-tn)
map n <plug>(easymotion-next)
map N <plug>(easymotion-prev)

nnoremap U :UndotreeToggle<cr>

map <leader>? :call investigate#Investigate()<cr>

map <leader><leader> :Files<cr>

xmap ga <plug>(EasyAlign)
nmap ga <plug>(EasyAlign)

nmap <leader>g :Gstatus<cr>gg<c-n>
nmap <leader>d :Gdiff<cr>

nmap <leader>G :Goyo<cr>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

map <leader>i :PlugInstall<cr>
map <leader>u :PlugUpdate<cr>

nmap <leader>z :GV<cr>

" }}}
" {{{ Autocommands

autocmd FileType go   set noexpandtab tabstop=4 shiftwidth=4
autocmd FileType java set noexpandtab tabstop=4 shiftwidth=4
autocmd FileType sh   set shiftwidth=4
autocmd FileType c    set cindent

autocmd FileType help wincmd L

autocmd BufRead,BufNewFile {pending,completed,undo}.data set filetype=taskdata
autocmd BufRead,BufNewFile .taskrc                       set filetype=taskrc
autocmd BufRead,BufNewFile *.task                        set filetype=taskedit

autocmd Filetype html,css EmmetInstall

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!


" }}}

" vim:foldmethod=marker
