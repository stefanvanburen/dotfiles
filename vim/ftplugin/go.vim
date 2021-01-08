let b:ale_linters = ['gopls', 'staticcheck']
let b:ale_fixers = ['goimports']

" This has to be set so the entire package is linted (otherwise, staticcheck
" won't grab identifiers declared in other files).
let b:ale_go_staticcheck_lint_package = 1

set noexpandtab
set tabstop=4
set shiftwidth=4
