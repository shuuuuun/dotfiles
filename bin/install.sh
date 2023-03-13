#!/bin/bash

set -e

#
# const
#
REPOSITORY="https://github.com/shuuuuun/dotfiles.git"
DOTFILES=(.bash_profile .bashrc .gitignore_global .gitconfig.local .gitconfig .vimrc .sh .zprofile .zshrc .tigrc .ripgreprc .tmux.conf .config/peco/config.json .config/lf/lfrc .config/direnv/direnvrc .rubocop.yml .lima/docker/lima.yaml)
DOTFILES_ROOT="$HOME/dotfiles"

cd "$HOME"
echo "dotfiles root path: $DOTFILES_ROOT"
echo "dotfiles: ${DOTFILES[@]}"


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
  dir=$(dirname "$file")
  mkdir -p "$HOME/$dir"
  if [ -f "$DOTFILES_ROOT/$file" -o -d "$DOTFILES_ROOT/$file" ]; then
    # TODO: ディレクトリがすでに存在する場合もsymlink作ってしまう
    ln -s "$DOTFILES_ROOT/$file" "$HOME/$file" && \
      echo "  symbolic_link: $DOTFILES_ROOT/$file -> $HOME/$file"
  else
    echo "$DOTFILES_ROOT/$file: No such file or directory."
  fi
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

# mitamae
cd "$DOTFILES_ROOT/mitamae"
make setup
make run

echo "initialize end."
