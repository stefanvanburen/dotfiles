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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'mbbill/undotree', { 'on' : 'UndotreeToggle' }
Plug 'edkolev/tmuxline.vim'
Plug 'tommcdo/vim-exchange'
Plug 'mattn/emmet-vim'
Plug 'zah/nimrod.vim', { 'for' : 'nim' }
Plug 'klen/python-mode', { 'for' : 'python' }
Plug 'tpope/vim-fireplace', { 'for' : 'clojure' }
Plug 'kchmck/vim-coffee-script'
Plug 'rust-lang/rust.vim'
Plug 'majutsushi/tagbar'
Plug 'keith/investigate.vim'
Plug 'farseer90718/vim-taskwarrior'
Plug 'jceb/vim-orgmode'
Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do' : './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-github-dashboard'
Plug 'junegunn/gv.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/seoul256.vim'
Plug 'whatyouhide/vim-lengthmatters'
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'reedes/vim-wordy'
Plug 'ryanss/vim-hackernews'
Plug 'rdnetto/YCM-Generator', { 'branch' : 'stable' }
Plug 'mhinz/vim-startify'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'fatih/vim-go'

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
set scrolloff=3
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

let mapleader = "\<Space>" " Leader is space key

autocmd FileType help wincmd L " Help windows open as vertical splits, not horizontal ones

" }}}
" {{{ Plugins

let g:lengthmatters_on_by_default = 0

let g:pymode_folding = 0 " Don't fold my shit, pymode

let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#snapshot_file = "~/.tmux.colors"
let g:airline_theme="solarized"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

let g:indent_guides_guide_size = 1

let g:ycm_collect_identifiers_from_tags_files = 1

let g:user_emmet_install_global=0
autocmd Filetype html,css EmmetInstall

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

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
map <Leader>J <C-w>j
map <Leader>K <C-w>k
map <Leader>L <C-w>l
map <Leader>H <C-w>h
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
map - :bp<CR>
map + :bn<CR>
map <Leader>d :bd<CR>

" Plugin Specific:
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

nmap s <Plug>(easymotion-s)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)

inoremap <F1> <esc>:NERDTreeToggle<CR>
nnoremap <F1> :NERDTreeToggle<CR>

inoremap <F2> <esc>:TagbarToggle<CR>
nnoremap <F2> :TagbarToggle<CR>

inoremap <F3> <esc>:UndotreeToggle<CR>
nnoremap <F3> :UndotreeToggle<CR>

map <Leader>? :call investigate#Investigate()<CR>

map <Leader><Leader> :Files<CR>

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

" }}}
" {{{ Notes
" Clear whitespace at end of lines:
" :%s/\s\+$
" }}}

" vim:foldmethod=marker
