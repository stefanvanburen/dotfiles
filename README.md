# Dotfiles!
zsh, vim, tmux, git

## Post-Installation

* Install zsh and zplug
  * curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
* Install rust via rustup
  * curl https://sh.rustup.rs -sSf | sh
* Install vim and vim-plug
  * vim: curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  * neovim: curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
