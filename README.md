# Dotfiles!

fish, vim, tmux, git

I use [dotbot](https://github.com/anishathalye/dotbot) for managing my
dotfiles. Run `./install.sh` from this directory to install the symlinks it
sets up.

## Post-Installation

### Install vim and vim-plug
* vim:

```console
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

* neovim:

```console
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Install `tpm`

```console
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```


## Useful links

* [Dotfiles on GitHub](https://dotfiles.github.io/)
