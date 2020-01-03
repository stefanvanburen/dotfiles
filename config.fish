# bootstrap fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

set -gx EDITOR nvim
# https://github.com/venantius/ultra/issues/108#issuecomment-522347422
set -gx LEIN_USE_BOOTCLASSPATH no

# https://docs.python.org/3/using/cmdline.html#envvar-PYTHONDONTWRITEBYTECODE
set -gx PYTHONDONTWRITEBYTECODE 1

# https://github.com/sharkdp/bat#man
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

alias vim="$EDITOR"
abbr v vim
abbr g git

alias git="hub"

alias m="make"
alias make="mmake"

alias x="extract"

alias c="clear"

alias md="mkdir -p"
alias rd="rmdir"

alias cat="bat"

function sudo!!
    eval sudo $history[1]
end

function vimrc
    vim ~/.vimrc
end

alias ...="cd ../.."
alias ....="cd ../../.."

# for direnv
direnv hook fish | source

# for pyenv
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)

# for jump
status --is-interactive; and source (jump shell fish | psub)

# for starship prompt
# eval (starship init fish)
status --is-interactive; and source (starship init fish |psub)

# TODO: local file
set PATH $HOME/bin $HOME/.local/bin $HOME/.cargo/bin $PATH

# for iterm
source ~/.iterm2_shell_integration.(basename $SHELL)

# for asdf
# NOTE: still can't really use for python as it doesn't have great integration
# with pyenv quite yet
source /usr/local/opt/asdf/asdf.fish

# functions

function root -d "cd to the root of the git repository"
    set root (git rev-parse --show-toplevel)
    if root != ""
        cd root
    else
        echo "Not in git repository"
    end
end

function extract -d "extract files from archives"
    # largely adapted from https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/extract/extract.plugin.zsh

    # no arguments, write usage
    if test (count $argv) -eq 0
        echo "Usage: extract [-option] [file ...]\n Options:\n -r, --remove    Remove archive after unpacking." >&2
        exit 1
    end

    set remove_file 0
    if test $argv[1] = "-r"; or test $argv[1] = "--remove"
        set remove_file 1
        set --erase argv[1]
    end

    for i in $argv[1..-1]
        if test ! -f $i
            echo "extract: '$i' is not a valid file" >&2
            continue
        end

        set success 0
        # TODO: for items like `*.tar.gz`, this matches just the `*.gz`, leaving
        # us with a `*.tar` extension. This match needs to work better.
        set extension (string match -r ".*(\.[^\.]*)\$" $i)[2]
        switch $extension
            case '*.tar.gz' '*.tgz'
                tar xv; or tar zxvf "$i"
            case '*.tar.bz2' '*.tbz' '*.tbz2'
                tar xvjf "$i"
            case '*.tar.xz' '*.txz'
                tar --xz -xvf "$i"; or xzcat "$i" | tar xvf -
            case '*.tar.zma' '*.tlz'
                tar --lzma -xvf "$i"; or lzcat "$i" | tar xvf -
            case '*.tar'
                tar xvf "$i"
            case '*.gz'
                gunzip -k "$i"
            case '*.bz2'
                bunzip2 "$i"
            case '*.xz'
                unxz "$i"
            case '*.lzma'
                unlzma "$i"
            case '*.z'
                uncompress "$i"
            case '*.zip' '*.war' '*.jar' '*.sublime-package' '*.ipsw' '*.xpi' '*.apk' '*.aar' '*.whl'
                set extract_dir (string match -r "(.*)\.[^\.]*\$" $i)[2]
                unzip "$i" -d $extract_dir
            case '*.rar'
                unrar x -ad "$i"
            case '*.7z'
                7za x "$i"
            case '*'
                echo "extract: '$i' cannot be extracted" >&2
                set success 1
        end

        if test $success -eq 0; and test $remove_file -eq 1
            rm $i
        end
    end
end

# ---

# local things
if test -e "$HOME/.extra.fish";
    source ~/.extra.fish
end

set -gx VOLTA_HOME "$HOME/.volta"
test -s "$VOLTA_HOME/load.fish"; and source "$VOLTA_HOME/load.fish"

string match -r ".volta" "$PATH" > /dev/null; or set -gx PATH "$VOLTA_HOME/bin" $PATH
