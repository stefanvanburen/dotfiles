" dot vimrc

" {{{ Plug

set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

Plug 'valloric/YouCompleteMe'
Plug 'Lokaltog/vim-easymotion'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'bling/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'tommcdo/vim-exchange'
Plug 'kchmck/vim-coffee-script'
Plug 'mattn/emmet-vim'
Plug 'zah/nimrod.vim', { 'for' : 'nim' }
Plug 'klen/python-mode', { 'for' : 'python' }
Plug 'tpope/vim-fireplace', { 'for' : 'clojure' }
Plug 'majutsushi/tagbar'
Plug 'keith/investigate.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-github-dashboard'
Plug 'farseer90718/vim-taskwarrior'
Plug 'jceb/vim-orgmode'
Plug 'mbbill/undotree', { 'on' : 'UndotreeToggle' }
Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do' : 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-expand-region'

call plug#end()
filetype plugin indent on

" }}}
" {{{ Basic things

syntax enable

colorscheme solarized

" }}}
" {{{ Settings

set autoindent
set autoread                                " Read changes in files during editing.
set autowriteall
set background=dark
set backspace=eol,indent,start              " Make backspacing work regularly.
set cino=N-s
set encoding=utf-8
set expandtab
set foldenable
"set foldmethod=syntax
set formatoptions=c,q,r,t,j
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
set number
set nobackup
set nostartofline
set noswapfile
set nowrap
set ruler
set scrolloff=1
set showcmd
set showmatch
set showmode
set showtabline=2                           " Always show tabs in vim
set smartcase
set smartindent
set scrolljump=8
set splitbelow                              " On horizontal split, open the split below.
set splitright                              " On veritcal split, open the split to the right.
set t_Co=256
set title
set ttimeout
set ttimeoutlen=100
set ttyfast
set tw=0
set undofile
set undodir=~/.vim/undodir
set visualbell
set wildmenu
set wildmode=list:longest,full
set wildignore+=*.o,*.pyc,*.DS_STORE,*.db,*~

let mapleader = "\<Space>"
" }}}
" {{{ Plugins

let g:syntastic_python_checkers = ['pylint']

let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#snapshot_file = "~/.tmux.colors"
let g:airline_theme="solarized"

let g:indent_guides_guide_size = 1

let g:ycm_collect_identifiers_from_tags_files = 1

let g:user_emmet_install_global=0
autocmd Filetype html,css EmmetInstall

let g:airline#extensions#tabline#enabled=1

let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" }}}
" {{{ Highlights

hi ExtraWhitespace  ctermbg=2 ctermfg=3
hi IncSearch        ctermbg=1 ctermfg=4
hi VertSplit        ctermbg=1
hi MatchParen       ctermbg=1 ctermfg=4
hi Visual           ctermbg=1 ctermfg=4

" }}}
" {{{ Mappings

" Normal Mode:
nmap ; :
nmap p p'[v']=
nmap Y :normal y$
nnoremap 0 ^
nnoremap ^ 0
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <tab> %
nmap < <<
nmap > >>

" Command Mode:
cmap %s/ %s/\v
cmap w!! w !sudo tee % >/dev/null

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Insert Mode:
inoremap jk <ESC>
inoremap kj <ESC>
inoremap <ESC> <NOP>

" All Modes:
map <Leader>w :w<CR>
map <Leader>q :q<CR>
map <Leader>f <C-w>w
map <Leader>v :vsplit<CR>
map <Leader>s :split<CR>
map <Leader>/ :nohl<CR>
map <Leader>r :retab<CR>
map <Leader>e :vsplit $MYVIMRC<CR>
map <Leader>ss :setlocal spell!<CR>
map <Leader>sv :mksession<CR>
map <Leader>so :source $MYVIMRC<CR>
map <Leader>i <Leader>so:PlugInstall<CR>
map <Leader>u <Leader>so:PlugUpdate<CR>
map <Leader>cd :cd %:p:h<CR>:pwd<CR>
map <Leader>n :bn<CR>
map <Leader>p :bp<CR>
map <Leader>c :bd<CR>
map <f9> :!javac %<CR>
map <f10> :!gcc %<CR>
map <f11> :!python %<CR>
map <f12> :!clisp %<CR>
map <Leader>K :call investigate#Investigate()<CR>
map <Leader>tn :NERDTreeToggle<CR>
map <Leader>tt :TagbarToggle<CR>
map <Leader>tw :TW<CR>
map <Leader>tr :UndotreeToggle<CR>
map <Leader><Leader> :FZF -m<CR>

" }}}
