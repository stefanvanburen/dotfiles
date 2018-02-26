# Dotfiles!

zsh, vim, tmux, git

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
