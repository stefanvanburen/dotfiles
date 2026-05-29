# https://just.systems

[private]
@default:
    just --list

# Apply macOS system preferences (run once per new machine).
[macos]
macos-defaults: macos-defaults-dictionary macos-defaults-zoom-peek

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

# https://dev.fennel-lang.org/wiki/LanguageServer
# https://git.sr.ht/~micampe/fennel-ls-nvim-docs
# Install the nvim Lua API docset for fennel-ls.
fennel-ls-nvim-docs:
    curl --create-dirs -o $XDG_DATA_HOME/fennel-ls/docsets/nvim.lua https://git.sr.ht/~micampe/fennel-ls-nvim-docs/blob/main/nvim.lua
