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
" use utf-8 for fortune rather than ascii
let g:startify_fortune_use_unicode    = 1
" update startify while vim is running
let g:startify_update_oldfiles        = 1
" use environment variables if they shorten path names
let g:startify_use_env                = 1
" Don't change to the directory of a file when using startify
let g:startify_change_to_dir = 0

" Resizes active windows according to Golden Ratio
" Neat idea in theory - tends to wonk things up in practice
" Plug 'roman/golden-ratio'

" Required for vim-operator-flashy
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'
map y <plug>(operator-flashy)
nmap Y <plug>(operator-flashy)$

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Not terribly useful
" Plug 'bling/vim-bufferline'
let g:airline_theme                              = 'solarized'
let g:airline_powerline_fonts                    = 1
" Don't need this as I have my own tmux statusline config
" let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#tabline#enabled         = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#ale#enabled = 1
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
nnoremap <leader>U :UndotreeToggle<cr>

Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
nnoremap <leader>N :NERDTreeToggle<cr>
nnoremap <C-n> :NERDTreeToggle<cr>
" Quit NERDTree on opening a file
let NERDTreeQuitOnOpen = 1
" Start NERDtree when starting vim
" Nah
" autocmd vimenter * NERDTree
" Show hidden files in NERDTree
let NERDTreeShowHidden=1

Plug 'junegunn/vim-peekaboo'

Plug 'majutsushi/tagbar'
nnoremap <leader>T :TagbarToggle<cr>

Plug 'junegunn/goyo.vim'
function! s:goyo_enter()
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    set noshowmode
    set noshowcmd
    set scrolloff=999
    NumbersDisable
    set nonumber
    set norelativenumber
    Limelight
    set tw=72
    set wrap
    set nolist
    " ...
endfunction

function! s:goyo_leave()
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    set showmode
    set showcmd
    set scrolloff=5
    Limelight!
    NumbersEnable
    set tw=0
    set nowrap
    set list
    " ...
endfunction

let g:goyo_linenr=1

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
" Interferes with incsearch.vim
" Plug 'google/vim-searchindex'

" }}}

" {{{ Git

Plug 'airblade/vim-gitgutter'
" Turns on gitgutter updating for a variety of events
" ex: switch buffers, tabs, etc
let g:gitgutter_eager = 1

Plug 'junegunn/gv.vim'
nmap <leader>gv :GV<cr>

Plug 'tpope/vim-fugitive'
nmap <leader>gd :Gdiff<cr>
nmap <leader>gs :Gstatus<cr>gg<c-n>

" Extends vim-fugitive for GitHub
Plug 'tpope/vim-rhubarb'

" Enhances git commit writing
Plug 'rhysd/committia.vim'

" Better default for diffs
Plug 'chrisbra/vim-diff-enhanced'
" This has trouble when it comes to using vim as git's mergetool, so turning
" off for now
" started In Diff-Mode set diffexpr (plugin not loaded yet)
" if &diff
"     let &diffexpr='EnhancedDiff#Diff("git diff", --diff-algorithm=patience")'
" endif

" }}}

" {{{ Language / Filetype

" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Taskwarrior
Plug 'blindFS/vim-taskwarrior'

" GraphQL
Plug 'jparise/vim-graphql'

" JSON
Plug 'elzr/vim-json'

" Go
Plug 'fatih/vim-go'
let g:go_fmt_command = 'goimports'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_test_prepend_name = 1
" let g:go_auto_type_info = 1
" let g:go_auto_sameids = 1

" Takes a bit too long
" let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
" How long to allow metalinter to run (5s is the default)
let g:go_metalinter_deadline = "5s"

" Org-Mode
Plug 'jceb/vim-orgmode'

" Rust
Plug 'rust-lang/rust.vim', { 'for' : 'rust' }

" Crystal
Plug 'rhysd/vim-crystal'

" Gist
Plug 'mattn/gist-vim'

Plug 'fatih/vim-nginx'

" for prose
" Not super maintained - using ale + vale & write-good instead
" Plug 'reedes/vim-wordy'

" for tmux.conf files
Plug 'tmux-plugins/vim-tmux'
" Plug 'keith/tmux.vim'

" TOML
Plug 'cespare/vim-toml'

" Plug 'jceb/vim-orgmode'
" Plug 'junegunn/vim-journal'

" Python
Plug 'vim-python/python-syntax'

" Pretty laggy
" Plug 'python-mode/python-mode', { 'for' : 'python' }
" let g:pymode_python = 'python3'

" Plug 'sourcegraph/sourcegraph-vim', {'for': ['go']}
" Plug 'lervag/vimtex'
" Plug 'ledger/vim-ledger'
" Plug 'keith/swift.vim'
" Plug 'zah/nimrod.vim', { 'for' : 'nim' }
" Plug 'tpope/vim-fireplace', { 'for' : 'clojure' }

" Language pack
" Plug 'sheerun/vim-polyglot'

" }}}

" {{{ Completion

Plug 'valloric/YouCompleteMe'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments                = 1
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']

Plug 'rdnetto/YCM-Generator', { 'branch' : 'stable' }

" Plug 'ajh17/VimCompletesMe'
" Plug 'Shougo/deoplete.nvim'

" }}}

" {{{ Colorschemes

Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'rakr/vim-one'
Plug 'flazz/vim-colorschemes'

" }}}

" {{{ fzf

Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do' : './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim'
omap <leader><tab> <plug>(fzf-maps-o)
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)

nnoremap <leader><Enter> :Buffers<cr>
nnoremap <leader>m :Marks<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader><leader> :Files<cr>
nnoremap <leader>gf :GFiles<cr>
nnoremap <leader>gc :Commits<cr>
nnoremap <leader>ag :Ag!<cr>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <leader>rg :Rg<cr>

Plug 'Alok/notational-fzf-vim'
let g:nv_search_paths = ['~/nv']
nnoremap <c-l> :NV<cr>

" }}}

" {{{ Linters / Syntax / Formatting

" For linting
Plug 'w0rp/ale'
" let g:ale_sign_error = '💥 '
" let g:ale_sign_warning = '🚧 '
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" let g:ale_linters = {'go': ['gometalinter']}
" let g:ale_go_gometalinter_options = '--fast'

Plug 'sbdchd/neoformat'

" For pasting with indentation
" TODO: I think this plugin breaks certain pasting - investigate!
" Seems like it will force certain text to all paste on one line
" Plug 'sickill/vim-pasta'

" For Java formatting
Plug 'rhysd/vim-clang-format'

" Plug 'google/vim-maktaba'
" Plug 'google/vim-codefmt'
" autocmd FileType java AutoFormatBuffer google-java-format

" linting / make
"Plug 'neomake/neomake'

" Using ale instead
" Plug 'vim-syntastic/syntastic'
" let g:syntastic_vim_checkers = ['vint']
" let g:syntastic_go_checkers  = ['golint', 'govet', 'errcheck']
" let g:syntastic_error_symbol   = "\u2717"
" let g:syntastic_warning_symbol = "\u26A0"
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" }}}

" {{{ Movement / Motions

Plug 'easymotion/vim-easymotion'
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)
nmap <Leader>l <Plug>(easymotion-overwin-line)
nmap s <plug>(easymotion-overwin-f2)
nmap F <plug>(easymotion-overwin-f2)
let g:EasyMotion_do_mapping       = 0
let g:EasyMotion_smartcase        = 1
"let g:EasyMotion_use_upper        = 1
let g:EasyMotion_keys             = 'asdfghjkl;qwertyuiopzxcvbnm'
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_startofline      = 0

" Possible update to incsearch? (TODO: does it provide all the functionality fleshed out below?)
" Plug 'haya14busa/is.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
" Not using fuzzy search for now - add the lines below the plug to the inner
" part of the function below for fuzzy search
" Plug 'haya14busa/incsearch-fuzzy.vim'
" \   'converters': [
" \     incsearch#config#fuzzy#converter(),
" \   ],
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
" Using ? for :GFiles mapping
" noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))
map n <plug>(incsearch-nohl-n)
map N <plug>(incsearch-nohl-N)
let g:incsearch#consistent_n_direction = 1
" These mappings are replaced by vim-asterisk in the following section
" map * <plug>(incsearch-nohl-*)
" map # <plug>(incsearch-nohl-#)

Plug 'haya14busa/vim-asterisk'
let g:asterisk#keeppos = 1

map *  <Plug>(asterisk-z*)
map g* <Plug>(incsearch-nohl2)<Plug>(asterisk-gz*)
map #  <Plug>(incsearch-nohl2)<Plug>(asterisk-z#)
map g# <Plug>(incsearch-nohl2)<Plug>(asterisk-gz#)

map z*  <Plug>(incsearch-nohl)<Plug>(asterisk-*)
map zg* <Plug>(incsearch-nohl)<Plug>(asterisk-g*)
map z#  <Plug>(incsearch-nohl)<Plug>(asterisk-#)
map zg# <Plug>(incsearch-nohl)<Plug>(asterisk-g#)

Plug 'haya14busa/vim-edgemotion'
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
nmap ga <plug>(EasyAlign)
xmap ga <plug>(EasyAlign)

Plug 'terryma/vim-expand-region'
vmap <C-v> <plug>(expand_region_shrink)
vmap v <plug>(expand_region_expand)

" Lightweight version of vim-easymotion
" Plug 'justinmk/vim-sneak'
" Lightweight improvement of search
" Not using because I like the "over" function of easymotion and incsearch
" together
" Plug 'junegunn/vim-slash'

" }}}

" {{{ Search

Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
nnoremap <leader>gr :Grepper -tool git<cr>
" nnoremap <leader>rg :Grepper -tool rg<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

Plug 'rhysd/clever-f.vim'

" Probably unnecessary given other tools
" Plug 'mileszs/ack.vim'

" }}}

" {{{ Commenting

Plug 'tpope/vim-commentary'

" I mostly use g mappings with vim-commentary, rather than <leader> based
" mappings in nerdcommenter
" Plug 'scrooloose/nerdcommenter'
" let g:NERDSpaceDelims = 1

" }}}

" {{{ Documentation

Plug 'keith/investigate.vim'
nnoremap <leader>? :call investigate#Investigate('n')<cr>
nnoremap <leader>K :call investigate#Investigate('n')<cr>
vnoremap <leader>K :call investigate#Investigate('v')<cr>
let g:investigate_use_dash=1

" Roughly redundant, given these settings
Plug 'rizzatti/dash.vim'
nnoremap <leader>D :Dash<cr>
nnoremap <leader>d :Dash<cr>

" }}}

" {{{ Other

" Adds unix shell commands
Plug 'tpope/vim-eunuch'

" Adds end, fi, esac, etc in languages where they are needed
Plug 'tpope/vim-endwise'

" Heuristically set buffer options
Plug 'tpope/vim-sleuth'

" Pong-like game
Plug 'johngrib/vim-game-code-break'

" Browse hackernews in vim
Plug 'ryanss/vim-hackernews'

" For editing prose
Plug 'reedes/vim-pencil'

" Deal with parentheses, quotes, etc.
Plug 'tpope/vim-surround'
" Plug 'machakann/vim-sandwich' "could be looked into as an alternative!

" Disables arrow keys, hljk, page-up / page-down to force using more specific
" motions
Plug 'wikitopian/hardmode'

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

" Easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

" }}}

call plug#end()
filetype plugin indent on

" }}}

" {{{ Settings

colorscheme solarized

set autoindent                     " Automatically indent based on previous line.
set expandtab                      " Convert tabs into spaces.

" Setting these language by language
" set shiftwidth=4                   " >> and << indent by 4 spaces.
" set shiftround                     " >> and << indent to next multiple of 'shiftwidth'.
" set softtabstop=4                  " Tab key indents by 4 spaces.

" set termguicolors

set wrapscan                       " Wrap around the end of the buffer when searching.

set autoread                       " Read changes in files during editing.
set autowriteall                   " Write the file on a lot of different commands.

set background=dark                " Dark background.

set backspace=eol,indent,start     " Make backspacing work regularly.

set cinoptions=N-s                 " For C program indentation.

set foldenable                     " Enable folds.
set foldmethod=marker              " Use markers for folds ({{{ and }}}).

" c: Auto-wrap comments using textwidth, inserting the current comment leader automatically.
" q: Allow formatting of comments with "gq".
" r: Automatically insert the current comment leader after hitting <Enter> in Insert mode.
" t: Auto-wrap text using textwidth
" j: Where it makes sense, remove a comment leader when joining lines
" o: Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set formatoptions=c,q,r,t,j,o

set gdefault                       " Global substitutions by default.

set hidden                         " Don't get rid of hidden buffers.

set history=10000                  " Save 10000 lines of command history.

set infercase                      " For completion

set ignorecase                     " Ignore case while searching
set smartcase                      " ... except when capitals are used
set hlsearch
" unncessary - handled by incsearch.vim
" set incsearch                      " Incrementally search

set laststatus=2                   " Always show the last command.

set lazyredraw                     " Don't redraw when using macros.

set list                           " Displays invisible characters.
set listchars=tab:→-,eol:¬,trail:⋅

set magic                          " For regex

" Not really sure if this is an option anymore
" set mat=2                          " Number of tenths of a second to blink for a match.

set modeline                       " Checks the bottom 1 line for set commands for vim. See bottom of this file.
set modelines=1

set mouse=a                        " Enable mouse for all modes

set nojoinspaces                   " Don't insert two spaces after punctuation with a join command.

set nostartofline

set nobackup
set noswapfile
set tags+=tags;$HOME               " Recurse up to HOME dir for tags
set undodir=~/.vim/undodir
set undofile

set nowrap

" number is controlled by the numbers.vim plugin
" set number

" This is controlled by airline.vim
" set ruler

set scrolljump=8                   " Minimum lines to scroll when cursor is going off the screen.
set scrolloff=3                    " Keep the cursor this many lines away from the top / bottom of screen.
set sidescrolloff=3                " Same, but for left / right sides of the screen.

set showcmd                        " Show the command as it's being typed
set showmatch                      " Show matching brackets briefly.
set showmode                       " Show the mode you're in on the last line. (Somewhat redundant with airline).
set showtabline=2                  " Always show tabline.

set smartindent

set splitbelow                     " On horizontal split, open the split below.
set splitright                     " On veritcal split, open the split to the right.

set synmaxcol=200                  " Don't syntax highlight after 200 columns (for larger files).

set title                          " Set the title of the window.

set ttimeout
set ttimeoutlen=50

set textwidth=0

set updatetime=100                 " Time to write swap file to disk in milliseconds

if has('nvim')
    set shada='100,n$HOME/.vim/files/info/nviminfo
else
    set viminfo='100,n$HOME/.vim/files/info/viminfo
endif

set visualbell t_vb=                " No beeping

set wildmenu
set wildmode=list:longest,full
set wildignore+=*.o,*.pyc,*.DS_STORE,*.db,*~
set wildignorecase

" Some other useful options that I'm not using
" set cursorline
" highlight ColorColumn ctermbg=4 ctermfg=1

" These options are ignored in Neovim
set ttyfast
set t_Co=256

" }}}

" {{{ Mappings

nmap ; :

" In practice these mappings don't do much for me - and they appear to update
" slowly anyways, would rather just use >> and <<
" nmap < <<
" nmap > >>

" Navigate between matching brackets
nmap <tab> %

" Handled by vim-operator-flashy
" nmap Y :normal y$<cr>

" " This is used for re-indenting after a paste
" nnoremap p p'[v']=
nmap <leader>/ :nohl<cr>

" For stripping whitespace - :StripWhiteSpace is provided by vim-better-whitespace
" nmap <leader>W :%s/\s+$//<cr>:let @/=''<cr>
nmap <leader>W :StripWhitespace<cr>

" For editing various configuration files
nmap <leader>eg :e $HOME/.gitconfig<cr>
nmap <leader>ev :e $MYVIMRC<cr>
nmap <leader>ez :e $HOME/.zshrc<cr>

nmap <leader>q :q<cr>
nmap <leader>w :w<cr>

nmap <leader>rt :retab<cr>
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>sp :setlocal spell!<cr>
nmap <leader>sv :mksession<cr>

nmap <leader>v :vsplit<cr>

nnoremap <silent> ]r :tabn<cr>
nnoremap <silent> [r :tabp<cr>

" Swap the behavior of the ^ and 0 operators
" ^ Usually goes to the first non-whitespace character, while 0 goes to the
" first column in the line. ^ is more useful, but harder to hit, so swap it
" with 0
nnoremap 0 ^
nnoremap ^ 0

" This is actually the default behavior - only different for Y
" nnoremap D d$

" Indent the whole file and return to starting position
nnoremap g= gg=G``

nnoremap <silent> j gj
nnoremap <silent> k gk

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap <leader>V V`]
nnoremap <leader>cc :set cc=100<cr>
nnoremap <leader>co :set cc=""<cr>
" This is now used for opening Dash
" nnoremap <leader>d :bd<cr>
nnoremap <leader>f <C-w>w
" I don't really use this
" nnoremap <leader>l :set list!<cr>
nnoremap <leader>sh <C-w>h
nnoremap <leader>sj <C-w>j
nnoremap <leader>sk <C-w>k
nnoremap <leader>sl <C-w>l
nnoremap <leader>x :Vexplore<cr>

" cmap s/ s/\v
cmap %s/ %s/\v
cmap w!! w !sudo tee % >/dev/null

" cnoremap jk <C-c>
" cnoremap kj <C-c>

inoremap <silent> jk <esc>
inoremap <silent> kj <esc>

vmap <leader>s :s/
vmap <tab> %
vmap s :!sort<cr>
vmap u :!sort -u<cr>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

vnoremap j gj
vnoremap k gk

vnoremap < <gv
vnoremap > >gv

" similar to vmap but only for visual mode - NOT select mode
xnoremap < <gv
xnoremap > >gv

" Highlight fenced code in markdown
" https://til.hashrocket.com/posts/e8915e62c0-highlight-markdown-fenced-code-syntax-in-vim
let g:markdown_fenced_languages = ['html', 'vim', 'go', 'python', 'bash=sh']

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
" Trying to match ISO 8601
iab <expr> dts strftime("%y-%m-%d")

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
    " autocmd FileType java set expandtab tabstop=4 shiftwidth=4
    autocmd FileType sh   set shiftwidth=4
    autocmd FileType c    set cindent
    autocmd FileType help wincmd L
    autocmd FileType asciidoc set wrap
    autocmd Filetype crontab setlocal nobackup nowritebackup
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
augroup go
    " FIXME
    " autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    " autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    " autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    " autocmd FileType go nmap <leader>oa :A<cr>
    autocmd FileType go nmap <leader>ob <plug>(go-build)
    autocmd FileType go nmap <leader>oc <plug>(go-coverage-toggle)
    autocmd FileType go nmap <leader>od <plug>(go-doc-vertical)
    autocmd FileType go nmap <leader>oe <plug>(go-rename)
    autocmd FileType go nmap <leader>of <plug>(go-imports)
    autocmd FileType go nmap <leader>og <plug>(go-def-vertical)
    autocmd FileType go nmap <leader>oi <plug>(go-info)
    autocmd FileType go nmap <leader>or <plug>(go-run)
    autocmd FileType go nmap <leader>os <plug>(go-implements)
    autocmd FileType go nmap <leader>ot <plug>(go-test)
    autocmd FileType go nmap <leader>ov <plug>(go-vet)
augroup END

" }}}

" {{{ Local Overrides

let $LOCALFILE=expand("~/.vimrc.local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

" }}}

" vim:foldmethod=marker
