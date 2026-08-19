# Expands the `!!` abbreviation in ../config.fish.
# https://fishshell.com/docs/current/cmds/abbr.html
function last_history_item --description 'Prints the most recent command'
    echo $history[1]
end
