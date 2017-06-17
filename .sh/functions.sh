#
# function
#

# cdしたらpwdする
# http://qiita.com/b4b4r07/items/8cf5d1c8b3fbfcf01a5d
function cd {
    pwd && builtin cd "$@" && pwd
}

# gitのルートディレクトリにcd
function cd-git-root {
    cd `git rev-parse --show-toplevel`
}

# ウィンドウタイトル（タブ名）を設定
function set-window-title {
  # echo -en "\033];"$(pwd | sed "s@$HOME@~@")"\007" # current path
  # echo -en "\033];"$(pwd | sed "s@^.*\/@@")"\007" # current directory name

  # TODO: 
  # git root directory name
  git_root=`git rev-parse --show-toplevel` > /dev/null 2>&1
  if [[ $git_root == "" ]]; then git_root=`pwd`; fi
  dir_name=`echo $git_root | sed "s@^.*\/@@"`
  echo $dir_name
  echo -en "\033];$dir_name\007"
}

# ディレクトリ変更時に毎回呼ばれる関数
function chpwd {
  set-window-title
}
# PERIOD=5
# add-zsh-hook periodic set-window-title


# 文字列を置換する
# ex. agreplace hoge fuga
function agreplace {
  ag -rl $1 . | xargs perl -i -pe "s/$1/$2/g"
}

# 検索してマッチした数を出す
# ex. agcount hoge path
function agcount {
  ag --nobreak --nofilename $1 $2 | wc -l 
}

# TODO:
# function agec {
#   emacsclient -n $(ag $@ | peco --query "$LBUFFER" | awk -F: '{print "+" $2, $1}')
# }

# クリップボードにコピー
# ex. copy hoge fuga
function copy {
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
function rails-genarate-view {
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

function init-gulp-project {
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

function init-rails-project {
  name=$1
  repository="git@github.com:shuuuuun/rails-template.git"
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

function tigdiff {
  git diff $@ | tig
}

# TODO: open-localhost
function open-localhost {
  open "http://localhost"
  # TODO: .envのPORTを読む
  # cat .env | ruby -e 'print gets.gsub(/^PORT ?= ?(\d+)/) { $1 }'
  # ↑これだと1行目しかとれない
  # dotenvとか使ってちゃんとやるほうがいいかも rubyで
  # https://github.com/bkeepers/dotenv
}

# TODO: open-local-ip
# PORTまわり
function open-local-ip {
  open "http://$(local-ip)"
}

function local-ip {
  ruby -r socket -e 'puts Socket.getifaddrs.select{|x| x.addr.ipv4?}.last.addr.ip_address'
  # python -c "import socket;print([(s.connect(('8.8.8.8', 80)), s.getsockname()[0], s.close()) for s in [socket.socket(socket.AF_INET, socket.SOCK_DGRAM)]][0][1])"
  # ローカルIPアドレスをプログラムで取得するには - Qiita - http://qiita.com/kjunichi/items/8e4967d04c3a1f6af35e
  # https://github.com/fnobi/koko/blob/master/lib/localIP.js
  # node.jsでローカルIPアドレスの取得 - Qiita - http://qiita.com/_shimizu/items/b38d1459abf8436f7f1f
}

# TODO: empty-port
# https://github.com/fnobi/emptyPort

# TODO: git-current-branch
# http://qiita.com/sugyan/items/83e060e895fa8ef2038c
# http://ikm.hatenablog.jp/entry/2012/11/28/114146

function github-file-page {
  filename=$1
  github_repo_name_regexp='/[https?:\/\/|git\@]github\.com[\/|:]([^\/]+)\/([^\/]+)\.git/'
  github_url=$(git remote -v | perl -0ne 'print "https://github.com/$1/$2" if ('$github_repo_name_regexp')')
  branch=$(git rev-parse --abbrev-ref HEAD)
  url="$github_url/blob/$branch/$filename"
  echo $url
  open $url
}

function github-commit-page {
  github_repo_name_regexp='/[https?:\/\/|git\@]github\.com[\/|:]([^\/]+)\/([^\/]+)\.git/'
  github_url=$(git remote -v | perl -0ne 'print "https://github.com/$1/$2" if ('$github_repo_name_regexp')')
  commit_url="$github_url/commit/$1"
  echo $commit_url
  open $commit_url
}

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
function git-diff-archive {
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

# ranger
# cf. https://github.com/ranger/ranger/blob/master/examples/bash_automatic_cd.sh
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
        if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
            cd -- "$(cat "$tempfile")"
        fi
    command rm -f -- "$tempfile"
}
alias rgr-cd="ranger-cd"

# 抜けた時のpwdを出力する
function rgr {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
        if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
            cat "$tempfile"
        fi
    command rm -f -- "$tempfile"
}

function ruby-string {
  if [ -p /dev/stdin ]; then
    str=$(cat -)
    method=$1
  else
    str=$1
    method=$2
  fi
  echo "str: $str"
  echo "method: $method"
  echo -n "out: "
  ruby -e "puts '$str'.send('$method')"
}

function git-wip {
  # TODO: unstagedな変更があるときも大丈夫か確認
  # TODO: checkoutしないバージョンもほしい
  branch=$1
  git checkout -b $branch
  git commit -m "wip" --allow-empty
}


#
# peco
#
function ps-peco {
  ps | peco --query "$1"
}

function ps-peco-pid-copy {
  result=$(ps | peco --query "$1")
  peco_status=$?
  echo "$result"
  if [ $peco_status -eq 0 ]; then
    pid=$(echo "$result" | perl -pe 's/ *(\d+) .*$/$1/')
    echo -n "$pid" | pbcopy
    echo "copied: $pid"
  fi
}

function ps-peco-kill {
  result=$(ps | peco --query "$1")
  echo "$result"
  for pid in $(echo "$result" | awk '{ print $1 }')
  do
    kill $pid
    echo "Killed $pid"
  done
}

function peco-args {
  # usage: find . -type d | peco-args cd
  #        cd $(find . -type d | peco)
  if [ -p /dev/stdin ]; then
    stdin=$(cat -)
    cmd=$1
  else
    echo "Error: stdin required."
    exit 1
  fi
  $cmd $(echo $stdin | peco)
}

function find-peco-cd {
  cd $(find-peco-dir)
}

function find-peco-dir {
  find . \( -name '.git' -prune \) -or \( -type d \) | peco
}

function find-peco-file {
  # TODO: gitignoreは１階層だけ表示とか
  # TODO: ディレクトリの中身が多いときは表示しないとか  
  find . -name '.git' -prune \
         -or -name 'node_modules' -prune \
         -or -type f -print \
    | peco
}

function peco-finder {
  # ディレクトリを選択したらその中身でpeco
  # 再帰的に
}

function peco-mdfind-cd {
  local FILENAME="$1"

  if [ -z "$FILENAME" ] ; then
    echo "Usage: peco-mdfind-cd <FILENAME>" >&2
    return 1
  fi

  local DIR=$(mdfind -onlyin ~ -name ${FILENAME} | grep -e "/${FILENAME}$" | peco | head -n 1)
  # local DIR=$(find ~ -maxdepth 5 -name ${FILENAME} | peco | head -n 1)

  if [ -n "$DIR" ] ; then
    DIR=${DIR%/*}
    echo "cd \"$DIR\""
    cd "$DIR"
  fi
}

function peco-find-cd {
  local FILENAME="$1"
  local MAXDEPTH="${2:-3}"
  local BASE_DIR="${3:-`pwd`}"

  if [ -z "$FILENAME" ] ; then
    echo "Usage: peco-find-cd <FILENAME> [<MAXDEPTH> [<BASE_DIR>]]" >&2
    return 1
  fi

  local DIR=$(find ${BASE_DIR} -maxdepth ${MAXDEPTH} -name ${FILENAME} | peco | head -n 1)

  if [ -n "$DIR" ] ; then
    DIR=${DIR%/*}
    echo "pushd \"$DIR\""
    pushd "$DIR"
  fi
}

function peco-git-cd {
  peco-find-cd ".git" "$@"
}

function peco-docker-cd {
  peco-find-cd "Dockerfile" "$@"
}

function peco-vagrant-cd {
  peco-find-cd "Vagrantfile" "$@"
}


# pushd
# alias peco-pushd="pushd +\$(dirs -p -v -l | sort -k 2 -k 1n | uniq -f 1 | sort -n | peco | head -n 1 | awk '{print \$1}')"


function peco-history {
  # historyを番号なし、逆順、最初から表示。
  # 順番を保持して重複を削除。
  # カーソルの左側の文字列をクエリにしてpecoを起動
  # \nを改行に変換
  # BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
  BUFFER="$(history -nr 1 | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
  CURSOR=$#BUFFER             # カーソルを文末に移動
  zle -R -c                   # refresh
}
# zle -N peco-select-history
# bindkey '^R' peco-select-history
# function peco-select-history() {
#   BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
#   CURSOR=$#BUFFER
#   zle clear-screen
# }
# zle -N peco-select-history
# bindkey '^r' peco-select-history


# 過去移動したディレクトリに移動します。ctrl-xにバインドしています。
# # ### search a destination from cdr list
# function peco-get-destination-from-cdr() {
#   cdr -l | \
#   sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
#   peco --query "$LBUFFER"
# }

# ### search a destination from cdr list and cd the destination
# function peco-cdr() {
#   local destination="$(peco-get-destination-from-cdr)"
#   if [ -n "$destination" ]; then
#     BUFFER="cd $destination"
#     zle accept-line
#   else
#     zle reset-prompt
#   fi
# }
# zle -N peco-cdr
# bindkey '^x' peco-cdr
