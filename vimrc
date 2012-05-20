" mrtwiddletoes .vimrc

syntax enable                       " Syntax highlighting please
set background=dark
colorscheme solarized
filetype plugin on
filetype indent on
set nocompatible                    " Vim.
set autoindent                      " Autoindent my things
set autoread                        " Read changes in files during editing
set autowriteall                    " Make sure I'm saving things
set showmatch                       " Show matching brackets, parentheses, etc.
set smartindent                     " Indent my things smartly
set nowrap                          " No wrapping
set nosmarttab                      " Don't you get smart with me about those tabs
set ruler                           " Line number and column number
set relativenumber                   
set cmdheight=2                     " Bigger command-line height
set showmatch                       " Show matching brackets
set ignorecase                      " Ignore case when searching
set smartcase                       " Once again, ignore case while searching
set visualbell                      " No bell sound
set incsearch                       " Keep searching as I type
set hlsearch                        " Highlight my searches
set cursorcolumn                    " Highlight the cursor column, in light green,
                                    " as opposed to the disgusting white that it originally is set to
set cursorline                      " Highlight the cursor line
set linespace=0
set nostartofline                   " No moving to the start of the line when scrolling
set title                           " Title of terminal = file being edited
let mapleader = ","                 " Use ',' as leader
set tw=79                           " Set the textwidth to 80 chars

" Mappings!--------------------------------------------------------------------

nnoremap ; :
nnoremap / /\v
nnoremap p p'[v']=
cnoremap %s/ %s/\v
inoremap jk <Esc>
inoremap kj <Esc>
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
