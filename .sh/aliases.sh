#
# alias
#
if has gls; then
  alias ls='gls --color' # GNU ls
elif is_mac || is_bsd; then
  alias ls='ls -G' # color
else
  alias ls='ls --color'
fi
alias l='ls -lah --time-style=long-iso'
alias ll='ls -lh --time-style=long-iso'
alias la='ls -a'
alias lla='ls -lah --time-style=long-iso'
alias lns='ln -s'
alias ls1='ls -1'
alias la1='ls -a1'
alias ls-fullpath='ls -1d $PWD/*'
alias nanow='nano -w'
alias les='less'

alias rmrf='rm -rf'
alias cprf='cp -rf'
# alias rm='echo use \`gomi\` command!!; false'
alias top-cpu='top -o cpu'
alias rsync-copy='rsync -C --filter=":- .gitignore" -av'
alias purgesudo='sudo purge'
alias history-all='history -E 1'
alias now='date +"%Y%m%d_%H%M%S"'

if is_mac; then
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
# TODO: デフォルトをpruneにしちゃってもいいかも
# TODO: 手元の不要なブランチを消すscriptも作りたい
alias gpull-prune='git pull --prune'
alias gpull-rebase='git pull --rebase'
alias gcomaster='git checkout master'
alias gcodevelop='git checkout develop'
alias git-root='git rev-parse --show-toplevel'
alias gco-peco='git branch | peco | xargs git checkout'
alias gft-origin-master='git fetch origin master:master'
alias gft-origin-develop='git fetch origin develop:develop'
function gft-origin() { git fetch origin $1:$1 }
alias git-empty-commit='git commit --allow-empty'

alias copy-branch='git symbolic-ref --short HEAD | pbcopy'

if has tig; then
  alias tg='tig'
  alias tgst='tig status'
  alias tigstatus='tig status'
  alias tigstash='tig stash'
  alias tigrep='tig grep'
  alias tgp='tig grep'
  alias tigmaster='tig master'
  alias tigdevelop='tig develop'
  # TODO: ↓なんか動かない
  # alias tigbranch='git branch | peco | xargs tig'
  # alias tigbranch='git branch | peco | xargs -I br tig br'
  # function tigbranch { br=$(git branch | peco); echo "$br"; tig "$br" }
  function tigbranch { tig $(git branch | peco); }
  function tigbranch-a { tig $(git branch -a | peco); }
fi

if has svn; then
  alias svnupdate='svn update'
  alias svnstatus='svn status'
  alias svndiff='svn diff | less'
  alias svnlog='svn log | less'
fi

GITHUB_REPO_NAME_REGEX='/[https?:\/\/|git\@]github\.com[\/|:]([^\/]+)\/([^\/]+)\.git/'
# TODO: URLをechoしときたい
alias open-github='git remote -v | perl -0ne '"'"'print "https://github.com/$1/$2" if ('$GITHUB_REPO_NAME_REGEX')'"'"' | xargs -I url open url'
alias open-gh-pages='git remote -v | perl -0ne '"'"'print "https://$1.github.io/$2/" if ('$GITHUB_REPO_NAME_REGEX')'"'"' | xargs -I url open url'
alias push-gh-pages='git subtree push --prefix public/ origin gh-pages'
alias github='open-github'
alias gh-open='open-gh-pages'
alias gh-push='push-gh-pages'

if has bundle; then
  alias bundle-install-path-vendor-bundle='bundle install --path vendor/bundle'
  alias bundle-exec='bundle exec'
  alias be='bundle exec'
fi

if has npm; then
  alias npm-shrinkwrap='npm shrinkwrap'
  alias npm-install-save-dev='npm install --save-dev'
  alias npm-ls-global='npm ls -g --depth=0'
fi

# alias highlight='highlight --style=Moria'
