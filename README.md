# dotfiles

fish, neovim, tmux, git

I use [dotbot](https://github.com/anishathalye/dotbot) for managing my dotfiles.
Run `./install` from this directory to install the symlinks it sets up.

## Manual Steps (for MacOS)

Install [homebrew](https://docs.brew.sh/Installation):

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install [`brew bundle`](https://github.com/Homebrew/homebrew-bundle):

```sh
brew tap homebrew/bundle
```

Install the base dependencies in the [Brewfile](./Brewfile):

```sh
brew bundle install
```

Create an ssh key (follow the instructions in [ssh-config](./ssh-config)), and add it to [GitHub](https://github.com/settings/keys) and [sourcehut](https://meta.sr.ht/keys).

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

Set up fonts in Alacritty (see [alacritty.yml](./alacritty.yml) for details)
