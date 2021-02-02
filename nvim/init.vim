" init dot vim

" I'm never going to install these providers
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0

" Handled by vim-matchup
let g:loaded_matchit = 1

" Disable netrw
" Supplanted by vim-dirvish.
" URL opening handled by open-browser.vim
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

let g:python3_host_skip_check = 1
if executable('python3')
  let g:python3_host_prog = exepath('python3')
endif

" always reset autocmds when sourcing vimrc
augroup vimrc
  autocmd!
augroup END

" bootstrap vim-plug, if not installed.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" TODO: figure out how to do this in Fennel
nnoremap ; :

call plug#begin(stdpath('data') . '/plugged')

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" directory / file viewer. Largely replaces netrw.
Plug 'justinmk/vim-dirvish'

Plug 'tyru/open-browser.vim'

" Adds git added / modified / deleted in the sidebar (amongst other things)
" Use ]c / [c to go to hunks within a file
Plug 'airblade/vim-gitgutter'

" Better whitespace highlighting / provides :StripWhitespace
Plug 'ntpeters/vim-better-whitespace'

Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'

" Allows for viewing git commit messages related to the current line
" <leader>gm to trigger the window, again to go inside.
Plug 'rhysd/git-messenger.vim'

" up-to-date git filetypes
Plug 'tpope/vim-git'

" Fish
Plug 'blankname/vim-fish'

" HTML5
Plug 'othree/html5.vim', { 'for': 'html' }

" CSS
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }

" Javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': [ 'javascriptreact', 'typescriptreact' ] }

" typescript
Plug 'HerringtonDarkholme/yats.vim', { 'for': [ 'typescript', 'typescriptreact' ] }

" Markdown
Plug 'plasticboy/vim-markdown'

" toml
Plug 'cespare/vim-toml'

" LaTeX
Plug 'lervag/vimtex'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" rust
Plug 'rust-lang/rust.vim'

" JSON
Plug 'elzr/vim-json'

" profiling startup time
Plug 'dstein64/vim-startuptime'

" for tmux.conf files
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }

" Lisp
Plug 'Olical/conjure', { 'for': ['clojure', 'fennel'] }
Plug 'guns/vim-sexp' | Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'eraserhd/parinfer-rust', { 'do': 'cargo build --release' }

Plug 'Olical/aniseed'
Plug 'bakpakin/fennel.vim'

" Automatically match parenthesis
Plug 'tmsvg/pear-tree'

Plug 'tpope/vim-dispatch'

Plug 'vim-test/vim-test'

" s{char}{char} to search for a set of two characters
Plug 'justinmk/vim-sneak'

" Fuzzy find
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'

" Plug 'takac/vim-hardtime'

" Linting / fixing
Plug 'w0rp/ale'

" Commenting
Plug 'tpope/vim-commentary'

" Adds unix shell commands
Plug 'tpope/vim-eunuch'

" Database access
Plug 'tpope/vim-dadbod', { 'on': 'DB' }

" Deal with parentheses, quotes, etc.
Plug 'tpope/vim-surround'

" Repeat plugin maps
Plug 'tpope/vim-repeat'

" Handy bracket ( ] and [ ) mappings
Plug 'tpope/vim-unimpaired'

" enhanced version of matchit plugin
Plug 'andymass/vim-matchup'

" Easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

" colorscheme
Plug 'svanburen/rams.vim', { 'branch': 'main' }

call plug#end()

lua require('aniseed.env').init()
