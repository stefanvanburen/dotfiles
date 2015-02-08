" .vimrc

" {{{ Vundle

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'klen/python-mode'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'tommcdo/vim-exchange'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'dahu/bisectly'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mattn/emmet-vim'

call vundle#end()
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
"set foldmethod=indent
set formatoptions=c,q,r,t
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
set term=screen-256color
set title
set ttyfast
set tw=0
set visualbell
set wildmenu
set wildmode=list:longest,full
set wildignore+=*.o,*.pyc,*.DS_STORE,*.db,*~

let mapleader=","
let g:syntastic_python_checkers=['pylint']
let g:airline_powerline_fonts=1
let g:airline#extensions#tmuxline#enabled=0
let g:indent_guides_guide_size=1
let g:solarized_visibility="low"
let g:ycm_collect_identifiers_from_tags_files=1

" }}}
" {{{ Highlights

highlight ColorColumn     ctermbg=4 ctermfg=1
highlight ExtraWhitespace ctermbg=2 ctermfg=3
highlight CursorColumn    ctermbg=16
highlight CursorLine      ctermbg=16
highlight StatusLine      ctermbg=4 ctermfg=1
highlight StatusLineNC    ctermbg=9 ctermfg=12
highlight IncSearch       ctermbg=1 ctermfg=4
highlight VertSplit       ctermbg=1
highlight MatchParen      ctermbg=1 ctermfg=4
highlight Visual          ctermbg=1 ctermfg=4
highlight IndentGuidesOdd ctermbg=2

" }}}
" {{{ Mappings

" Normal Mode:
nmap ; :
" Open or close folds using space
nmap <space> za
nmap p p'[v']=
nmap Y :normal y$
nnoremap 0 ^
nnoremap ^ 0
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <tab> %

" Command Mode:
cmap %s/ %s/\v
cmap w!! w !sudo tee % >/dev/null

" Insert Mode:
inoremap jk <ESC>
inoremap kj <ESC>
inoremap <ESC> <NOP>

" All Modes:
map <Leader>f <C-w>w
map <Leader>w :w<CR>
map <Leader>q :q<CR>
map <Leader>v :vsplit<CR>
map <Leader>s :split<CR>
map <Leader>/ :nohl<CR>
map <Leader>r :retab<CR>
map <Leader>e :vsplit $MYVIMRC<CR>
map <Leader>tn :tabnew<CR>
map <Leader>tc :tabclose<CR>
map <Leader>tm :tabmove
map <Leader>te :tabedit
map <Leader>ss :setlocal spell!<CR>
map <Leader>sv :mksession<CR>
map <Leader>so :source $MYVIMRC<CR>
" Change directory to the directory of the current buffer
map <Leader>cd :cd %:p:h<CR>:pwd<CR>
map <f9> :!javac %<CR>
map <f10> :!gcc %<CR>
map <f11> :!python %<CR>
map <f12> :!clisp %<CR>
map <Leader>n :NERDTreeToggle<CR>

let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" }}}

" vim:foldmethod=marker:foldlevel=0
