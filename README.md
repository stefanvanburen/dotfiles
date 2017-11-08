# Dotfiles!
zsh, vim, tmux, git

## Post-Installation

### Install zsh and zplug

* linux:
```bash
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
```

* mac:
```bash
brew install zplug
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
