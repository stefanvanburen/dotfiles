#!/bin/bash
cd $HOME
rm .gemrc
ln -s dotfiles/gemrc .gemrc
rm .gitconfig
ln -s dotfiles/gitconfig .gitconfig
rm .gitignore
ln -s dotfiles/gitignore .gitignore
rm .tmux.conf
ln -s dotfiles/tmux.conf .tmux.conf
rm .vim
ln -s dotfiles/vim .vim
rm .vimrc
ln -s dotfiles/vimrc .vimrc
rm .zlogin
ln -s dotfiles/zlogin .zlogin
rm .zlogout
ln -s dotfiles/zlogout .zlogout
rm .zpreztorc
ln -s dotfiles/zpreztorc .zpreztorc
rm .zprofile
ln -s dotfiles/zprofile .zprofile
rm .zshenv
ln -s dotfiles/zshenv .zshenv
rm .zshrc
ln -s dotfiles/zshrc .zshrc

# TODO
if [[ "$OSTYPE" == arch* ]]; then
  rm .wmiirc
  ln -s dotfiles/wmiirc .wmiirc
fi
