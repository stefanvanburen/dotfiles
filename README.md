# dotfiles

fish, neovim, tmux, git

I use [dotbot](https://github.com/anishathalye/dotbot) for managing my dotfiles.
Run `./install` from this directory to install the symlinks it sets up.

## Manual Steps

Set the shell for the user to `fish`:

```commandline
chsh -s $(which fish)
```

### For macOS

Install [homebrew](https://docs.brew.sh/Installation):

```commandline
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install [`brew bundle`](https://github.com/Homebrew/homebrew-bundle):

```commandline
brew tap homebrew/bundle
```

Install the base dependencies in the [Brewfile](./Brewfile):

```commandline
brew bundle install
```
