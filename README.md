# Dotfiles!

zsh, vim, tmux, git

I use [dotbot](https://github.com/anishathalye/dotbot) for managing my
dotfiles. Run `./install.sh` from this directory to install the symlinks it
sets up.

## Post-Installation

### Install zsh and zplug

```bash
brew install zsh zplug
```

### Install rust via rustup

```bash
curl https://sh.rustup.rs -sSf | sh
```

### Install vim and vim-plug
* vim:

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

* neovim:

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```


## Useful links

* [Dotfiles on GitHub](https://dotfiles.github.io/)
