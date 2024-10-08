#
# function
#

# TODO: ~/commands, ~/my_commands も取り込もう

function args-sample {
  echo "\$0=$0"
  echo "\$#=$#"
  echo "\$@=$@"
  echo "\$*=$*"
  # echo "\$1=$1"
  for i in $(seq 1 $#); do
    eval echo "'$'$i=\$$i"
  done
}

function make-Makefile {
  if [ -e Makefile ]; then
    return
  fi
  TAB="$(printf '\t')"
  cat <<-EOF > Makefile
.PHONY: help
help:
${TAB}@cat Makefile | grep -E '^[^\.]\S*:'
EOF
}

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

  # TODO: ssh時はhost名にしたい
  # TODO: sshから戻ったときに戻るようにしたい
  # git root directory name
  git_root=`git rev-parse --show-toplevel` > /dev/null 2>&1
  if [[ $git_root == "" ]]; then git_root=`pwd`; fi
  dir_name=`echo $git_root | sed "s@^.*\/@@"`
  echo -en "\033]0;$dir_name\007"
}

# ディレクトリ変更時に毎回呼ばれる関数
function chpwd {
  set-window-title
}
PERIOD=30
add-zsh-hook periodic set-window-title

# Enterを押してコマンドを実行する直前に呼ばれる
function preexec {
  # printf "# "
  # date +"%Y/%m/%d %H:%M:%S"
  # RPROMPT=`date +"%Y/%m/%d %H:%M:%S"`
  # RPROMPT='%D{%Y/%m/%d %H:%M:%S}'
}

# なんか画面に改行を空けたいときに
function br {
  if [ $# -eq 0 ]; then
    printf "\n\n\n\n\n\n\n\n\n\n"
  else
    for i in $(seq $1); do
      printf "\n"
    done
  fi
}

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

function agvim {
  line=$(ag $@ | peco --query "$LBUFFER")
  if [ -n "$line" ]; then
    vim $(echo "$line" | awk -F : '{print "-c " $2 " " $1}')
  fi
}

function rgvim {
  line=$(rg --line-number $@ | peco --query "$LBUFFER")
  if [ -n "$line" ]; then
    vim $(echo "$line" | awk -F : '{print "-c " $2 " " $1}')
  fi
}

# クリップボードにコピー
# ex. copy hoge fuga
function copy {
    echo $@ | pbcopy
}

# mkdirしてcdする
function mkdir-cd {
  mkdir $1 && cd $1
}
alias mkdircd='mkdir-cd'

# カレントディレクトリ以下の.DS_Storeを消す
function rm-ds-store {
  # targetFile="./**/.DS_Store" # なんか変数に入れるとうまくいかない
  ls -l ./**/.DS_Store
  # if [ -x /usr/local/bin/gomi ]; then
  # if type gomi > /dev/null 2>&1; then
  #   gomi ./**/.DS_Store
  # else
  #   rm ./**/.DS_Store
  # fi
  rm ./**/.DS_Store
}

# TODO: backupコマンド
# function buckup {
# }

# TODO: uniq-pbpaste function
# function uniq-pbpaste {
#   cat << EOS | sort | uniq
#   EOS
# }


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
    length=16
  fi
  openssl rand -hex $length
}

function rand64 {
  arg=$1
  length=$arg
  if [[ -z "$arg" ]]; then
    length=16
  fi
  # openssl rand -base64 $length
  base64 /dev/urandom | tr -d -c '[:alnum:]' | head -c $length
  echo
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

function static-website-cfn-clone {
  dir="./server"
  repository="git@github.com:shuuuuun/static-website-cfn.git"
  branch="master"
  git clone --depth 1 -b $branch $repository $dir
  rm -rf $dir/.git
}

# tigdiff branch とすると現在のブランチとそのブランチの差分が見れる
# tigの仕様が変わった？動かなくなった
# function tigdiff {
#   git diff $@ | tig
# }

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

# TODO: git-push-u-current-branch
# git push -u origin current-branch

GITHUB_REPO_NAME_REGEX='/[https?:\/\/|git\@]github\.com[\/|:]([^\/]+?)\/([^\/]+?)(\.git)?$/'

function github-file-page {
  filename=$1
  github_url=$(git remote -v | head -n 1 | awk '{ print $2 }' | perl -0ne 'print "https://github.com/$1/$2" if ('$GITHUB_REPO_NAME_REGEX')')
  branch=$(git rev-parse --abbrev-ref HEAD)
  url="$github_url/blob/$branch/$filename"
  echo $url
  open $url
}

function github-commit-page {
  commit=$1
  github_url=$(git remote -v | head -n 1 | awk '{ print $2 }' | perl -0ne 'print "https://github.com/$1/$2" if ('$GITHUB_REPO_NAME_REGEX')')
  commit_url="$github_url/commit/$commit"
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

# rubyのStringに生えてるメソッドを実行する
# irbを起動するのも面倒なときに使う
# ex. $ ruby-string hoge reverse
# ex. $ echo hoge | ruby-string reverse
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

function strsize {
  if [ -p /dev/stdin ]; then
    str=$(cat -)
  else
    str=$1
  fi
  local ruby_script=$(cat <<-RUBY
    puts "size: #{ '$str'.size }"
    puts "bytesize: #{ '$str'.bytesize }"
    puts "line: #{ '$str'.split("\\n").size }"
RUBY
  )
  ruby -e "$ruby_script"
}

function shuffle {
  ruby -e "puts '$1'.split('').shuffle.join('')"
}

function decode_uri {
  if [ -p /dev/stdin ]; then
    input=$(cat -)
  else
    input=$1
  fi
  ruby -ruri -e "puts URI.decode_www_form_component('$input')"
}

function encode_uri {
  if [ -p /dev/stdin ]; then
    input=$(cat -)
  else
    input=$1
  fi
  ruby -ruri -e "puts URI.encode_www_form_component('$input')"
}

function git-init {
  git init # 既存のrepoでは何もしないので大丈夫(Reinitialized existing Git repository とか出るので不安になるけど)
  git commit -m "init" --allow-empty
}

function git-wip {
  # TODO: unstagedな変更があるときも大丈夫か確認
  # TODO: checkoutしないバージョンもほしい
  branch=$1
  git checkout -b $branch
  git commit -m "wip" --allow-empty
}

function contains {
  [[ $1 =~ (^|[[:space:]])$2($|[[:space:]]) ]] && return 0 || return 1
}

# fetchしてremoteで削除されたブランチをローカルでも削除する
# 差分があれば削除されないので安心
function git-prune-all {
  # TODO: dryrun
  # prune_log=$(git fetch --prune)
  # branch=$(echo $prune_log | grep deleted | awk '{ sub("origin/", "", $5); print $5 }')
  git fetch --prune
  # git branch --merged
  local_branches=(`git branch --list | sed -e 's/^ *\** *//g' | tr '\n' ' '`)
  remote_branches=(`git branch --remotes | sed -e 's/^ *origin\///g' | tr '\n' ' '`)
  # diff <(echo $local_branches) <(echo $remote_branches)
  # echo "local: $local_branches"
  # echo "remote: $remote_branches"
  for local_br in $local_branches; do
    if ! contains "$remote_branches" $local_br; then
      # remoteになくてlocalにあるブランチ
      # 差分があると削除できないので安心
      # echo "deleting: $local_br"
      git branch -d $local_br 2> /dev/null
      if [ $? -eq 0 ]; then
        echo "deleted: $local_br"
      fi
    fi
  done
}

#
# peco
#
function ps-peco {
  ps aux | peco --query "$1"
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
  result=$(ps aux | peco --query "$1")
  echo "$result"
  for pid in $(echo "$result" | awk '{ print $2 }')
  do
    kill $pid
    echo "Killed $pid"
  done
}
alias ps-kill="ps-peco-kill"
alias pskill="ps-peco-kill"

function brew-upgrade-peco {
  brew update
  result=$(brew outdated --verbose | peco --query "$1")
  echo "$result"
  if [ -n "$result" ]; then
    lib="$(echo "$result" | awk '{ print $1 }')"
    brew upgrade $lib
    echo "brew upgraded: $lib"
  fi
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

function find-peco-dir {
  find . \( -name '.git' -prune \) -or \( -type d \) | peco
}
alias find-peco-cd='cd $(find-peco-dir)'

function find-peco-file {
  # TODO: gitignoreは１階層だけ表示とか
  # TODO: ディレクトリの中身が多いときは表示しないとか
  find . -name '.git' -prune \
         -or -name 'node_modules' -prune \
         -or -type f -print \
    | peco
}
alias find-peco-atom='atom $(find-peco-file)'
alias find-peco-subl='subl $(find-peco-file)'

# function peco-finder {
#   # ディレクトリを選択したらその中身でpeco
#   # 再帰的に
# }

function mdfind-peco {
  # cf. http://qiita.com/yungsang/items/37b548e7a12be28cf01e
  #     http://qiita.com/yungsang/items/e10ca283a1ceeaa845db
  local FILENAME="$1"

  if [ -z "$FILENAME" ] ; then
    echo "Usage: mdfind-peco <FILENAME>" >&2
    return 1
  fi

  mdfind -onlyin ~ -name ${FILENAME} | peco
}

# TODO: peco-history
# cf. http://qiita.com/tmsanrinsha/items/72cebab6cd448704e366
#     http://qiita.com/vintersnow/items/08852df841e8d5faa7c2
# function peco-history {
#   # historyを番号なし、逆順、最初から表示。
#   # 順番を保持して重複を削除。
#   # カーソルの左側の文字列をクエリにしてpecoを起動
#   # \nを改行に変換
#   # BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
#   BUFFER="$(history -nr 1 | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
#   CURSOR=$#BUFFER             # カーソルを文末に移動
#   zle -R -c                   # refresh
# }
# zle -N peco-history
# bindkey '^R' peco-history
#
# function peco-select-history {
#   BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
#   CURSOR=$#BUFFER
#   zle clear-screen
# }
# zle -N peco-select-history
# bindkey '^r' peco-select-history


# pushd
# alias peco-pushd="pushd +\$(dirs -p -v -l | sort -k 2 -k 1n | uniq -f 1 | sort -n | peco | head -n 1 | awk '{print \$1}')"

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

alias home2tilde='perl -pe "s@^$HOME@~@g"'
alias tilde2home='perl -pe "s@^~@$HOME@g"'

# cd repo directory with ghq and peco
function cd-repo {
  local new_path=$(ghq list -p | home2tilde | peco --query "$LBUFFER" | tilde2home)
  if [ -n "$new_path" ]; then
    cd ${new_path}
    echo "jump to ${new_path}"
  fi
}

# cd works directory with peco
function cd-works {
  local new_path=$(find ~/works -name '.git' -prune \
                      -or -type d \
                      -maxdepth 2 \
               | home2tilde \
               | peco --query "$LBUFFER" \
               | tilde2home)
  if [ -n "$new_path" ]; then
    cd ${new_path}
    echo "jump to ${new_path}"
  fi
}

function ghq-get-repo-cd {
  local repo=$1
  ghq get $repo
  cd $(ghq list --full-path --exact $repo)
}
alias get-repo-cd='ghq-get-repo-cd'

function ghq-create-shuuuuun {
  local repo=shuuuuun/$1
  ghq create $repo
  cd $(ghq list --full-path --exact $repo)
  git-init
}

function docker-volumes-backup {
  now=$(date +"%Y%m%d_%H%M%S")
  backup_path="${HOME}/tmp/docker-volumes-backup/${now}"
  volume_names=($(docker volume ls -q))
  echo "backup_path: ${backup_path}"
  echo "volume_names: ${volume_names}"
  mkdir -p "${backup_path}"
  for volume_name in ${volume_names}; do
    docker run --rm \
      -v ${volume_name}:/data \
      -v ${backup_path}:/backup \
      alpine \
      tar cvf /backup/${volume_name}.tar /data
  done
  echo "complete!"
}

function docker-volumes-restore {
  root_backup_path="${HOME}/tmp/docker-volumes-backup"
  # \ls でデフォルトのlsを使いcolorが付かないようにする
  backup_paths=($(\ls -d ${root_backup_path}/* | sort))
  backup_path=$backup_paths[-1]
  volume_names=($(\ls "${backup_path}" | sed -e "s/\.tar//"))
  echo "backup_path: ${backup_path}"
  echo "volume_names: ${volume_names}"
  for volume_name in ${volume_names}; do
    docker volume create --name ${volume_name}
    docker run --rm \
      -v ${volume_name}:/data \
      -v ${backup_path}/${volume_name}.tar:/backup/backup.tar \
      alpine sh -c "cd /data && tar xvf /backup/backup.tar --strip 1"
  done
  echo "complete!"
}

function docker-volume-remove {
  local selected=$(docker system df -v --format 'json' | jq -r '.Volumes[] | [.Size, .Name] | @tsv' | sort --human-numeric-sort --reverse -k 1 | peco --prompt 'DOCKER VOLUMES>' --query "$1")
  echo $selected
  local volumes=($(echo -n $selected | awk '{print $2}' ORS=' '))
  if [ -z "$volumes" ]; then
    echo "no volumes selected."
    return
  fi
  # echo "volumes:$volumes;"
  docker volume rm $volumes && echo "docker volumes removed: $volumes"
}

function docker-images-remove {
  local selected=$(docker image ls --format "table {{.Size}}\t{{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}" | sort --human-numeric-sort --reverse -k 1 | peco --prompt 'DOCKER IMAGES>' --query "$1")
  echo $selected
  local images=($(echo -n $selected | awk '{print $4}' ORS=' '))
  if [ -z "$images" ]; then
    echo "no images selected."
    return
  fi
  # echo "images:$images;"
  docker image rm $images && echo "docker images removed: $images"
}

function docker-images-remove-force {
  local selected=$(docker image ls --format "table {{.Size}}\t{{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}" | sort --human-numeric-sort --reverse -k 1 | peco --prompt 'DOCKER IMAGES>' --query "$1")
  echo $selected
  local images=($(echo -n $selected | awk '{print $4}' ORS=' '))
  if [ -z "$images" ]; then
    echo "no images selected."
    return
  fi
  # echo "images:$images;"
  docker image rm --force $images && echo "docker images removed: $images"
}

function docker-images-remove-repo {
  local selected=$(docker image ls --format "table {{.Size}}\t{{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}" | sort --human-numeric-sort --reverse -k 1 | peco --prompt 'DOCKER IMAGES>' --query "$1")
  echo $selected
  local images=($(echo -n $selected | awk '{print $2}' ORS=' '))
  if [ -z "$images" ]; then
    echo "no images selected."
    return
  fi
  # echo "images:$images;"
  docker image rm $images && echo "docker images removed: $images"
}

function docker-container-exec-bash {
  local selected=$(docker container ls | tail +2 | peco --prompt 'DOCKER CONTAINERS>' --query "$1")
  echo $selected
  local container_id=($(echo -n $selected | awk '{print $1}' ORS=' '))
  if [ -z "$container_id" ]; then
    echo "no container selected."
    return
  fi
  # echo "container_id:$container_id;"
  docker exec -it $container_id bash
}

function ebenv2dotenv {
  env_name="$1"
  if [ -z "$env_name" ]; then
    echo 'EBの環境名を指定してね！'
    return 1
  fi
  result=`eb printenv ${env_name}`
  echo $result
  env_str=`echo $result | grep '=' | gsed -r 's@^\s*(.+)\s=\s(.+)$@\1=\2@g'`
  if [ -z "$env_str" ]; then
    echo '環境変数が見つかりませんでした！'
    return 1
  fi
  output=".env.${env_name}"
  echo ${env_str} > "${output}"
  echo "printed to ${output}"
}

function tmux-peco {
  name=`tmux ls | peco --query "$1" | awk -F: '{print $1}'`
  [ -z "$name" ] && return
  echo $name
  tmux -CC new -A -s $name
}

function git-worktree-cd {
  result=$(git worktree list | peco --query "$1" --select-1)
  echo "$result"
  dir=$(echo "$result" | awk '{ print $1 }')
  cd "$dir"
}
alias cd-git-worktree='git-worktree-cd'

function git-worktree-add {
  dirname=$1
  branch=$2
  if [ -z "$dirname" -o -z "$branch" ]; then
    echo "Too few arguments. Usage: git-worktree-add dirname branch"
    return 1
  fi
  relpath="tmp/worktrees/$dirname"
  echo "$relpath"
  mkdir -p "$relpath"
  git worktree add "$relpath" "$branch"
  cd "$relpath"
}

function tracer-peco {
  name=`tracer "$1" | peco | awk '{print $1}'`
  [ -z "$name" ] && return
  echo $name
  tracer $1 $name
}

# リポジトリ一覧を最終コミット日時順で取得
function git-last-commit-repo-list {
  maxdepth=3
  for repo in $(find . -maxdepth $maxdepth -name ".git" | cut -c 3-); do
    echo "$(git --git-dir=$repo log -1 --format="%ci $repo" | awk '{print $1" "$2" "$3" "$4" "$5}')"
  done | sort -r
}
