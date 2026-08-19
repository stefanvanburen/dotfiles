# Decides whether a command is written to history. Fish's own rule — skip
# anything typed with a leading space — is internal and only consulted while
# this function is undefined, so defining it means restating that rule here.
#
# $argv[1] is the entire command line, leading whitespace and embedded newlines
# included. It runs before the command does, so $status is not available.
function fish_should_add_to_history --description 'Keeps secrets out of history'
    set --local cmdline $argv[1]

    # The usual "don't record this one" gesture.
    string match --quiet --regex '^\s' -- $cmdline
    and return 1

    # Takes the secret as a literal argument; see feedbin_add, feedbin_mute.
    string match --quiet --regex '(^|[;&|]\s*)security add-generic-password' -- $cmdline
    and return 1

    return 0
end
