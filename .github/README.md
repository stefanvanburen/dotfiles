# dotfiles

[fish](https://fishshell.com), [neovim](https://neovim.io), [ghostty](https://ghostty.org/) (+ [kitty](https://sw.kovidgoyal.net/kitty/)!), [macOS](https://www.apple.com/macos/)

## Setup

```console
$ cd ~
$ git init
$ git remote add origin https://github.com/stefanvanburen/dotfiles
$ git fetch
$ git checkout -f main
$ git config status.showUntrackedFiles no
```

## Manual Steps

* [Install Homebrew](https://docs.brew.sh/Installation):

  ```console
  $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

* Install the base dependencies in the [Brewfile](/.Brewfile):

  ```console
  $ brew bundle install --global
  ```

* [Set the default shell for the user to `fish`](https://fishshell.com/docs/current/index.html#default-shell):

  ```console
  $ # NOTE: Should ensure that "$(command -v fish)" is in /etc/shells
  $ # See: https://github.com/fish-shell/fish-shell/issues/989
  $ chsh -s $(command -v fish)
  ```

* Apply macOS system preferences (see [`justfile`](/justfile) for what this does
  — disables the <kbd>Cmd</kbd>+<kbd>Ctrl</kbd>+<kbd>D</kbd> dictionary shortcut
  so [Dash.app](https://kapeli.com/dash) can use it, and enables the
  [Zoom "Peek" gesture](https://daringfireball.net/linked/2026/04/13/macos-zoom-gesture)):

  ```console
  $ just macos-defaults
  ```

* Create an ssh key (follow the instructions in [ssh-config](../.ssh/config)),
  and add it to [GitHub](https://github.com/settings/keys)
  and [sourcehut](https://meta.sr.ht/keys).
