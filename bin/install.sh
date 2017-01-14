#!/bin/bash

#
# const
#
REPOSITORY="https://github.com/shuuuuun/dotfiles.git"
DOTFILES=(.bash_profile .bashrc .gitconfig .gitignore_global .vimrc .zprofile .zshrc)


#
# download
#
echo "downloading dotfiles from $REPOSITORY..."
cd $HOME
git clone $REPOSITORY
echo "download end."


#
# deploy
#
echo "deploying dotfiles to $HOME..."
for file in $DOTFILES; do
  ln -s "$HOME/dotfiles/$file" "$HOME/$file"
  echo "  symbolic_link: ~/dotfiles/$file -> ~/$file"
done
echo "deploy end."


#
# init
#
echo "initializing dotfiles..."
echo "initialize end."
