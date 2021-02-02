let b:ale_linters = ['gopls', 'staticcheck']
let b:ale_fixers = ['goimports']

" This has to be set so the entire package is linted (otherwise, staticcheck
" won't grab identifiers declared in other files).
let b:ale_go_staticcheck_lint_package = 1

set noexpandtab
set tabstop=4
set shiftwidth=4

nmap <buffer> <localleader>dc <Plug>(go-decls)
nmap <buffer> <localleader>dd <Plug>(go-decls-dir)
nmap <buffer> <localleader>ru <Plug>(go-run)
nmap <buffer> <localleader>re <Plug>(go-rename)
nmap <buffer> <localleader>tn <Plug>(go-test-func)
nmap <buffer> <localleader>tf <Plug>(go-test)
nmap <buffer> <localleader>ae <Plug>(go-alternate-edit)
nmap <buffer> <localleader>if <Plug>(go-iferr)
