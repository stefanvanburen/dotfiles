# dotfiles

fish, neovim, tmux, git

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

Install [`brew bundle`](https://github.com/Homebrew/homebrew-bundle):

```sh
brew tap homebrew/bundle
```

Install the base dependencies in the [Brewfile](./local/share/Brewfile):

```sh
brew bundle install --file=~/.Brewfile
```

Set the shell for the user to `fish`:

```sh
# NOTE: Should ensure that "$(which fish)" is in /etc/shells
# See: https://github.com/fish-shell/fish-shell/issues/989
chsh -s $(which fish)
```

Install `fzf` key bindings and fuzzy completion:

```sh
/opt/homebrew/opt/fzf/install # then, follow the prompts
```

Set up fonts in Alacritty (see [alacritty.yml](./config/alacritty/alacritty.yml) for details)

Disable the annoying <kbd>Cmd</kbd>+<kbd>Ctrl</kbd>+<kbd>D</kbd> shortcut to bring up the dictionary on macOS, so that [Dash.app](https://kapeli.com/dash) can use it:

```sh
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'
```
