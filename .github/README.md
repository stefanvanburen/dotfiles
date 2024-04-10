# dotfiles

[fish](https://fishshell.com), [neovim](https://neovim.io), [kitty](https://sw.kovidgoyal.net/kitty/), [macOS](https://www.apple.com/macos/)

## Setup

```console
$ cd ~
$ git init
$ git remote add origin https://github.com/stefanvanburen/dotfiles
$ git fetch
$ git checkout -f main
$ git config status.showUntrackedFiles no
```

## Manual Steps (for MacOS)

[Install Homebrew](https://docs.brew.sh/Installation):

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install the base dependencies in the [Brewfile](/.Brewfile):

```sh
brew bundle install --global
```

[Set the default shell for the user to `fish`](https://fishshell.com/docs/current/index.html#default-shell):

```sh
# NOTE: Should ensure that "$(command -v fish)" is in /etc/shells
# See: https://github.com/fish-shell/fish-shell/issues/989
chsh -s $(command -v fish)
```

Set up fonts in Kitty (see [kitty.conf](/.config/kitty/kitty.conf) for details)

Disable the annoying <kbd>Cmd</kbd>+<kbd>Ctrl</kbd>+<kbd>D</kbd> shortcut to bring up the dictionary on macOS, so that [Dash.app](https://kapeli.com/dash) can use it:

```sh
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'
```
