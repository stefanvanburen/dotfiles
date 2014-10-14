" .vimrc

" {{{ Vundle

set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle.vim/
call vundle#rc()

Plugin 'gmarik/vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'klen/python-mode'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'tommcdo/vim-exchange'
Plugin 'nathanaelkane/vim-indent-guides'

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
set encoding=utf-8
"set foldenable
set foldmethod=marker
set hlsearch
set ignorecase
set incsearch
set laststatus=2                            " Always show the last command.
set lazyredraw                              " Don't redraw when using macros.
set list                                    " Displays invisible characters.
set listchars=tab:→-,eol:¬,trail:⋅
set modeline
set number
set nobackup
set nostartofline
set noswapfile
set nowrap
set ruler
set showcmd
set showmatch
set showmode
set smartcase
set smartindent
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

let mapleader=","
let g:syntastic_python_checkers=['pylint']
let g:airline_powerline_fonts=1
let g:airline#extensions#tmuxline#enabled=0
let g:indent_guides_guide_size=1

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
nnoremap ; :
nnoremap / /\v
nnoremap p p'[v']=
nnoremap Y :normal y$
nnoremap 0 ^
nnoremap ^ 0
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <tab> %

" Command Mode:
cnoremap %s/ %s/\v
cnoremap w!! w !sudo tee % >/dev/null

" Insert Mode:
inoremap jk <Esc>
inoremap kj <Esc>
inoremap <esc> <nop>

" All Modes:
noremap <Leader>f <C-w>w
noremap <Leader>w :w<CR>
noremap <Leader>q :q<CR>
noremap <Leader>v :vsplit<CR>
noremap <Leader>s :split<CR>
noremap <Leader>/ :nohl<CR>
noremap <Leader>r :retab<CR>
noremap <Leader>e :vsplit $MYVIMRC<CR>
noremap <f9> :!javac %<CR>
noremap <f10> :!gcc %<CR>
noremap <f11> :!python %<CR>
noremap <f12> :!clisp %<CR>
noremap <Leader>n :NERDTreeToggle<CR>

" }}}
