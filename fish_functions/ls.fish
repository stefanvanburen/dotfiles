function ls --wraps=/bin/ls --description 'Turn on color for ls'
    /bin/ls --color=auto $argv
end
