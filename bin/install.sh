#!/bin/bash

#
# const
#
REPOSITORY="https://github.com/shuuuuun/dotfiles.git"
DOTFILES=(.bash_profile .bashrc .gitignore_global .vimrc .zprofile .zshrc .zsh)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE:-$0}")"; pwd)"
DOTFILES_ROOT="$(cd "$SCRIPT_DIR/../"; pwd)"


#
# download
#
echo "downloading dotfiles from $REPOSITORY..."
cd $HOME
git clone $REPOSITORY
echo "download end."


#
# backup
#
echo "doing backup dotfiles..."
now=$(date "+%Y%m%d%H%M%S")
for file in ${DOTFILES[@]}; do
  if [ -e "$HOME/$file" ]; then
    mv "$HOME/$file" "$HOME/$file.$now.bak"
    echo "  backup: $HOME/$file -> $HOME/$file.$now.bak"
  fi
done
echo "backup end."


#
# deploy
#
echo "deploying dotfiles to $HOME..."
for file in ${DOTFILES[@]}; do
  ln -s "$DOTFILES_ROOT/$file" "$HOME/$file" && \
    echo "  symbolic_link: $DOTFILES_ROOT/$file -> $HOME/$file"
done
echo "deploy end."


#
# init
#
echo "initializing dotfiles..."
echo "initialize end."
