# Fetches lyrics with beets, skipping tracks already known to be instrumental.
#
# beets 2.13 migrated instrumental tracks away from storing the literal text
# "[Instrumental]" in the `lyrics` field, setting `lyrics = ''` and a
# `lyrics_instrumental` flex attribute instead. The lyrics plugin only skips a
# track when `item.lyrics` is truthy, so post-migration those tracks look
# unfetched and get re-queried against LRClib on every single run.
#
# The `lyrics.auto_ignore` config option would cover this, but it is consulted
# only by the plugin's import hook, not by the `beet lyrics` command. So the
# exclusion has to be passed as a query, which is what this does.
#
# `instrumental` is the hand-maintained field; `lyrics_instrumental` is the one
# beets sets on its own. Excluding both is `^a ^b` rather than a negated OR.
#
# Subcommand flags pass through, but beets' global ones don't: `-v` has to come
# before the subcommand, so reach for `beet -v lyrics` directly when debugging.
function beet_lyrics --description 'Fetches lyrics, skipping known instrumentals.'
    # --ignore-unknown so beets' own flags (-f, -p, -l, ...) pass straight through.
    argparse --ignore-unknown h/help a/all -- $argv
    or return 1

    if set --query _flag_help
        echo "Usage: beet_lyrics [--all] [<query>...]"
        echo
        echo "Runs `beet lyrics`, excluding tracks flagged instrumental via either"
        echo "the `instrumental` or `lyrics_instrumental` field. Extra arguments are"
        echo "passed through, so flags like -f/--force still work."
        echo
        echo "  -a, --all   Don't exclude instrumentals (plain `beet lyrics`)"
        return 0
    end

    if set --query _flag_all
        beet lyrics $argv
    else
        beet lyrics '^instrumental:true' '^lyrics_instrumental:true' $argv
    end
end

complete -c beet_lyrics -s a -l all -d "Don't exclude known instrumentals"
complete -c beet_lyrics -s h -l help -d 'Show usage'
