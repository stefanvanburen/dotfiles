# https://just.systems

set default-list

# Set up a new machine (or check an existing one for drift). Safe to re-run.
[macos]
bootstrap: brew-bundle default-shell macos-defaults macos-default-apps

# Install the base dependencies from ~/.Brewfile.
brew-bundle:
    brew bundle check --global >/dev/null 2>&1 || brew bundle install --global

# Set fish as the login shell, registering it in /etc/shells first if needed.
[macos]
default-shell:
    #!/usr/bin/env bash
    set -euo pipefail
    fish="$(command -v fish)"
    # chsh refuses a shell that isn't listed in /etc/shells.
    # https://github.com/fish-shell/fish-shell/issues/989
    if ! grep -qxF "$fish" /etc/shells; then
        echo "$fish" | sudo tee -a /etc/shells >/dev/null
    fi
    if [ "$(dscl . -read "$HOME" UserShell | awk '{print $2}')" != "$fish" ]; then
        chsh -s "$fish"
    fi

# Apply macOS system preferences (run once per new machine).
[macos]
macos-defaults: macos-defaults-dictionary macos-defaults-zoom-peek macos-defaults-key-repeat

# Disable the Cmd+Ctrl+D dictionary shortcut so Dash.app can use it.
[macos]
macos-defaults-dictionary:
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'

# https://daringfireball.net/linked/2026/04/13/macos-zoom-gesture
# Requires Full Disk Access for the invoking terminal:
#   System Settings -> Privacy & Security -> Full Disk Access -> add Ghostty (or whatever).
# Enable the Zoom "Peek" gesture (Ctrl+scroll to zoom, unsmoothed for pixel clarity).
[macos]
macos-defaults-zoom-peek:
    defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
    defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
    defaults write com.apple.universalaccess closeViewSmoothImages -bool false

# https://unsung.aresluna.org/testing-tip-make-your-keyboard-fast/
# Repeat rates are in 1/60s ticks, and these go below what the Settings slider
# allows (its floor is KeyRepeat 2 / InitialKeyRepeat 15). Takes effect at the
# next login; apps read it once at launch.
# Make the keyboard repeat as fast as macOS will go.
[macos]
macos-defaults-key-repeat:
    defaults write -g KeyRepeat -int 1
    defaults write -g InitialKeyRepeat -int 10
    # Otherwise holding a key opens the accent picker instead of repeating.
    defaults write -g ApplePressAndHoldEnabled -bool false

# Set default apps for file types and URL schemes with duti.
[macos]
macos-default-apps:
    duti -s com.ranchero.NetNewsWire-Evergreen feed
    duti -s com.ranchero.NetNewsWire-Evergreen feeds
    # `.opml` resolves to public.opml here, but Bike only declares org.opml.opml,
    # so bind both or double-clicking still lands in TextEdit.
    duti -s com.hogbaysoftware.Bike public.opml all
    duti -s com.hogbaysoftware.Bike org.opml.opml all
    # Cog claims `fish` as a tracker-module extension and outranks every editor.
    duti -s com.barebones.bbedit com.fishshell.script all
    duti -s com.barebones.bbedit public.xml all
    duti -s com.barebones.bbedit com.apple.property-list all
    duti -s com.barebones.bbedit public.toml all
    duti -s com.barebones.bbedit org.lua all

# https://dev.fennel-lang.org/wiki/LanguageServer
# https://git.sr.ht/~micampe/fennel-ls-nvim-docs
# Install the nvim Lua API docset for fennel-ls.
fennel-ls-nvim-docs:
    curl --create-dirs -o $XDG_DATA_HOME/fennel-ls/docsets/nvim.lua https://git.sr.ht/~micampe/fennel-ls-nvim-docs/blob/main/nvim.lua

# Run the lightweight nvim treesitter injections smoke test (used by prek).
test-injections:
    nvim --headless --noplugin -u NONE -c "packadd nvim-treesitter" -l .config/nvim/test/injections_spec.lua

# Print `files` if given, else all git-tracked files matching `pattern`.
[private]
_default-files files pattern:
    #!/usr/bin/env bash
    set -eu
    if [ -z "{{ files }}" ]; then
        git ls-files "{{ pattern }}"
    else
        printf '%s\n' {{ files }}
    fi

# Check the given files' (default: all tracked) .fnl formatting (used by prek).
fnlfmt-check *files:
    #!/usr/bin/env bash
    set -eu
    fnlfmt --check $(just _default-files "{{ files }}" '*.fnl')

# Check the given (default: all tracked) fish scripts are fish_indent-formatted (used by prek).
fish-format-check *files:
    #!/usr/bin/env bash
    set -eu
    fish_indent --check $(just _default-files "{{ files }}" '*.fish')

# Run all git hooks against every file.
lint:
    prek run --all-files
