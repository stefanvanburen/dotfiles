# dotfiles

[fish](https://fishshell.com), [neovim](https://neovim.io), [ghostty](https://ghostty.org/), [macOS](https://www.apple.com/macos/)

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

* Install [`just`](https://just.systems), which drives the rest of the setup
  (`just bootstrap` installs it from the [Brewfile](/.Brewfile) too, but it has
  to exist before it can run):

  ```console
  $ brew install just
  ```

* Run the bootstrap — installs the [Brewfile](/.Brewfile) dependencies, sets
  `fish` as the login shell (registering it in `/etc/shells` first), and applies
  macOS system preferences. Safe to re-run on an existing machine to check for
  drift:

  ```console
  $ just bootstrap
  ```

  The macOS preferences it applies (see the [`justfile`](/justfile)) disable the
  <kbd>Cmd</kbd>+<kbd>Ctrl</kbd>+<kbd>D</kbd> dictionary shortcut so
  [Dash.app](https://kapeli.com/dash) can use it, and enable the
  [Zoom "Peek" gesture](https://daringfireball.net/linked/2026/04/13/macos-zoom-gesture).
  The latter needs Full Disk Access for the invoking terminal: System Settings
  -> Privacy & Security -> Full Disk Access.

* Create an ssh key (follow the instructions in [ssh-config](../.ssh/config)),
  and add it to [GitHub](https://github.com/settings/keys)
  and [sourcehut](https://meta.sr.ht/keys).
