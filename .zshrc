#
# Zinit
#
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-rust \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-bin-gem-node

### End of Zinit's installer chunk

# plugins
zinit wait lucid light-mode for zsh-users/zsh-autosuggestions
# zinit wait lucid light-mode for zsh-users/zsh-syntax-highlighting
zinit wait lucid light-mode for zdharma-continuum/fast-syntax-highlighting
zinit wait lucid light-mode for zsh-users/zsh-completions # 補完
# zinit wait lucid light-mode for zdharma-continuum/history-search-multi-word
# zinit wait lucid light-mode for zsh-users/zsh-history-substring-search
# zinit wait lucid light-mode for momo-lab/zsh-abbrev-alias # 略語を展開する

# prompt
zinit light mafredri/zsh-async # need for pure prompt
# zinit light sindresorhus/pure
zinit light shuuuuun/pure
# zinit light nksoff/muslim
# zinit light isqua/bureau

# git completion
# zinit wait silent lucid atclone"zstyle ':completion:*:*:git:*' script git-completion.bash" atpull"%atclone" for "https://github.com/git/git/blob/master/contrib/completion/git-completion.bash"
# zinit wait lucid as"completion" atload"zicompinit; zicdreplay" mv"git-completion.bash -> _git.bash" atclone"zstyle ':completion:*:*:git:*' script _git.bash" atpull"%atclone" for "https://github.com/git/git/blob/master/contrib/completion/git-completion.bash"
# zinit wait lucid as"completion" atload"zicompinit; zicdreplay" mv"git-completion.zsh -> _git" for "https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh"
zinit wait lucid atload"zicompinit; zicdreplay" light-mode for felipec/git-completion
# zinit light felipec/git-completion

# direnv
# ref. https://zdharma-continuum.github.io/zinit/wiki/Direnv-explanation/
zinit wait lucid light-mode from"gh-r" as"program" mv"direnv* -> direnv" \
      atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
      pick"direnv" src="zhook.zsh" for \
      direnv/direnv


#
# prompt
#
# PURE_PROMPT_SYMBOL='%*$'
# PURE_PREPROMPT_LEFT='%*'
PURE_PREPROMPT_LEFT="%D{%Y/%m/%d %H:%M:%S}"
# PURE_PROMPT_LEFT='%F{6}%D %*%f '
# PURE_PROMPT_LEFT="%D{%Y-%m-%d %H:%M:%S} %f"
PURE_PROMPT_SYMBOL='$'
PURE_DISABLE_SET_TITLE=true
# PURE_GIT_PULL=0
type prompt_pure_setup > /dev/null 2>&1 && prompt_pure_setup

# ref. https://github.com/sindresorhus/pure#colors
zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:git:dirty color 242

zstyle :prompt:pure:git:stash show yes

# autoload -U promptinit
# promptinit
# prompt pure
# prompt muslim

# function show_command_end_time() {
#   PURE_PREPROMPT_LEFT=`date "+%Y-%m-%d %H:%M:%S"`
# }
# autoload -Uz add-zsh-hook
# add-zsh-hook precmd show_command_end_time

# show_command_begin_time() {
#   PURE_PROMPT_LEFT=`date "+%H:%M:%S"`
#   # PURE_PROMPT_LEFT="%D{%Y-%m-%d %H:%M:%S} %f"
#   zle .accept-line
#   zle .reset-prompt
# }
# zle -N accept-line show_command_begin_time

# re-prompt() {
#     PURE_PROMPT_LEFT=`date "+%H:%M:%S"`
#     zle .reset-prompt
#     zle .accept-line
# }
# zle -N accept-line re-prompt

# export TMOUT=1
# function TRAPALRM() {
#   zle .reset-prompt
# }

# show-time() {
#   zle .accept-line
#   echo "\n"`date "+%Y-%m-%d %H:%M:%S"`
# }
# zle -N accept-line show-time

# current-rprompt() {
#   RPROMPT=''
# }
# add-zsh-hook precmd current-rprompt

# update-rprompt-accpet-line() {
#   echo update-rprompt-accpet-line
#   # RPROMPT=`date +"%Y/%m/%d %H:%M:%S"`
#   RPROMPT='%D{%y/%m/%d %H:%M:%S}'
#   zle .reset-prompt
#   zle .accept-line
# }
# zle -N accept-line update-rprompt-accpet-line


#
# setopt
#
setopt transient_rprompt # RPROMPTを残さない
unsetopt correct # disable autocorrect
setopt nonomatch # ?などのグロブ展開を無効化

# history
setopt share_history
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"       # The path to the history file.
HISTSIZE=100000                  # The maximum number of events to save in the internal history.
SAVEHIST=100000                  # The maximum number of events to save in the history file.

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

# cd
setopt AUTO_CD                  # ディレクトリ名と一致した場合 cd
setopt AUTO_PUSHD               # ディレクトリをスタックに自動追加する
setopt PUSHD_IGNORE_DUPS        # 同じディレクトリは追加しない
cdpath=(~/works)


#
# zstyle
#
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完で大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # あいまい検索 cf. ~/.oh-my-zsh/lib/completion.zsh
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # 補完候補をカラー表示
zstyle ':completion:*:default' menu select=2 # 補完をメニュー選択モードに. (選択されてるものがハイライト, 左右キーで移動)


#
# function
#
source "$HOME/.sh/utils.sh"
source "$HOME/.sh/functions.sh"
# TODO: autoload使ったほうがいいのかも http://qiita.com/yuku_t/items/77c23390e52168a2754a


#
# alias
#
source "$HOME/.sh/aliases.sh"


#
# load local settgins
#
source_if_exist ~/.zshrc_local


#
# other
#
bindkey -e # emacs key bindings

if is_mac; then
  set-window-title
fi

REPORTTIME=3

# if has direnv; then
#   eval "$(direnv hook zsh)"
# fi

if [ -d ${HOME}/.anyenv ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  if [ -d $(anyenv root)/plugins/anyenv-lazyload ]; then
    eval "$(anyenv lazyload --no-rehash)"
  else
    # eval "$(anyenv init -)"
    eval "$(anyenv init - --no-rehash)"
  fi
fi

# tig
# cf. https://github.com/jonas/tig/blob/master/contrib/tig-completion.zsh
# fpath=($fpath /usr/local/Cellar/tig/*/share/zsh/site-functions)
source_if_exist "/usr/local/Cellar/tig/*/share/zsh/site-functions/tig-completion.bash"

# lf
# ref. https://github.com/gokcehan/lf/wiki/Tutorial#working-directory
# $ curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/lfcd.sh -o ~/.config/lf/lfcd.sh
source_if_exist "$HOME/.config/lf/lfcd.sh"
if has lfcd; then
  alias cd-lf='lfcd'
fi


# 上矢印で入力中の単語にマッチした履歴を出してくれるやつ
# ref. https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh
#
# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi
# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi


# Zsh Profiling
if (which zprof > /dev/null 2>&1); then
  zprof | cat
fi
