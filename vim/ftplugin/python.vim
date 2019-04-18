" Check Python files with flake8, mypy, pyls
" pydocstyle is a bit too annoying
" pylama detects too much
let b:ale_linters = ['flake8', 'mypy', 'pyls', 'bandit']
" Fix Python files with isort, black
let b:ale_fixers = ['isort', 'black']
