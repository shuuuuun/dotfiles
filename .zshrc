#
# zplug
#
source ~/.zplug/init.zsh

# plugins
zplug "mafredri/zsh-async" # need for pure prompt
# zplug "sindresorhus/pure" # prompt
# zplug "~/personal/prompt/pure", from:local # prompt
zplug "shuuuuun/pure" # prompt
# zplug "nksoff/muslim" # prompt
# zplug "isqua/bureau" # prompt
zplug "zsh-users/zsh-syntax-highlighting", nice:10
zplug "zsh-users/zsh-completions"
# zplug "zsh-users/zsh-history-substring-search"

# install
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# load
zplug load --verbose

# if zplug check "zsh-users/zsh-history-substring-search"; then
#     bindkey '^P' history-substring-search-up
#     bindkey '^N' history-substring-search-down
# fi


#
# prompt
#
# PURE_PROMPT_SYMBOL='%*$'
PURE_PROMPT_LEFT='%*'
PURE_PROMPT_SYMBOL='$'
PURE_PROMPT_SYMBOL_COLOR='magenta'
PURE_PROMPT_SYMBOL_ERROR_COLOR='red'
PURE_DISABLE_SET_TITLE=true
PURE_PREPROMPT_DIRECTORY_COLOR='cyan'
prompt_pure_setup

# autoload -U promptinit
# promptinit
# prompt pure
# prompt muslim


#
# setopt
#
setopt transient_rprompt # RPROMPTを残さない
unsetopt correct # disable autocorrect

# history
setopt share_history
HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"       # The path to the history file.
HISTSIZE=10000                   # The maximum number of events to save in the internal history.
SAVEHIST=10000                   # The maximum number of events to save in the history file.

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.


#
# zstyle
#
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完で大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # あいまい検索 cf. ~/.oh-my-zsh/lib/completion.zsh


#
# alias
#
alias ls='ls -G' # color
alias l='ls -la'
alias ll='ls -l'
alias lla='ls -la'
alias lns='ln -s'
alias ls1='ls -1'
alias ls-fullpath='ls -1d $PWD/*'
alias nanow='nano -w'
alias les='less'
alias jxa='osascript -l JavaScript'
alias desktop='cd ~/Desktop'
alias cddesktop='cd ~/Desktop'
alias st='subl'
alias stc='subl .'
alias stfolder='subl .'
alias rmrf='rm -rf'
alias cprf='cp -rf'
# alias rm='echo use \`gomi\` command!!; false'
alias top-cpu='top -o cpu'
alias rsync-copy='rsync -C --filter=":- .gitignore" -av'
alias purgesudo='sudo purge'

# alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

alias emacs='emacs -nw' # for GNU emacs (GUIが起動しちゃうのでCLIにする)

alias g='git'
alias gst='git status'
alias gbr='git branch'
alias gbra='git branch -a'
alias gstash='git stash'
alias gad='git add'
alias gada='git add --all'
alias gcm='git commit'
alias gcmm='git commit -m'
alias gcmam='git commit --amend'
alias gcmmbuild='git commit -m "build"'
alias gcmmtemp='git commit -m "temp"'
alias gcmmupdate='git commit -m "update"'
alias gmg='git merge'
alias gmg-noff='git merge --no-ff'
alias gft='git fetch'
alias gpll='git pull'
alias gpsh='git push'
alias gpull='git pull'
alias gpush='git push'
alias greset='git reset'
alias grebase='git rebase'
alias gremotev='git remote -v'
alias gpull-prune='git pull --prune'
alias gpull-rebase='git pull --rebase'
alias gcomaster='git checkout master'
alias gcodevelop='git checkout develop'
alias git-root='git rev-parse --show-toplevel'

alias tg='tig'
alias tgst='tig status'
alias tigstatus='tig status'
alias tigstash='tig stash'
alias tigrep='tig grep'
alias tigmaster='tig master'
alias tigdevelop='tig develop'

alias svnupdate='svn update'
alias svnstatus='svn status'
alias svndiff='svn diff | less'
alias svnlog='svn log | less'

GITHUB_REPO_NAME_REGEX='/[https?:\/\/|git\@]github\.com[\/|:]([^\/]+)\/([^\/]+)\.git/'
# TODO: URLをechoしときたい
alias open-github='git remote -v | perl -0ne '"'"'print "https://github.com/$1/$2" if ('$GITHUB_REPO_NAME_REGEX')'"'"' | xargs -I url open url'
alias open-gh-pages='git remote -v | perl -0ne '"'"'print "https://$1.github.io/$2/" if ('$GITHUB_REPO_NAME_REGEX')'"'"' | xargs -I url open url'
alias push-gh-pages='git subtree push --prefix public/ origin gh-pages'

alias bundle-install-path-vendor-bundle='bundle install --path vendor/bundle'
alias bundle-exec='bundle exec'
alias be='bundle exec'

alias npm-shrinkwrap='npm shrinkwrap'
alias npm-install-save-dev='npm install --save-dev'
alias npm-ls-global='npm ls -g --depth=0'

# alias highlight='highlight --style=Moria'


#
# other
#

# cdしたらpwdする
# http://qiita.com/b4b4r07/items/8cf5d1c8b3fbfcf01a5d
function cd () {
    pwd && builtin cd "$@" && pwd
}

# gitのルートディレクトリにcd
function cd-git-root () {
    cd `git rev-parse --show-toplevel`
}

# ウィンドウタイトル（タブ名）を設定
function set_window_title () {
  # echo -en "\033];"$(pwd | sed "s@$HOME@~@")"\007" # current path
  # echo -en "\033];"$(pwd | sed "s@^.*\/@@")"\007" # current directory name

  # TODO: 
  # git root directory name
  git_root=`git rev-parse --show-toplevel` > /dev/null 2>&1
  if [[ $git_root == "" ]] git_root=`pwd`
  dir_name=`echo $git_root | sed "s@^.*\/@@"`
  echo $dir_name
  echo -en "\033];$dir_name\007"
}

# ディレクトリ変更時に毎回呼ばれる関数
function chpwd () {
  set_window_title
}
set_window_title


# 文字列を置換する
# ex. agreplace hoge fuga
function agreplace () {
  ag -rl $1 . | xargs perl -i -pe "s/$1/$2/g"
}

# 検索してマッチした数を出す
# ex. agcount hoge path
function agcount () {
  ag --nobreak --nofilename $1 $2 | wc -l 
}

# クリップボードにコピー
# ex. copy hoge fuga
function copy () {
    echo $@ | pbcopy
}

# mkdirしてcdする
function mkdir-cd {
  mkdir $1 && cd $1
}

# カレントディレクトリ以下の.DS_Storeを消す
function rm-ds-store {
  # targetFile="./**/.DS_Store" # なんか変数に入れるとうまくいかない
  ls -l ./**/.DS_Store
  # if [ -x /usr/local/bin/gomi ]; then
  if type gomi > /dev/null 2>&1; then
    gomi ./**/.DS_Store
  else
    rm ./**/.DS_Store
  fi
}

# Railsの超簡易Viewをつくる
function rails_genarate_view {
  # TODO: 第三引数以降をぜんぶactionとして作成
  controller="$1"
  action="$2"
  directory="app/views/$controller"
  dest="$directory/$action.html.slim"
  if [ -e "$dest" ]; then
    echo "exist $dest"
  else
    mkdir -p "$directory" \
    && echo "h1 $controller#$action" >> "$dest" \
    && echo "create $dest"
  fi
}

# 簡易ランダム文字列生成
function rand {
  arg=$1
  length=$(( arg / 2 ))
  if [[ -z "$arg" ]]; then
    length=8
  fi
  openssl rand -hex $length
}

function init-new-project {
  # TODO: configやREADMEもproject-nameに置換したい
  name=$1
  repository="git@github.com:shuuuuun/gulp-template.git"
  branch="master"
  echo "new project: $name"
  echo "based on repository: $repository"
  echo "             branch: $branch"
  mkdir "$name"
  cd "$name"
  git clone --depth 1 -b $branch $repository .
  rm -rf .git
  git init
  git add --all
  git commit -m "init"
}

function  tigdiff {
  git diff $@ | tig
}


# enhancd
# source ~/.enhancd/zsh/enhancd.mtk.zsh

# fzf
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# ranger
# function ranger() {
#     if [ -z "$RANGER_LEVEL" ]; then
#         /usr/local/bin/ranger $@
#     else
#         exit
#     fi
# }
# source ~/commands/ranger/examples/bash_automatic_cd.sh
function rgr {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
        if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
            cat "$tempfile"
        fi
    command rm -f -- "$tempfile"
}
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
        if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
            cd -- "$(cat "$tempfile")"
        fi
    command rm -f -- "$tempfile"
}
alias rgrcd="ranger-cd"

# erbをslimに変換する ディレクトリを指定して再帰的に
function erb2slim-recursive {
  # erb2slimコマンドが存在する場合のみ（ガード節にしたいけど書き方がわからん）
  if type erb2slim > /dev/null 2>&1; then
    dir="$1"
    for file in $dir/**/*.erb; do
      echo $file
      erb2slim $file ${file%erb}slim && rm $file
    done
  fi
}

# gitで差分ファイルを抽出する
# cf. http://qiita.com/kaminaly/items/28f9cb4e680deb700833
# TODO: もう少しカスタマイズしたい,prefixや出力名など
function git_diff_archive {
  local diff=""
  local h="HEAD"
  if [ $# -eq 1 ]; then
    if expr "$1" : '[0-9]*$' > /dev/null ; then
      diff="HEAD~${1} HEAD"
    else
      diff="${1} HEAD"
    fi
  elif [ $# -eq 2 ]; then
    diff="${2} ${1}"
    h=$1
  fi
  if [ "$diff" != "" ]; then
    diff="git diff --diff-filter=d --name-only ${diff}"
  fi
  git archive --format=zip --prefix=root/ $h `eval $diff` -o archive.zip
}

# 上矢印で入力中の単語にマッチした履歴を出してくれるやつがほしくてそれだけ書こうとしたけど
# ちゃんと分からないので
# とりあえずoh-my-zshのkey-bindingを読み込む
source ~/.oh-my-zsh/lib/key-bindings.zsh


#
# load local settgins
#
source ~/.zshrc_local

