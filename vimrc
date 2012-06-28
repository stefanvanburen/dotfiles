" mrtwiddletoes .vimrc

" Basic things!----------------------

syntax enable                       " Syntax highlighting please

colorscheme solarized               " Solarized!

filetype on                         " Pay attention to filetype.
filetype plugin on                  " Use plugins based on the type of file I'm editing.
filetype indent on                  " Indent based on the type of file I'm editing.

" Settings!--------------------------

set background=dark                 " For colorscheme
set nocompatible                    " Vim, not vi.
set autoindent                      " Autoindent stuff.
set smartindent                     " Indent my things smartly.
set ignorecase                      " Ignore case when searching.
set smartcase                       " Once again, ignore case while searching.
set autoread                        " Read changes in files during editing.
set autowriteall                    " Make sure I'm saving things.
set showmatch                       " Show matching brackets, parentheses, etc.
set nowrap                          " No wrapping.
set ruler                           " Show line number and column number.
set number                          " Show line numbers.
set cmdheight=2                     " Bigger command-line height.
set visualbell                      " No bell sound.
set incsearch                       " Keep searching as I type.
set hlsearch                        " Highlight my searches.
set cursorcolumn                    " Highlight the cursor column.
set cursorline                      " Highlight the cursor line.
set nostartofline                   " No moving to the start of the line when scrolling.
set title                           " Title of terminal = file being edited.
set tw=79                           " Set the textwidth to 80 chars.

let mapleader = ","                 " Use ',' as leader

" Mappings!--------------------------

" Normal Mode:
nnoremap ; :
nnoremap / /\v
nnoremap p p'[v']=

" Command Mode:
cnoremap %s/ %s/\v

" Insert Mode:
inoremap jk <Esc>
inoremap kj <Esc>

" All Modes:
map <Leader>v :vsplit ~/.vimrc<CR><C-w>_
map <Leader>z :vsplit ~/.zshrc<CR><C-w>_
map <Leader>f <C-w>w
map <Leader>w :w<CR>
map <Leader>q :wq<CR>
map <Leader>d :vsplit<CR>
map <Leader>s :split<CR>
map <f9> :!javac %<CR>
map <f10> :!gcc %<CR>
map <f11> :!python %<CR>
map <f12> :!clisp %<CR>
