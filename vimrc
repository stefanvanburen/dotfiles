" dot vimrc

" {{{ Basic things

syntax enable

" Leader is space key
let g:mapleader = "\<Space>"

" vim-plug
nnoremap <leader>pc :PlugClean<cr>
nnoremap <leader>pg :PlugUpgrade<cr>
nnoremap <leader>ps :PlugStatus<cr>
nnoremap <leader>pu :PlugUpdate<cr>

" }}}

" {{{ Plugins

scriptencoding utf-8
call plug#begin('~/.vim/plugged')

" {{{ UI

Plug 'mhinz/vim-startify'
let g:startify_bookmarks = [ {'v': '~/.vimrc'}, {'z': '~/.zshrc'} ]

Plug 'google/vim-searchindex'

Plug 'kana/vim-operator-user' " Required for vim-operator-flashy
Plug 'haya14busa/vim-operator-flashy'
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme                              = 'solarized'
let g:airline_powerline_fonts                    = 1
let g:airline#extensions#tabline#enabled         = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <plug>AirlineSelectTab1
nmap <leader>2 <plug>AirlineSelectTab2
nmap <leader>3 <plug>AirlineSelectTab3
nmap <leader>4 <plug>AirlineSelectTab4
nmap <leader>5 <plug>AirlineSelectTab5
nmap <leader>6 <plug>AirlineSelectTab6
nmap <leader>7 <plug>AirlineSelectTab7
nmap <leader>8 <plug>AirlineSelectTab8
nmap <leader>9 <plug>AirlineSelectTab9

Plug 'mbbill/undotree', { 'on' : 'UndotreeToggle' }
let g:undotree_WindowLayout = 2
nnoremap U :UndotreeToggle<cr>

Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
nnoremap <leader>n :NERDTreeToggle<cr>

Plug 'junegunn/vim-peekaboo'

Plug 'majutsushi/tagbar'
nnoremap T :TagbarToggle<cr>

Plug 'junegunn/goyo.vim'
function! s:goyo_enter()
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    set noshowmode
    set noshowcmd
    set scrolloff=999
    Limelight
    set tw=72
    set wrap
    set nolist
    NumbersDisable
    set norelativenumber
    " ...
endfunction

function! s:goyo_leave()
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    set showmode
    set showcmd
    set scrolloff=5
    Limelight!
    set tw=0
    set nowrap
    set list
    NumbersEnable
    " ...
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nmap <leader>G :Goyo<cr>

Plug 'junegunn/limelight.vim'
let g:limelight_conceal_ctermfg = 'darkgray'

Plug 'myusuf3/numbers.vim'

" Better whitespace highlighting / provides :StripWhitespace
Plug 'ntpeters/vim-better-whitespace'

" Enhances builtin netrw file browser
Plug 'tpope/vim-vinegar'

" Highlights the overflowing part of a line that's too long
Plug 'whatyouhide/vim-lengthmatters'
let g:lengthmatters_on_by_default = 0

" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'edkolev/tmuxline.vim'
" Not using this because I'm not using a patched font
" Plug 'ryanoasis/vim-devicons'


" }}}

" {{{ Git

Plug 'airblade/vim-gitgutter'
let g:gitgutter_eager = 1

Plug 'junegunn/gv.vim'

Plug 'tpope/vim-fugitive'
nmap <leader>gd :Gdiff<cr>
nmap <leader>gs :Gstatus<cr>gg<c-n>
nmap <leader>z :GV<cr>

Plug 'rhysd/committia.vim'

" }}}

" {{{ Language / Filetype

Plug 'blindFS/vim-taskwarrior'

Plug 'elzr/vim-json'

Plug 'fatih/vim-go'
let g:go_fmt_command = 'goimports'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1


Plug 'jceb/vim-orgmode'

Plug 'tpope/vim-fireplace', { 'for' : 'clojure' }

Plug 'rust-lang/rust.vim', { 'for' : 'rust' }

Plug 'zah/nimrod.vim', { 'for' : 'nim' }

Plug 'rhysd/vim-crystal'

" for prose
Plug 'reedes/vim-wordy'

" Plug 'junegunn/vim-journal'
" Plug 'klen/python-mode', { 'for' : 'python' }
" Plug 'sourcegraph/sourcegraph-vim', {'for': ['go']}

" Language pack
" Plug 'sheerun/vim-polyglot'

" }}}

" {{{ Completion

Plug 'valloric/YouCompleteMe'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments                = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<C-J>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>', '<C-K>']

Plug 'rdnetto/YCM-Generator', { 'branch' : 'stable' }

" Plug 'ajh17/VimCompletesMe'
" Plug 'Shougo/deoplete.nvim'

" }}}

" {{{ Colorschemes

Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'rakr/vim-one'

" }}}

" {{{ fzf

Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do' : './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim'
omap <leader><tab> <plug>(fzf-maps-o)
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
nnoremap <leader><Enter> :Buffers<cr>
nnoremap <leader>` :Marks<cr>
nnoremap <leader>ag :Ag<cr>
map <leader><leader> :Files<cr>

Plug 'Alok/notational-fzf-vim'
let g:nv_directories = ['~/Dropbox/Apps/notational_velocity']
nnoremap <c-l> :NV<cr>

" }}}

" {{{ Linters / Syntax / Formatting

Plug 'w0rp/ale'

Plug 'sbdchd/neoformat'

" linting / make
" Plug 'neomake/neomake'

" Plug 'vim-syntastic/syntastic'
" let g:syntastic_vim_checkers = ['vint']
" let g:syntastic_go_checkers  = ['golint', 'govet', 'errcheck']
" let g:syntastic_error_symbol   = "\u2717"
" let g:syntastic_warning_symbol = "\u26A0"

" }}}

" {{{ Movement / Motions

Plug 'easymotion/vim-easymotion'
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)
nmap s <plug>(easymotion-overwin-f)
let g:EasyMotion_do_mapping       = 0
let g:EasyMotion_smartcase        = 1
let g:EasyMotion_keys             = 'asdfghjkl;qwertyuiopzxcvbnm'
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_startofline      = 0

Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch.vim'
let g:incsearch#auto_nohlsearch = 1
function! s:incsearch_config(...) abort
    return incsearch#util#deepextend(deepcopy({
                \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
                \   'keymap': {
                \     "\<CR>": '<Over>(easymotion)'
                \   },
                \   'is_expr': 0
                \ }), get(a:, 1, {}))
endfunction
noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
let g:incsearch#consistent_n_direction = 1

Plug 'junegunn/vim-easy-align'
nmap ga <plug>(EasyAlign)
xmap ga <plug>(EasyAlign)

Plug 'terryma/vim-expand-region'
vmap <C-v> <plug>(expand_region_shrink)
vmap v <plug>(expand_region_expand)

" Lightweight version of vim-easymotion
" Plug 'justinmk/vim-sneak'
" Lightweight improvement of search
" Plug 'junegunn/vim-slash'

" }}}

" {{{ Search

Plug 'mileszs/ack.vim'

Plug 'mhinz/vim-grepper'
nnoremap <leader>gr :Grepper -tool git<cr>
nnoremap <leader>rg :Grepper -tool ag<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

Plug 'rhysd/clever-f.vim'

" }}}

" {{{ Commenting

Plug 'tpope/vim-commentary'

Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1

" }}}

" {{{ Documentation

Plug 'keith/investigate.vim'
map <leader>? :call investigate#Investigate()<cr>

Plug 'rizzatti/dash.vim'

" }}}

" {{{ Other

Plug 'johngrib/vim-game-code-break'

Plug 'ryanss/vim-hackernews'

Plug 'tmux-plugins/vim-tmux'

" Deal with parentheses, quotes, etc.
Plug 'tpope/vim-surround'

" Manage session files
Plug 'tpope/vim-obsession'

" Repeat plugin maps
Plug 'tpope/vim-repeat'

" Use ^a / ^x to increment / decrement dates, times, etc.
Plug 'tpope/vim-speeddating'

" Handy bracket ( ] and [ ) mappings
Plug 'tpope/vim-unimpaired'

" Text exchange operator (cx)
Plug 'tommcdo/vim-exchange'

" Manages and creates tag files
Plug 'ludovicchabant/vim-gutentags'

" }}}

call plug#end()
filetype plugin indent on

" }}}

" {{{ Settings

colorscheme solarized

set autoindent                     " Automatically indent based on previous line.
set expandtab                      " Convert tabs into spaces.
set shiftwidth=4                   " >> indents by 4 spaces.
set shiftround                     " >> indents to next multiple of 'shiftwidth'.
set softtabstop=4                  " Tab key indents by 4 spaces.

" set termguicolors

set wrapscan                       " Wrap around the end of the buffer when searching.

set autoread                       " Read changes in files during editing.
set autowriteall                   " Write the file on a lot of different commands.

set background=dark                " Dark background.

set backspace=eol,indent,start     " Make backspacing work regularly.

set cinoptions=N-s                 " For C program indentation.

set foldenable                     " Enable folds.

set formatoptions=c,q,r,t,j,o      " test

set gdefault                       " Global substitutions by default

set hidden                         " Don't get rid of hidden buffers

set history=10000                  " Save 10000 lines of command history

set infercase                      " For completions (replaces ignorecase)

set incsearch                      " Incrementally search

set laststatus=2                   " Always show the last command.

set lazyredraw                     " Don't redraw when using macros.

set list                           " Displays invisible characters.
set listchars=tab:→-,eol:¬,trail:⋅

set magic                          " For regex

set mat=2                          " Number of tenths of a second to blink for a match.

set modelines=1

set nojoinspaces                   " Don't insert two spaces after punctuation with a join command.

set nostartofline

set nobackup
set noswapfile
set tags+=tags;$HOME               " Recurse up to HOME dir for tags
set undodir=~/.vim/undodir
set undofile

set nowrap

" set number
set ruler
set scrolljump=8
set scrolloff=3

set showcmd
set showmatch
set showmode
set showtabline=2                  " Always show tabline.

set smartcase
set smartindent

set splitbelow                     " On horizontal split, open the split below.
set splitright                     " On veritcal split, open the split to the right.

set synmaxcol=200                  " Don't syntax highlight after 200 columns (for larger files).
set title                          " Set the title of the window.
set ttimeout
set ttimeoutlen=50
set textwidth=0

set updatetime=250                 " Time to update in milliseconds
set visualbell

set wildignore+=*.o,*.pyc,*.DS_STORE,*.db,*~
set wildmenu
set wildmode=list:longest,full

" Some other useful options that I'm not using
" set cursorline
" highlight ColorColumn ctermbg=4 ctermfg=1

" These options are ignored in Neovim
set ttyfast
set t_Co=256

" }}}

" {{{ Mappings

nmap ; :
nmap < <<
nmap > >>
nmap <tab> %
nmap Y :normal y$<cr>
nmap p p'[v']=
nmap <leader>/ :nohl<cr>
nmap <leader>W :%s/\s+$//<cr>:let @/=''<cr>

nmap <leader>eg :e $HOME/.gitconfig<cr>
nmap <leader>ev :e $MYVIMRC<cr>
nmap <leader>ez :e $HOME/.zshrc<cr>

nmap <leader>ms :mksession<cr>
nmap <leader>q :q<cr>
nmap <leader>rt :retab<cr>
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>sp :setlocal spell!<cr>
nmap <leader>sv :mksession<cr>
nmap <leader>v :vsplit<cr>
nmap <leader>w :w<cr>

nnoremap ]r :tabn<cr>
nnoremap [r :tabp<cr>
nnoremap 0 ^
nnoremap ^ 0
nnoremap D d$
nnoremap g= gg=G``
nnoremap j gj
nnoremap k gk
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <leader>V V`]
nnoremap <leader>cc :set cc=100<cr>
nnoremap <leader>co :set cc=""<cr>
nnoremap <leader>d :bd<cr>
nnoremap <leader>f <C-w>w
nnoremap <leader>l :set list!<cr>
nnoremap <leader>sh <C-w>h
nnoremap <leader>sj <C-w>j
nnoremap <leader>sk <C-w>k
nnoremap <leader>sl <C-w>l
nnoremap <leader>x :Vexplore<cr>

cmap %s/ %s/\v
cmap w!! w !sudo tee % >/dev/null

cnoremap jk <C-c>
cnoremap kj <C-c>

inoremap jk <esc>
inoremap kj <esc>

vmap <leader>s :s/
vmap <tab> %
vmap s :!sort<cr>
vmap u :!sort -u<cr>

vnoremap / /\v

xnoremap < <gv
xnoremap > >gv

" open files in netrw in vertical split
let g:netrw_browse_split = 2
" take 25% of the window
let g:netrw_winsize = 25
" tree-style netrw
let g:netrw_liststyle = 3

if executable('rg')
    set grepprg=rg\ --vimgrep
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
    set grepprg=ag\ --nogroup\ --nocolor
endif

" Abbreviations
iab <expr> dts strftime("%m/%d/%y")

" }}}

" {{{ Highlights

highlight IncSearch   ctermbg=1 ctermfg=4
highlight MatchParen  ctermbg=1 ctermfg=4
highlight VertSplit   ctermbg=1
highlight Visual      ctermbg=1 ctermfg=4

" }}}

" {{{ Autocommands

augroup FT
    autocmd FileType go   set noexpandtab tabstop=4 shiftwidth=4
    autocmd FileType java set expandtab tabstop=4 shiftwidth=4
    autocmd FileType sh   set shiftwidth=4
    autocmd FileType c    set cindent
    autocmd FileType help wincmd L
    autocmd FileType asciidoc set wrap
augroup end

augroup task
    autocmd BufRead,BufNewFile {pending,completed,undo}.data set filetype=taskdata
    autocmd BufRead,BufNewFile .taskrc                       set filetype=taskrc
    autocmd BufRead,BufNewFile *.task                        set filetype=taskedit
augroup END

" Resize splits when window is resized
augroup window
    autocmd VimResized * :wincmd =
augroup END

" Go related mappings
" All are prefixed with 'o', because 'g' is for git
augroup GO
    autocmd FileType go nmap <leader>ob <Plug>(go-build)
    autocmd FileType go nmap <leader>oc <Plug>(go-coverage-toggle)
    autocmd FileType go nmap <leader>od <Plug>(go-doc-vertical)
    autocmd FileType go nmap <leader>oe <Plug>(go-rename)
    autocmd FileType go nmap <leader>of <Plug>(go-imports)
    autocmd FileType go nmap <leader>og <Plug>(go-def-vertical)
    autocmd FileType go nmap <leader>oi <Plug>(go-info)
    autocmd FileType go nmap <leader>or <Plug>(go-run)
    autocmd FileType go nmap <leader>os <Plug>(go-implements)
    autocmd FileType go nmap <leader>ot <Plug>(go-test)
    autocmd FileType go nmap <leader>ov <Plug>(go-vet)
augroup END

" }}}

" {{{ Local Overrides

let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

" }}}

" vim:foldmethod=marker
