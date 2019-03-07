" Check Python files with flake8
" TODO: should look into using a type checker (pyre or mypy)
" 'pyls' seems to sorta break things
let b:ale_linters = ['flake8']
" Fix Python files with isort
" TODO: would like to use black, but probably just for personal projects for
" the time being
let b:ale_fixers = ['isort']
" let b:ale_completion_enabled = 1
