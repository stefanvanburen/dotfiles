"mrtwiddletoes .vimrc
syntax on                           " Syntax highlighting please
filetype plugin on
filetype indent on
set nocompatible                    " Vim.
set autoindent                      " Autoindent my things
set autoread                        " Read changes in files during editing
set autowriteall                    " Make sure I'm saving things
set showmatch                       " Show matching brackets, parentheses, etc.
set smartindent                     " Indent my things smartly
set nowrap                          " No wrapping
set softtabstop=2                   " Number of columsn a tab moves in insert mode
set shiftwidth=2                    " How many columns are indented with >> and << commands
set tabstop=4                       " How many columns a tab counts for
set expandtab                       " Converts tabs to spaces
set nosmarttab                      " Don't you get smart with me about those tabs
set ruler                           " Line number and column number
set number                          " Line numbers, because I like repeats
set ch=2                            " Bigger command-line height
set showmatch                       " Show matching brackets
set ignorecase                      " Ignore case when searching
set smartcase                       " Once again, ignore case while searching
set visualbell                      " No bell sound
set incsearch                       " Keep searching as I type
set hlsearch                        " Highlight my searches
hi CursorColumn ctermbg=lightgreen
set cursorcolumn                    " Highlight the cursor column, in light green,
                                    " as opposed to the disgusting white that it originally is set to
set cursorline                      " Highlight the cursor line
set linespace=0                     " No space between lines in Vim
set nostartofline                   " No moving to the start of the line when scrolling
let mapleader = ","                 " Use ',' as leader
:map <Leader>w <C-w>w               
nnoremap ; :
nnoremap <C-q> :wqall<CR>
