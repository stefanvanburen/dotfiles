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
let g:startify_fortune_use_unicode = 1
" update startify while vim is running
let g:startify_update_oldfiles = 1
" use environment variables if they shorten path names
" Not terribly useful honestly
" let g:startify_use_env = 1
" Don't change to the directory of a file when using startify
let g:startify_change_to_dir = 0

" Resizes active windows according to Golden Ratio
" Neat idea in theory - tends to wonk things up in practice
" Plug 'roman/golden-ratio'

" replaces vim-operator-flashy
Plug 'machakann/vim-highlightedyank'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Not terribly useful
" Plug 'bling/vim-bufferline'
let g:airline_theme = 'solarized'
" let g:airline_powerline_fonts = 1
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

" Plug 'itchyny/lightline.vim'
" let g:lightline = {
"       \ 'colorscheme': 'solarized',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'fugitive#head'
"       \ }
"       \ }
" I can't seem to get this working quite yet.
" Plug 'maximbaz/lightline-ale'
" let g:lightline.component_type = {
"       \     'linter_checking': 'left',
"       \     'linter_warnings': 'warning',
"       \     'linter_errors': 'error',
"       \     'linter_ok': 'left',
"       \ }

" let g:lightline#ale#indicator_checking = "\uf110"
" let g:lightline#ale#indicator_warnings = "\uf071"
" let g:lightline#ale#indicator_errors = "\uf05e"
" let g:lightline#ale#indicator_ok = "\uf00c"

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
let g:undotree_WindowLayout = 2
nnoremap <leader>U :UndotreeToggle<cr>

" Vim undo tree visualizer
" fork of sjl/gundo.vim
Plug 'simnalamburt/vim-mundo'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
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

" disable netrw_
let loaded_netrwPlugin = 1
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
" Plug 'mhinz/vim-tree'

Plug 'junegunn/vim-peekaboo'

Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
nnoremap <leader>T :TagbarToggle<cr>

Plug 'liuchengxu/vista.vim'
let g:vista#renderer#enable_icon = 1

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
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

Plug 'junegunn/limelight.vim', { 'on': 'LimeLight' }
let g:limelight_conceal_ctermfg = 'darkgray'

Plug 'myusuf3/numbers.vim'
nnoremap <leader>nt :NumbersToggle<cr>
nnoremap <leader>no :NumbersOnOff<cr>

" Better whitespace highlighting / provides :StripWhitespace
Plug 'ntpeters/vim-better-whitespace'

" Enhances builtin netrw file browser
" Note that netrw is disabled and we're using dirvish
" Plug 'tpope/vim-vinegar'

" Highlights the overflowing part of a line that's too long
" TODO: test if this works
Plug 'whatyouhide/vim-lengthmatters', { 'on': 'LengthMatters' }
let g:lengthmatters_on_by_default = 0

" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'edkolev/tmuxline.vim'
" Not using this because I'm not using a patched font
" Plug 'ryanoasis/vim-devicons'
" Interferes with incsearch.vim
" Plug 'google/vim-searchindex'

" }}}

" {{{ Git

" Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'
" Turns on gitgutter updating for a variety of events
" ex: switch buffers, tabs, etc
" let g:gitgutter_eager = 1
let g:gitgutter_sign_added = '·'
let g:gitgutter_sign_modified = '·'
let g:gitgutter_sign_removed = '·'
let g:gitgutter_sign_removed_first_line = '·'
let g:gitgutter_sign_modified_removed = '·'

Plug 'junegunn/gv.vim'
nmap <leader>gv :GV<cr>

Plug 'tpope/vim-fugitive'
nmap <leader>gd :Gdiff<cr>
" Bring up git status vertically
nmap <silent> <leader>gs :vertical Gstatus<cr>

" Extends vim-fugitive for GitHub
Plug 'tpope/vim-rhubarb'

" Adds completion for github
Plug 'rhysd/github-complete.vim'

" Git branch viewer
Plug 'rbong/vim-flog'

" Gitk for vim
Plug 'gregsexton/gitv', {'on': ['Gitv']}

" Git branch management
Plug 'sodapopcan/vim-twiggy', { 'on': 'Twiggy' }

" Enhances git commit writing
Plug 'rhysd/committia.vim'

" github filetype
Plug 'rhysd/vim-github-support'

" reveal last commit message
Plug 'rhysd/git-messenger.vim'
        " Header such as 'Commit:', 'Author:'
        hi link gitmessengerHeader Identifier

        " Commit hash at 'Commit:' header
        hi link gitmessengerHash Comment

        " History number at 'History:' header
        hi link gitmessengerHistory Constant

        " Normal color. This color is the most important
        hi link gitmessengerPopupNormal CursorLine

" github issues
" Seems to have some issues itself
" Plug 'jaxbot/github-issues.vim'

" For git files
" This shouldn't be needed after vim 7.2
" Plug 'tpope/vim-git'

" Better default for diffs
" Turning this off completely, it seems like it's not needed anymore?
" https://github.com/chrisbra/vim-diff-enhanced#update
" Plug 'chrisbra/vim-diff-enhanced'
" This has trouble when it comes to using vim as git's mergetool, so turning
" off for now
" started In Diff-Mode set diffexpr (plugin not loaded yet)
" if &diff
"     let &diffexpr='EnhancedDiff#Diff("git diff", --diff-algorithm=patience")'
" endif

" }}}

" {{{ Languages / Filetype

" This is still a bit beta, had some issues with using it. Sticking with ALE
" for the time being.
" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
"         " always show signcolumns
"         set signcolumn=yes

"         " Use tab for trigger completion with characters ahead and navigate.
"         " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"         inoremap <silent><expr> <TAB>
"               \ pumvisible() ? "\<C-n>" :
"               \ <SID>check_back_space() ? "\<TAB>" :
"               \ coc#refresh()
"         inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"         function! s:check_back_space() abort
"           let col = col('.') - 1
"           return !col || getline('.')[col - 1]  =~# '\s'
"         endfunction

"         " Use <c-space> to trigger completion.
"         inoremap <silent><expr> <c-space> coc#refresh()

"         " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"         " Coc only does snippet and additional edit on confirm.
"         inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"         " Use `[c` and `]c` to navigate diagnostics
"         nmap <silent> [c <Plug>(coc-diagnostic-prev)
"         nmap <silent> ]c <Plug>(coc-diagnostic-next)

"         " Remap keys for gotos
"         nmap <silent> gd <Plug>(coc-definition)
"         nmap <silent> gy <Plug>(coc-type-definition)
"         nmap <silent> gi <Plug>(coc-implementation)
"         nmap <silent> gr <Plug>(coc-references)

"         " Use K to show documentation in preview window
"         nnoremap <silent> K :call <SID>show_documentation()<CR>

"         function! s:show_documentation()
"           if (index(['vim','help'], &filetype) >= 0)
"             execute 'h '.expand('<cword>')
"           else
"             call CocAction('doHover')
"           endif
"         endfunction

"         " Highlight symbol under cursor on CursorHold
"         autocmd CursorHold * silent call CocActionAsync('highlight')

"         " Remap for rename current word
"         nmap <leader>rn <Plug>(coc-rename)

"         " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"         vmap <leader>a  <Plug>(coc-codeaction-selected)
"         nmap <leader>a  <Plug>(coc-codeaction-selected)

"         " Remap for do codeAction of current line
"         nmap <leader>ac  <Plug>(coc-codeaction)
"         " Fix autofix problem of current line
"         nmap <leader>qf  <Plug>(coc-fix-current)

"         " Use `:Format` to format current buffer
"         command! -nargs=0 Format :call CocAction('format')

"         " Use `:Fold` to fold current buffer
"         command! -nargs=? Fold :call     CocAction('fold', <f-args>)<Paste>j

" yaml
Plug 'stephpy/vim-yaml'

" elixir
Plug 'elixir-editors/vim-elixir'

" chucK
Plug 'wilsaj/chuck.vim'

" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
        let g:UltiSnipsExpandTrigger="<TAB>"
        let g:UltiSnipsJumpForwardTrigger="<TAB>"
        let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit="vertical"

" Taskwarrior
Plug 'blindFS/vim-taskwarrior', { 'on': 'TW' }

" Elm
Plug 'elmcast/elm-vim'

" HTML5
Plug 'othree/html5.vim'

" Javascript
" note that prettier has docs for setting up with ALE
" less configuration, though
" TODO: set this up with ALE if I want to use it
" Plug 'prettier/vim-prettier', {
"                         \ 'do': 'yarn install',
"                         \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss']}

" Markdown
Plug 'plasticboy/vim-markdown'
" Turn off folding
let g:vim_markdown_folding_disabled = 1
" Alternative:
" Plug 'tpope/vim-markdown'

" GraphQL
Plug 'jparise/vim-graphql', { 'for': 'graphql' }

" JSON
Plug 'elzr/vim-json'
" Don't really care for the concealing
let g:vim_json_syntax_conceal = 0

" Protocol Buffers (protobuf)
Plug 'uarun/vim-protobuf', { 'for': 'protobuf' }
Plug 'uber/prototool', { 'rtp': 'vim/prototool' }

" Dockerfile
Plug 'ekalinin/Dockerfile.vim'

" gitignore
" Causes some problems with UltiSnips
" Plug 'gisphm/vim-gitignore'

" Go
" make sure to do :GoInstallBinaries on new systems
" if has('nvim')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
        let g:go_fmt_command = 'goimports'
        let g:go_highlight_functions = 1
        let g:go_highlight_methods = 1
        let g:go_highlight_generate_tags = 1
        let g:go_highlight_fields = 1
        let g:go_highlight_types = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_build_constraints = 1
        " use golangci-lint
        let g:go_metalinter_command = 'golangci-lint'
        let g:go_def_mode = 'gopls'
        let g:go_info_mode = 'gopls'
        let g:go_test_show_name = 1
        " This doesn't work quite as well as guru
        " let g:go_def_mode = 'godef'
        " These make things slow
        " let g:go_auto_type_info = 1
        " let g:go_auto_sameids = 1
        let g:go_fmt_options = {
        \ 'gofmt': '-s',
        \ }
        " Takes a bit too long
        " let g:go_metalinter_autosave = 1
        let g:go_metalinter_autosave_enabled = ['vet', 'golint']
        " How long to allow metalinter to run (5s is the default)
        let g:go_metalinter_deadline = "5s"
" else
" This is promising, but not now
" Something is wrong with this - not entirely sure what
" Plug 'myitcv/govim'
" endif

Plug 'buoto/gotests-vim', { 'for': 'go' }

" Org-Mode
Plug 'jceb/vim-orgmode'

" Logs
Plug 'dzeban/vim-log-syntax'
" Plug 'andreshazard/vim-logreview'

" Rust
Plug 'rust-lang/rust.vim', { 'for' : 'rust' }
let g:rustfmt_autosave = 1

" vgo
Plug 'zchee/vim-vgo'

" Crystal
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }

" Gist
Plug 'mattn/gist-vim', { 'for': 'gist' }

" nginx
Plug 'fatih/vim-nginx'

" for prose
" Not super maintained - using ale + vale & write-good instead
" Plug 'reedes/vim-wordy'

" for tmux.conf files
Plug 'tmux-plugins/vim-tmux'
" Plug 'keith/tmux.vim'

" TOML
Plug 'cespare/vim-toml'

" Terraform
Plug 'hashivim/vim-terraform'

" Plug 'jceb/vim-orgmode'
" Plug 'junegunn/vim-journal'

" Python
" Syntax
Plug 'vim-python/python-syntax', { 'for': 'python' }
let g:python_highlight_all = 1

" Quickly open python modules
Plug 'sloria/vim-ped'

" Indent
Plug 'Vimjas/vim-python-pep8-indent'

" Trying this again, despite the lag
" TOO MUCH
" Plug 'python-mode/python-mode', { 'branch': 'develop', 'for': 'python' }
" let g:pymode_python = 'python3'
" " Turn off folding
" let g:pymode_folding = 1
" " match black's default
" let g:pymode_options_max_line_length = 88

" NOTE: using ale's black integration for this, instead
" Plug 'ambv/black', { 'on': 'Black' }

Plug 'alfredodeza/pytest.vim'
Plug 'alfredodeza/coveragepy.vim'

Plug 'fisadev/vim-isort', { 'for': 'python' }
Plug 'davidhalter/jedi-vim'
        let g:jedi#goto_command = "<C-]>"
        " we use deoplete's jedi instead
        let g:jedi#completions_enabled = 0

" For mypy
" Using ALE instead
" Plug 'Integralist/vim-mypy', { 'for': 'python' }

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

" TODO: for python, I should probably follow this:
" http://valloric.github.io/YouCompleteMe/#configuring-through-vim-options
" Plug 'valloric/YouCompleteMe'
"         let g:ycm_collect_identifiers_from_tags_files = 1
"         let g:ycm_complete_in_comments                = 1
"         let g:ycm_key_list_select_completion = ['<C-j>']
"         let g:ycm_key_list_previous_completion = ['<C-k>']
"         " commenting this out to use virtualenv python
"         let g:ycm_python_binary_path = 'python'

" Plug 'rdnetto/YCM-Generator', { 'branch' : 'stable' }

" Plug 'ajh17/VimCompletesMe'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'deoplete-plugins/deoplete-jedi'

" ???
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" }}}

" {{{ Colorschemes

Plug 'morhetz/gruvbox'
        let g:gruvbox_contrast_dark = 'hard'

Plug 'lifepillar/vim-solarized8'
Plug 'altercation/vim-colors-solarized'
Plug 'rakr/vim-one'
Plug 'rakr/vim-two-firewatch'
Plug 'flazz/vim-colorschemes'
Plug 'rhysd/vim-color-spring-night'
Plug 'ayu-theme/ayu-vim'

" }}}

" {{{ fzf

Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do' : './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim'
omap <leader><tab> <plug>(fzf-maps-o)
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)

nnoremap <leader><Enter> :GFiles<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>gf :GFiles?<cr>
" nnoremap ; :Buffers<cr>
nnoremap <leader><leader> :Buffers<cr>
nnoremap <leader>m :Marks<cr>
nnoremap <leader>tg :Tags<cr>
nnoremap <leader>sn :Snippets<cr>
" nnoremap <leader>gf :GFiles<cr>
nnoremap <leader>gc :Commits!<cr>
" nnoremap <leader>ag :Ag!<cr>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --smart-case --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <leader>se :Rg<cr>

command! -bang Directories call fzf#run(fzf#wrap({'source': 'find * -type d'}))

" XXX: I don't really use this
" Plug 'Alok/notational-fzf-vim'
" let g:nv_search_paths = ['~/nv']
" nnoremap <c-l> :NV<cr>

" }}}

" {{{ Linters / Syntax / Formatting

" Enable completion where available.
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 0
" For linting
Plug 'w0rp/ale'
        " slow
        " let g:ale_sign_error = '💥 '
        " let g:ale_sign_warning = '🚧 '
        let g:ale_sign_error = '⨯⨯'
        let g:ale_sign_warning = '⦁⦁'
        highlight clear ALEErrorSign
        highlight clear ALEWarningSign
        let g:ale_echo_msg_error_str = 'E'
        let g:ale_echo_msg_warning_str = 'W'
        let g:ale_echo_msg_format = '[%linter%] %s (%code%) [%severity%]'
        " let g:ale_python_auto_pipenv = 1
        " let g:ale_lint_on_text_changed = 'normal'
        " let g:ale_lint_on_insert_leave = 1
        let g:ale_set_balloons = 1
        " Set this variable to 1 to fix files when you save them.
        let g:ale_fix_on_save = 1
        " don't need this as we're setting VIRTUAL_ENV using direnv
        " https://github.com/w0rp/ale/issues/2021#issuecomment-433325140
        let g:ale_virtualenv_dir_names = []
        " note that python files have their ALE configuration in ftplugin/python.vim
        " Without this, eslint complains about things that prettier fixes
        let g:ale_fixers = {
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \   'javascript': ['prettier', 'eslint'],
        \}
        let g:ale_linters = {
        \   'javascript': ['prettier', 'eslint'],
        \   'proto': ['prototool-lint'],
        \}
        nnoremap <silent> <leader>af :ALEFix<cr>
        nmap <silent> <C-k> <Plug>(ale_previous_wrap)
        nmap <silent> <C-j> <Plug>(ale_next_wrap)


Plug 'sbdchd/neoformat'

" For pasting with indentation
" TODO: I think this plugin breaks certain pasting - investigate!
" Seems like it will force certain text to all paste on one line
" Plug 'sickill/vim-pasta'

" For Java formatting
" TODO: I suspect this is already covered in ALE
" Plug 'rhysd/vim-clang-format'

" Plug 'google/vim-maktaba'
" Plug 'google/vim-codefmt'
" autocmd FileType java AutoFormatBuffer google-java-format

" linting / make
" Honestly, this just doesn't seem better than ale for my uses
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

" replaces incsearch.vim
Plug 'haya14busa/is.vim'

" Plug 'qxxxb/vim-searchhi'
"         nmap / <Plug>(searchhi-/)
"         nmap ? <Plug>(searchhi-?)
"         nmap n <Plug>(searchhi-n)
"         nmap N <Plug>(searchhi-N)
"         nmap * <Plug>(searchhi-*)
"         nmap # <Plug>(searchhi-#)
"         nmap g* <Plug>(searchhi-g*)
"         nmap g# <Plug>(searchhi-g#)
"         nmap <silent> <C-L> <Plug>(searchhi-off-all)
"         vmap / <Plug>(searchhi-v-/)
"         vmap ? <Plug>(searchhi-v-?)
"         vmap n <Plug>(searchhi-v-n)
"         vmap N <Plug>(searchhi-v-N)
"         vmap * <Plug>(searchhi-v-*)
"         vmap # <Plug>(searchhi-v-#)
"         vmap g* <Plug>(searchhi-v-g*)
"         vmap g# <Plug>(searchhi-v-g#)
"         " integration with vim-asterisk
"         vmap <silent> <C-L> <Plug>(searchhi-v-off-all)
"         nmap * <Plug>(asterisk-*)<Plug>(searchhi-update)
"         nmap # <Plug>(asterisk-#)<Plug>(searchhi-update)
"         nmap g* <Plug>(asterisk-g*)<Plug>(searchhi-update)
"         nmap g# <Plug>(asterisk-g#)<Plug>(searchhi-update)

Plug 'haya14busa/vim-asterisk'
        " keeps position across matches
        let g:asterisk#keeppos = 1
        " these mappings stay at the current match until another motion
        map * <Plug>(asterisk-z*)
        map # <Plug>(asterisk-z#)
        map g* <Plug>(asterisk-gz*)
        map g# <Plug>(asterisk-gz#)

" Using these keymaps for ale instead
" Plug 'haya14busa/vim-edgemotion'
" map <C-j> <Plug>(edgemotion-j)
" map <C-k> <Plug>(edgemotion-k)

Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
        nmap ga <plug>(EasyAlign)
        xmap ga <plug>(EasyAlign)

" TODO: re-enable this when I actually use it
" Plug 'terryma/vim-expand-region'
" vmap <C-v> <plug>(expand_region_shrink)
" vmap v <plug>(expand_region_expand)

" Allows for move lines up and down
" Defaults: <A-k> and <A-j> to move visual selection
Plug 'matze/vim-move'

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
nnoremap <leader>rg :Grepper -tool rg<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
command! Todo Grepper -tool ag -query '(TODO|FIX|FIXME|XXX|NOTE|HACK|OPTIMIZE):'

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
Plug 'rizzatti/dash.vim', { 'on': 'Dash' }
nnoremap <leader>D :Dash<cr>
nnoremap <leader>d :Dash<cr>

" }}}

" {{{ Other

" Adds unix shell commands
Plug 'tpope/vim-eunuch'

" tmux / vim navigation
" I've disabled this because it tends to interfere with the way I use a lot of
" terminal things.
" Plug 'christoomey/vim-tmux-navigator'

" Tmux basics
Plug 'tpope/vim-tbone'

" Modern database interface for vim
" Note that this doesn't work for neovim
Plug 'tpope/vim-dadbod', { 'on': 'DB' }

Plug 'editorconfig/editorconfig-vim'
" for integration with vim-fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" match matching matches
Plug 'andymass/vim-matchup'
" improve cursor performance by delaying match
let g:matchup_matchparen_deferred = 1
" don't replace statusline with offscreen match
let g:matchup_matchparen_status_offscreen = 0

" Basic support for .env and Procfile
" TODO: I don't really use .env or Procfiles, turning off for now
" Plug 'tpope/vim-dotenv'

" Adds end, fi, esac, etc in languages where they are needed
" TODO: either do this per filetype, or not at all
" Plug 'tpope/vim-endwise'

" Set the 'path' option for miscellaneous file types
" TODO: This adds about 0.5 seconds to startup time
" Plug 'tpope/vim-apathy'

" Heuristically set buffer options
" Plug 'tpope/vim-sleuth'

" Pong-like game
Plug 'johngrib/vim-game-code-break', { 'on': 'VimGameCodeBreak' }

Plug 'RRethy/vim-illuminate'

" For editing prose
" TODO: figure out how to turn this on for a few filetypes
" Plug 'reedes/vim-pencil'

" Handles buffer deletion intelligently
" This hangs on git merges :(
" Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
" nmap <leader>q :Sayonara<cr>
" nmap <leader>Q :Sayonara!<cr>

" Automatic :set paste
Plug 'ConradIrwin/vim-bracketed-paste'

" Deal with parentheses, quotes, etc.
Plug 'tpope/vim-surround'
" Plug 'machakann/vim-sandwich' "could be looked into as an alternative!

" Disables arrow keys, hljk, page-up / page-down to force using more specific
" motions
" Deprecated
" Plug 'wikitopian/hardmode'

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
" This seems to be having all sorts of issues recently
" Plug 'ludovicchabant/vim-gutentags'

" Easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

" 🎄
Plug 'rhysd/vim-syntax-christmas-tree'

" }}}

call plug#end()
filetype plugin indent on

" }}}

" {{{ Settings

" this is ignored in neovim, but should be set before colorscheme
set t_Co=256

colorscheme solarized

set autoindent                     " Automatically indent based on previous line.
set expandtab                      " Convert tabs into spaces.

" Setting these language by language
" set shiftwidth=4                   " >> and << indent by 4 spaces.
" set shiftround                     " >> and << indent to next multiple of 'shiftwidth'.
" set softtabstop=4                  " Tab key indents by 4 spaces.

" For solarized8
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" let &t_SI = "\<Esc>[6 q"
" let &t_SR = "\<Esc>[4 q"
" let &t_EI = "\<Esc>[2 q"
" set termguicolors

set wrapscan                       " Wrap around the end of the buffer when searching.

set autoread                       " Read changes in files during editing.
set autowriteall                   " Write the file on a lot of different commands.

set background=light                " light background.

set backspace=eol,indent,start     " Make backspacing work regularly.

if !has('nvim')
        set balloonevalterm
        set balloondelay=250
        set ttymouse=sgr
endif

set cinoptions=N-s                 " For C program indentation.

set cursorline                     " Highlight the line where the cursor is

set foldenable                     " Enable folds.
set foldmethod=marker              " Use markers for folds ({{{ and }}}).
set foldlevelstart=99              " start off not folded

" c: Auto-wrap comments using textwidth, inserting the current comment leader automatically.
" q: Allow formatting of comments with "gq".
" r: Automatically insert the current comment leader after hitting <Enter> in Insert mode.
" j: Where it makes sense, remove a comment leader when joining lines
" o: Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set formatoptions=c,q,r,j,o

set gdefault                       " Global substitutions by default.

set hidden                         " Don't get rid of hidden buffers.

set history=10000                  " Save 10000 lines of command history.

set incsearch                      " Incremental search

if has('nvim')
    set inccommand=nosplit
endif

set infercase                      " For completion

set ignorecase                     " Ignore case while searching
set smartcase                      " ... except when capitals are used
set hlsearch

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

set noshowmode
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

set shell=/bin/bash

set showcmd                        " Show the command as it's being typed
set showmatch                      " Show matching brackets briefly.
set showmode                       " Show the mode you're in on the last line. (Somewhat redundant with airline).
set showtabline=2                  " Always show tabline.

set smartindent

set splitbelow                     " On horizontal split, open the split below.
set splitright                     " On veritcal split, open the split to the right.

set synmaxcol=400                  " Don't syntax highlight after 400 columns (for larger files).

set title                          " Set the title of the window.

set ttimeout
set ttimeoutlen=50

set textwidth=0

" This is ignored in neovim
set ttyfast

set updatetime=100                 " Time to write swap file to disk in milliseconds, and CursorHold autocommand

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
" highlight ColorColumn ctermbg=4 ctermfg=1

" }}}

" {{{ Mappings

nmap ; :

nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap j gj
vnoremap k gk
" Lol
" nnoremap h <nop>
" nnoremap l <nop>
" nnoremap j <nop>
" nnoremap k <nop>

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
nmap <leader>sw :StripWhitespace<cr>

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

nnoremap <leader>cl :close<cr>
nnoremap <leader>ss :split<cr>
nnoremap <leader>vs :vsplit<cr>

nnoremap <silent> ]r :tabn<cr>
nnoremap <silent> [r :tabp<cr>

nnoremap <silent> <leader>tn :tabnew<cr>

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

" https://castel.dev/post/lecture-notes-1/
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" https://til.hashrocket.com/posts/ba2afeb453-breezy-copy-to-system-clipboard-in-vim
" copy to system clipboard
map gy "*y
" copy whole file to system clipboard
nmap gY gg"*yG

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap <leader>V V`]
nnoremap <leader>cc :set cc=100<cr>
nnoremap <leader>co :set cc=""<cr>
" This is now used for opening Dash
" nnoremap <leader>d :bd<cr>
" This is now used for :Files
" nnoremap <leader>f <C-w>w
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

" These don't make much sense
" cnoremap jk <C-c>
" cnoremap kj <C-c>

" Bash-like keybindings
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

inoremap <silent> jk <esc>
inoremap <silent> kj <esc>

vmap <leader>s :s/
vmap <tab> %
vmap s :!sort<cr>
vmap u :!sort -u<cr>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

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
" highlight MatchParen  ctermbg=1 ctermfg=4
highlight VertSplit   ctermbg=1
highlight Visual      ctermbg=1 ctermfg=4

" }}}

" {{{ Autocommands

augroup FT
    autocmd FileType go   setlocal noexpandtab tabstop=4 shiftwidth=4
    autocmd FileType java setlocal expandtab tabstop=2 shiftwidth=2
    autocmd FileType sh   setlocal shiftwidth=4
    autocmd FileType c    setlocal cindent
    autocmd FileType html setlocal expandtab tabstop=2 shiftwidth=2
    autocmd FileType help wincmd L
    autocmd FileType asciidoc setlocal wrap
    autocmd Filetype crontab setlocal nobackup nowritebackup
    autocmd Filetype json setlocal expandtab tabstop=2 shiftwidth=2
    " Turn off folding for diffs
    autocmd Filetype diff setlocal nofoldenable
    autocmd Filetype graphql setlocal shiftwidth=2
augroup end

augroup filetypedetect
    autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
    autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
    " Admittedly Pipfile.lock looks to be a subset of JSON but this is a start
    autocmd BufNewFile,BufRead Pipfile.lock setf json
augroup END

augroup python
        autocmd Filetype python nmap <leader>ptc :Pytest class<cr>
        autocmd Filetype python nmap <leader>ptfi :Pytest file<cr>
        autocmd Filetype python nmap <leader>ptfn :Pytest function<cr>
        autocmd Filetype python nmap <leader>ptm :Pytest method<cr>
        autocmd Filetype python nmap <leader>ptp :Pytest project<cr>
        autocmd Filetype python nmap <leader>pts :Pytest session<cr>
        autocmd Filetype python setlocal tw=88
        " autocmd Filetype python setlocal formatprg=black\ -q\ -
        " autocmd Filetype python nnoremap <C-]> :ALEGoToDefinition<cr>
augroup END

augroup task
    autocmd BufRead,BufNewFile {pending,completed,undo}.data setlocal filetype=taskdata
    autocmd BufRead,BufNewFile .taskrc                       setlocal filetype=taskrc
    autocmd BufRead,BufNewFile *.task                        setlocal filetype=taskedit
augroup END

" Resize splits when window is resized
augroup window
    autocmd VimResized * :wincmd =
augroup END

" Go related mappings
" All are prefixed with 'o', because 'g' is for git
augroup go
    " FIXME - these don't seem to work
    autocmd Filetype go command! -bang Alternate call go#alternate#Switch(<bang>0, 'edit')
    autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    autocmd FileType go nmap <leader>oa :AV<cr>
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
