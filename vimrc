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
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'mbbill/undotree', { 'on' : 'UndotreeToggle' }
Plug 'edkolev/tmuxline.vim'
Plug 'tommcdo/vim-exchange'
Plug 'mattn/emmet-vim'
Plug 'majutsushi/tagbar'
Plug 'keith/investigate.vim'
Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do' : './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-github-dashboard'
Plug 'junegunn/gv.vim'
Plug 'whatyouhide/vim-lengthmatters'
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'reedes/vim-wordy'
Plug 'ryanss/vim-hackernews'
Plug 'rdnetto/YCM-Generator', { 'branch' : 'stable' }
Plug 'mhinz/vim-startify'

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
set cc=80
set cino=N-s
set expandtab
set foldenable
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
set nojoinspaces                            " Don't insert two spaces after punctuation with a join command
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

autocmd FileType help wincmd L

" }}}
" {{{ Plugins

let g:lengthmatters_on_by_default = 0

let g:pymode_folding = 0

let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#snapshot_file = "~/.tmux.colors"
let g:airline_theme="solarized"

let g:indent_guides_guide_size = 1

let g:ycm_collect_identifiers_from_tags_files = 1

let g:user_emmet_install_global=0
autocmd Filetype html,css EmmetInstall

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

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
nmap Y :normal y$<CR>
nnoremap 0 ^
nnoremap ^ 0
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <tab> %
nmap < <<
nmap > >>
nnoremap g= gg=Gg``

" Command Mode:
cmap %s/ %s/\v
cmap w!! w !sudo tee % >/dev/null

" Insert Mode:
inoremap jk <ESC>
inoremap kj <ESC>

" All Modes:
map <Leader>w :w<CR>
map <Leader>q :q<CR>
map <Leader>f <C-w>w
map <Leader>v :vsplit<CR>
map <Leader>/ :nohl<CR>
map <Leader>r :retab<CR>
map <Leader>e :e $MYVIMRC<CR>
map <Leader>ss :setlocal spell!<CR>
map <Leader>sv :mksession<CR>
map <Leader>so :source $MYVIMRC<CR>
map <Leader>i :PlugInstall<CR>
map <Leader>u :PlugUpdate<CR>
map ]b :bn<CR>
map [b :bp<CR>
map <Leader>d :bd<CR>

" Plugin specific
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
inoremap <F10> <esc>:NERDTreeToggle<CR>
nnoremap <F10> :NERDTreeToggle<CR>
inoremap <F11> <esc>:TagbarToggle<CR>
nnoremap <F11> :TagbarToggle<CR>
inoremap <F12> <esc>:UndotreeToggle<CR>
nnoremap <F12> :UndotreeToggle<CR>
map <Leader>K :call investigate#Investigate()<CR>
map <Leader><Leader> :Files<CR>

" }}}


" NOTES
" Clear whitespace at end of lines:
" :%s/\s\+$
