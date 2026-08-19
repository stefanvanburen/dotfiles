# Suggests a Homebrew formula when a command isn't found. `brew which-formula`
# resolves the executable against Homebrew's index rather than guessing that the
# command and the formula share a name -- `rg` comes back as ripgrep, `gsed` as
# gnu-sed -- and a genuine typo matches nothing, so no suggestion is printed.
#
# fish's own message goes out first, so the ~0.2s lookup never delays it, and it
# is only paid on a command that was going to fail anyway. The index can name
# more than one formula: `fd` matches both fd and fdclone.
function fish_command_not_found --description 'Suggest a Homebrew formula for an unknown command'
    __fish_default_command_not_found_handler $argv

    command -q brew
    or return

    set --local formulae (brew which-formula $argv[1] 2>/dev/null)
    if set --query formulae[1]
        printf "Install it with: brew install %s\n" (string join " or " $formulae) >&2
    end
end
