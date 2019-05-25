#
# alias
#

if has gls; then
  alias ls='gls --color' # GNU ls
  alias lscopy='gls -a | pbcopy'
elif is_mac || is_bsd; then
  alias ls='ls -G' # color
else
  alias ls='ls --color'
fi
alias l='ls -lah --time-style=long-iso'
alias ll='ls -lh --time-style=long-iso'
alias la='ls -a'
alias lla='ls -lah --time-style=long-iso'
alias lt='ls -lht --time-style=long-iso'
alias lta='ls -laht --time-style=long-iso'
alias ls1='ls -1'
alias la1='ls -a1'
alias ls-fullpath='ls -1d $PWD/*'
alias lsfull=ls-fullpath

alias lns='ln -s'
alias nanow='nano -w'
alias les='less'

alias rmrf='rm -rf'
alias cprf='cp -rf'
# alias rm='echo use \`gomi\` command!!; false'
alias top-cpu='top -o cpu'
alias rsync-copy='rsync -C --filter=":- .gitignore" -av'
alias now='date +"%Y%m%d_%H%M%S"'

alias psgrep='ps aux | grep -v grep | grep'
alias psag='ps aux | ag -v ag | ag'

alias tailf='tail -f'

alias relogin='exec $SHELL -l'

if is_zsh; then
  alias history='history -i' # 使用時刻を表示
  alias history-all='history -i 1 | less'
  if has peco; then
    alias history-peco='history -i 1 | peco'
  fi
  if has rg; then
    alias history-rg='history -i 1 | rg'
  fi
  if has ag; then
    alias history-ag='history -i 1 | ag'
  fi
  if has grep; then
    alias history-grep='history -i 1 | grep'
  fi
fi

if is_mac; then
  alias open.='open .'

  alias jxa='osascript -l JavaScript'

  # alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
  alias emacs='emacs -nw' # for GNU emacs (GUIが起動しちゃうのでCLIにする)
  # alias st='subl'
  # alias stc='subl .'
  alias atm='atom'
  alias atm.='atom .'
  alias atom.='atom .'
  alias subl.='subl .'
  alias vscode='code'
  alias vsc='code'
  alias code.='code .'
  alias vsc.='code .'

  alias chrome='open -a "/Applications/Google Chrome.app"'

  alias purgesudo='sudo purge'

  alias copy-branch='git symbolic-ref --short HEAD | pbcopy'

  GITHUB_REPO_NAME_REGEX='/[https?:\/\/|git\@]github\.com[\/|:]([^\/]+)\/([^\/]+)\.git/'
  # TODO: URLをechoしときたい
  alias open-github='git remote -v | perl -0ne '"'"'print "https://github.com/$1/$2" if ('$GITHUB_REPO_NAME_REGEX')'"'"' | xargs -I url open url'
  alias open-gh-pages='git remote -v | perl -0ne '"'"'print "https://$1.github.io/$2/" if ('$GITHUB_REPO_NAME_REGEX')'"'"' | xargs -I url open url'
  alias push-gh-pages='git subtree push --prefix public/ origin gh-pages'
  alias github='open-github'
  alias gh-open='open-gh-pages'
  alias gh-push='push-gh-pages'
fi

alias g='git'
alias gst='git status'
alias gbr='git branch'
alias gbra='git branch -a'
alias gstash='git stash'
alias gad='git add'
alias gad.='git add .'
alias gada='git add --all'
alias gcm='git commit'
# TODO: オプション意外の引数は全部コメントみたいにしたい
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
alias gclone='git clone'
alias greset='git reset'
alias grebase='git rebase'
alias gremotev='git remote -v'
# git remote get-url
# TODO: デフォルトをpruneにしちゃってもいいかも
# TODO: 手元の不要なブランチを消すscriptも作りたい
alias gpull-prune='git pull --prune'
alias gpull-rebase='git pull --rebase'
alias gcomaster='git checkout master'
alias gcodevelop='git checkout develop'
alias git-root='git rev-parse --show-toplevel'
alias gft-origin-master='git fetch origin master:master'
alias gft-origin-develop='git fetch origin develop:develop'
function gft-origin() { git fetch origin $1:$1; }
alias git-empty-commit='git commit --allow-empty'
alias git-clone-shallow='git clone --depth 1 --single-branch'
alias git-commit-date='git --no-pager log --pretty=format:%ci -n 1'
if has peco; then
  alias gco-peco='git branch | peco | xargs git checkout'
fi

if has tig; then
  alias tg='tig'
  alias tgst='tig status'
  alias tigstatus='tig status'
  alias tigstash='tig stash'
  alias tigrep='tig grep'
  alias tgp='tig grep'
  alias tigmaster='tig master'
  alias tigdevelop='tig develop'
  if has peco; then
    function tigbranch { tig $(git branch | peco); }
    function tigbranch-a { tig $(git branch -a | peco); }
  fi
fi

if has svn; then
  alias svnupdate='svn update'
  alias svnstatus='svn status'
  alias svndiff='svn diff | less'
  alias svnlog='svn log | less'
fi

if has bundle; then
  alias bundle-install-path-vendor-bundle='bundle install --path vendor/bundle'
  alias bundle-exec='bundle exec'
  alias be='bundle exec'
  alias rails-server='bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000}'
  alias rails-console='bundle exec rails console'
  # see. bundle exec rails new --help
  alias rails-new-simple='bundle exec rails new --database=mysql --skip-action-mailer --skip-action-mailbox --skip-action-cable --skip-sprockets --skip-spring --skip-listen --skip-turbolinks --skip-bundle --skip-git'
fi

if has npm; then
  alias npm-shrinkwrap='npm shrinkwrap'
  alias npm-install-save-dev='npm install --save-dev'
  alias npm-ls-global='npm ls -g --depth=0'
fi

if has redis-server; then
  alias redis-server='redis-server /usr/local/etc/redis.conf'
fi

if has pg_ctl; then
  alias postgres-start='pg_ctl start -D /usr/local/var/postgres -l /usr/local/var/log/postgres.log'
fi

if has docker-compose; then
  alias dc='docker-compose'
fi

if has jq; then
  alias npm-scripts='cat package.json | jq .scripts'
fi

if has ruby; then
  alias yaml2json='ruby -ryaml -rjson -e "puts YAML.load(STDIN.read).to_json"'
  alias json2yaml='ruby -ryaml -rjson -e "puts JSON.parse(STDIN.read).to_yaml"'
fi

if has rg; then
  alias rgTODO='rg TODO'
  alias rg-hidden='rg --glob "!.git" --hidden'
fi

if has nkf; then
  alias nkf-guess='nkf --guess' # 文字コードを表示
fi

if has colordiff; then
  alias diff='colordiff -u'
  function diffless { colordiff -u $@ | less; }
fi
alias gitdiff='git diff --no-index'
# vimdiff というのもある

# alias highlight='highlight --style=Moria'
