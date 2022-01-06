function mv --wraps=mv --description 'mv with verbose and requiring confirmation for overwriting files'
    command mv -iv $argv
end
