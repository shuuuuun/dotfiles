#
# alias
#
if type gls > /dev/null 2>&1; then
  alias ls='gls --color' # GNU ls
else
  alias ls='ls -G' # color
fi
alias l='ls -la'
alias ll='ls -l'
alias la='ls -a'
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
alias gco-peco='git branch | peco | xargs git checkout'
alias gft-origin-master='git fetch origin master:master'
alias gft-origin-develop='git fetch origin develop:develop'

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
