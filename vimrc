" dot vimrc

command -nargs=+ -complete=file -bar Agtemp silent! grep! <args>|cwindow|redraw!
nnoremap \ :Agtemp<SPACE>
" {{{ Plug

scriptencoding utf-8
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'edkolev/tmuxline.vim'
Plug 'farseer90718/vim-taskwarrior'
Plug 'fatih/vim-go'
Plug 'vim-scripts/LanguageTool'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/vim-operator-flashy'
Plug 'jceb/vim-orgmode'
Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do' : './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'kana/vim-operator-user' " Required for vim-operator-flashy
Plug 'keith/investigate.vim'
Plug 'klen/python-mode', { 'for' : 'python' }
Plug 'lokaltog/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree', { 'on' : 'UndotreeToggle' }
"Plug 'sourcegraph/sourcegraph-vim', {'for': ['go']}
Plug 'mileszs/ack.vim'
Plug 'mhinz/vim-startify'
Plug 'myusuf3/numbers.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rdnetto/YCM-Generator', { 'branch' : 'stable' }
Plug 'reedes/vim-wordy'
Plug 'rust-lang/rust.vim', { 'for' : 'rust' }
Plug 'ryanoasis/vim-devicons'
Plug 'ryanss/vim-hackernews'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fireplace', { 'for' : 'clojure' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'whatyouhide/vim-lengthmatters'
Plug 'zah/nimrod.vim', { 'for' : 'nim' }

call plug#end()
filetype plugin indent on

" }}}
" {{{ Basic things

syntax enable

colorscheme solarized

 " Leader is space key
let g:mapleader = "\<Space>"

" }}}
" {{{ Settings

set autoindent
set autoread                                " Read changes in files during editing.
set autowriteall
set background=dark                         " Dark background
set backspace=eol,indent,start              " Make backspacing work regularly.
set cinoptions=N-s
set expandtab
set foldenable
set formatoptions=c,q,r,t,j,o               " test
set hidden                                  " Don't get rid of hidden buffers
set history=10000                           " Save 10000 lines of command history
set ignorecase
set incsearch
set laststatus=2                            " Always show the last command.
set lazyredraw                              " Don't redraw when using macros.
set list                                    " Displays invisible characters.
set listchars=tab:→-,eol:¬,trail:⋅
set magic                                   " For regex
set mat=2                                   " Number of tenths of a second to blink
set modelines=1
set nobackup
set nojoinspaces                            " Don't insert two spaces after punctuation with a join command
set nostartofline
set noswapfile
set nowrap
set number
set ruler
set scrolljump=8
set scrolloff=3
set shiftwidth=4
set showcmd
set showmatch
set showmode
set showtabline=2                           " Always show tabs in vim
set smartcase
set smartindent
set splitbelow                              " On horizontal split, open the split below.
set splitright                              " On veritcal split, open the split to the right.
set t_Co=256
set tabstop=4
set tags+=tags;$HOME                        " Recurse up to HOME dir for tags
set title                                   " Set the title of the window
set ttimeout
set ttimeoutlen=50
set ttyfast
set textwidth=0
set undodir=~/.vim/undodir
set undofile
set updatetime=250                          " Time to update in milliseconds
set visualbell
set wildignore+=*.o,*.pyc,*.DS_STORE,*.db,*~
set wildmenu
set wildmode=list:longest,full

" }}}
" {{{ Plugin Configuration

let g:airline_theme                              = 'solarized'
let g:airline_powerline_fonts                    = 0
let g:airline#extensions#tabline#enabled         = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_left_sep='›'
let g:airline_right_sep='‹'

let g:EasyMotion_do_mapping       = 0
let g:EasyMotion_smartcase        = 1
let g:EasyMotion_keys             = 'asdfghjkl;qwertyuiopzxcvbnm'
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_startofline      = 0

let g:incsearch#auto_nohlsearch = 1

let g:gitgutter_eager = 1

let g:go_fmt_command = 'goimports'
" let g:go_metalinter_command = 'gometalinter'
" let g:go_metalinter_enable = ['vet', 'golint', 'errcheck', 'gotype', 'gofmt', 'goimports', 'testify', 'test', 'dupl', 'structcheck', 'aligncheck', 'gocyclo', 'ineffassign', 'vetshadow', 'varcheck', 'deadcode', 'interfacer', 'goconst', 'gosimple', 'staticcheck']

let g:incsearch#consistent_n_direction = 1

let g:lengthmatters_on_by_default = 0

" Insert a space after using NERDCommenter
let g:NERDSpaceDelims = 1

let g:syntastic_vim_checkers = ['vint']
let g:syntastic_go_checkers  = ['golint', 'govet', 'errcheck']

let g:syntastic_error_symbol   = "\u2717"
let g:syntastic_warning_symbol = "\u26A0"

let g:undotree_WindowLayout = 2

let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments                = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<C-J>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>', '<C-K>']

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" }}}
" {{{ Highlights

highlight ColorColumn ctermbg=4 ctermfg=1
highlight IncSearch   ctermbg=1 ctermfg=4
highlight MatchParen  ctermbg=1 ctermfg=4
highlight VertSplit   ctermbg=1
highlight Visual      ctermbg=1 ctermfg=4

" }}}
" {{{ Mappings

" Command Mode:
cmap %s/ %s/\v
cmap w!! w !sudo tee % >/dev/null
cnoremap jk <C-c>
cnoremap kj <C-c>

" Insert Mode:
inoremap jk <esc>
inoremap kj <esc>

" Mappings:
map <leader><leader> :Files<cr>
map <leader>? :call investigate#Investigate()<cr>
map <leader>h :GitGutterLineHighlightsToggle<cr>
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)

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

" Normal Mode:
nmap ; :
nmap < <<
nmap > >>
nnoremap j gj
nnoremap k gk
nmap <leader>/ :nohl<cr>
nmap <leader>1 <plug>AirlineSelectTab1
nmap <leader>2 <plug>AirlineSelectTab2
nmap <leader>3 <plug>AirlineSelectTab3
nmap <leader>4 <plug>AirlineSelectTab4
nmap <leader>5 <plug>AirlineSelectTab5
nmap <leader>6 <plug>AirlineSelectTab6
nmap <leader>7 <plug>AirlineSelectTab7
nmap <leader>8 <plug>AirlineSelectTab8
nmap <leader>9 <plug>AirlineSelectTab9
nmap <leader><tab> <plug>(fzf-maps-n)
nmap <leader>G :Goyo<cr>
nmap <leader>W :%s/\s+$//<cr>:let @/=''<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>ev :e $MYVIMRC<cr>
nmap <leader>eg :e $HOME/.gitconfig<cr>
nmap <leader>ez :e $HOME/.zshrc<cr>
nmap <leader>gs :Gstatus<cr>gg<c-n>
nmap <leader>ms :mksession<cr>
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>sp :setlocal spell!<cr>
nmap <leader>q :q<cr>
nmap <leader>r :retab<cr>
nmap <leader>v :vsplit<cr>
nmap <leader>w :w<cr>
nmap <leader>z :GV<cr>
nmap <tab> %
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
nmap ga <plug>(EasyAlign)
nmap s <plug>(easymotion-overwin-f)
nnoremap + :bn<cr>
nnoremap - :bp<cr>
nnoremap 0 ^
nnoremap <C-j> <C-d>zz
nnoremap <C-k> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <leader>V V]
nnoremap <leader>d :bd<cr>
nnoremap <leader>f <C-w>w
nnoremap <leader>l :set list!<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader><Enter> :Buffers<cr>
nnoremap <leader>ag :Ag<cr>
nnoremap <leader>` :Marks<cr>
nnoremap <leader>pu :PlugUpdate<cr>
nnoremap <leader>pg :PlugUpdate<cr>
nnoremap <leader>pc :PlugClean<cr>
nnoremap <leader>ps :PlugStatus<cr>
nnoremap <leader>sl <C-w>l
nnoremap <leader>sh <C-w>h
nnoremap <leader>sj <C-w>j
nnoremap <leader>sk <C-w>k
nnoremap D d$
nnoremap U :UndotreeToggle<cr>
nnoremap T :TagbarToggle<cr>
nnoremap [b :bp<cr>
nnoremap [l :lprev<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap [t :tabp<cr>
nnoremap ]b :bn<cr>
nnoremap ]l :lnext<cr>zz
nnoremap ]q :cnext<cr>zz
nnoremap ]t :tabn<cr>
nnoremap ^ 0
nnoremap g= gg=G``
nnoremap <leader>cc :set cc=100<cr>
nnoremap <leader>co :set cc=""<cr>

" Operator Pending Mode:
omap <leader><tab> <plug>(fzf-maps-o)

" Visual Mode:
vmap <C-v> <plug>(expand_region_shrink)
vmap v <plug>(expand_region_expand)
vmap <leader>s :s/
vmap <tab> %
vmap s :!sort<cr>
vmap u :!sort -u<cr>
vnoremap / /\v

" Visual And Select Mode:
xmap <leader><tab> <plug>(fzf-maps-x)
xmap ga <plug>(EasyAlign)
xnoremap < <gv
xnoremap > >gv

" ----------------------------------------------------------------------------
" <Leader>?/! | Google it / Feeling lucky
" ----------------------------------------------------------------------------
function! s:goog(pat, lucky)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://www.google.com/search?%sq=%s"',
                   \ a:lucky ? 'btnI&' : '', q))
endfunction

nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 0)<cr>
nnoremap <leader>@ :call <SID>goog(expand("<cWORD>"), 1)<cr>

" }}}
" {{{ Autocommands

augroup FT
    autocmd FileType go   set noexpandtab tabstop=4 shiftwidth=4
    autocmd FileType java set noexpandtab tabstop=4 shiftwidth=4
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

augroup Goyo
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
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

" vim:foldmethod=marker
