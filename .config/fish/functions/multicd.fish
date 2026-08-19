# Expands the `dotdot` abbreviation in ../config.fish: turns a run of dots into
# the equivalent `cd ../../…`, one level per dot past the first.
# https://fishshell.com/docs/current/interactive.html#abbreviations
function multicd --description 'Expands .. runs into a cd command'
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
