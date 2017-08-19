#!/bin/bash

#
# const
#
REPOSITORY="https://github.com/shuuuuun/dotfiles.git"
DOTFILES=(.bash_profile .bashrc .gitignore_global .vimrc .zprofile .zshrc .sh)
DOTFILES_ROOT="$HOME/dotfiles"

cd "$HOME"
echo "dotfiles root path: $DOTFILES_ROOT"


#
# download
#
if [ -e "$DOTFILES_ROOT" ]; then
  echo "'$DOTFILES_ROOT' already exists."
  cd "$DOTFILES_ROOT"
  echo "updating dotfiles repository..."
  git pull
  echo "update end."
  cd "$HOME"
else
  echo "downloading dotfiles from $REPOSITORY..."
  git clone $REPOSITORY $DOTFILES_ROOT
  echo "download end."
fi


#
# backup
#
echo "doing backup dotfiles..."
now=$(date "+%Y%m%d%H%M%S")
for file in ${DOTFILES[@]}; do
  if [ -f "$HOME/$file" -a ! -L  "$HOME/$file" ]; then # fileが存在しかつシンボリックリンクでない
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
# export DOTFILES_ROOT=$DOTFILES_ROOT
# TODO: init script
# .zsh/lib/以下をignoreする？
# dir="$DOTFILES_ROOT/.zsh/lib/seebi/dircolors-solarized"
# mkdir -p $dir
# cd $dir
# curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-universal -O
# TODO: vim neobundle install
# https://github.com/Shougo/neobundle.vim
# curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
# TODO: zplug install if zsh
# https://github.com/zplug/zplug
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
echo "initialize end."


#
# note
#
# change login shell
# chsh -s /bin/zsh
# installation
# curl https://raw.githubusercontent.com/shuuuuun/dotfiles/master/bin/install.sh | bash
