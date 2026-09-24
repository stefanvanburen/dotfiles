# https://just.systems

set default-list

# Set up a new machine (or check an existing one for drift). Safe to re-run.
[macos]
bootstrap: brew-bundle default-shell macos-defaults macos-default-apps go-tools

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

# https://macos-defaults.com is the reference for the keys below.
# Apply macOS system preferences (run once per new machine).
[macos]
macos-defaults: macos-defaults-dictionary macos-defaults-zoom-peek macos-defaults-key-repeat macos-defaults-finder macos-defaults-dock macos-defaults-typing macos-defaults-pointer macos-defaults-menu-bar macos-defaults-dialogs macos-defaults-safari

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

# Show every file, in list view, and open new windows at $HOME rather than Recents.
[macos]
macos-defaults-finder:
    defaults write com.apple.finder AppleShowAllFiles -bool true
    defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
    defaults write com.apple.finder NewWindowTarget -string PfHm
    defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"
    # Mounted volumes on the Desktop; internal disks and servers are off by default.
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRecentTags -bool false
    # Cmd-F searches the folder you're in, not every volume on the machine.
    defaults write com.apple.finder FXDefaultSearchScope -string SCcf
    # Extensions are always visible here, so renaming one isn't an accident.
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    defaults write -g AppleShowAllExtensions -bool true
    killall Finder

# Small Dock on the right edge, out of the way, with no Recents section.
[macos]
macos-defaults-dock:
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock orientation -string right
    defaults write com.apple.dock tilesize -int 64
    defaults write com.apple.dock show-recents -bool false
    # With autohide on, the default 0.5s reveal delay is the whole cost of it.
    defaults write com.apple.dock autohide-delay -float 0
    # Keep Spaces in the order they were created, not most-recently-used.
    defaults write com.apple.dock mru-spaces -bool false
    killall Dock

# Smart quotes, en dashes, and the double-space period all corrupt code and
# commit messages.
# Stop macOS rewriting what gets typed.
[macos]
macos-defaults-typing:
    defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
    defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
    defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
    # Don't restore an app's windows when it's relaunched.
    defaults write -g NSQuitAlwaysKeepsWindows -bool false

# Pointer tracking, and Force Touch off (it fires on ordinary firm clicks).
[macos]
macos-defaults-pointer:
    defaults write -g com.apple.mouse.scaling -float 1
    defaults write -g com.apple.trackpad.scaling -float 3
    defaults write -g com.apple.trackpad.forceClick -bool false

# Seconds in the menu bar clock, no date (the date is a click away in Calendar).
[macos]
macos-defaults-menu-bar:
    defaults write com.apple.menuextra.clock ShowSeconds -bool true
    defaults write com.apple.menuextra.clock ShowDate -int 2
    # The clock lives in ControlCenter now, not SystemUIServer.
    killall ControlCenter

# Tab reaches every control in a dialog, not just text fields and lists.
# Make dialogs fully keyboard-navigable.
[macos]
macos-defaults-dialogs:
    defaults write -g AppleKeyboardUIMode -int 3

# Safari is sandboxed, so this needs the same Full Disk Access as the Zoom
# recipe above, and Safari must be closed when it runs.
# Show the whole URL in Safari's address bar, not just the domain.
[macos]
macos-defaults-safari:
    defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

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

# Install my Go tools to $GOBIN (~/.local/bin, on PATH); tracks main, so re-run to update.
go-tools:
    go install -ldflags='-s -w' go.vanburen.xyz/cells/cmd/cells@main

# https://dev.fennel-lang.org/wiki/LanguageServer
# https://git.sr.ht/~micampe/fennel-ls-nvim-docs
# Build and install the nvim Lua API docset for fennel-ls. Built from
# source because the prebuilt nvim.lua in the repo lags behind Neovim
# release-branch backports.
fennel-ls-nvim-docs:
    #!/usr/bin/env bash
    set -euo pipefail
    dir="$(mktemp -d)"
    trap 'rm -rf "$dir"' EXIT
    git clone --quiet --depth 1 https://git.sr.ht/~micampe/fennel-ls-nvim-docs "$dir"
    make -C "$dir" --silent install

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

# Lint the given files (default: all tracked Markdown) with rumdl (used by prek).
markdown-check *files:
    rumdl check $(just _default-files "{{ files }}" '*.md')

# Fix what `just markdown-check` flags as fixable, in place.
markdown-format *files:
    rumdl fmt $(just _default-files "{{ files }}" '*.md')

# Check the given files' (default: all tracked) .fnl formatting (used by prek).
fnlfmt-check *files:
    #!/usr/bin/env bash
    set -eu
    # `fnlfmt --check` reports unformatted files but always exits 0, so failure
    # has to be detected from its output.
    # `|| true` keeps a nonzero exit (e.g. a missing file) from aborting before
    # the message below is printed.
    output=$(fnlfmt --check $(just _default-files "{{ files }}" '*.fnl') 2>&1) || true
    if [ -n "$output" ]; then
        printf '%s\n' "$output" >&2
        exit 1
    fi

# Check the given (default: all tracked) fish scripts are fish_indent-formatted (used by prek).
fish-format-check *files:
    #!/usr/bin/env bash
    set -eu
    fish_indent --check $(just _default-files "{{ files }}" '*.fish')

# Run all git hooks against every file.
lint:
    prek run --all-files
