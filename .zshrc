#
# Zinit
#
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# plugins
zinit ice wait'!0'; zinit light zsh-users/zsh-autosuggestions
# zinit ice wait'!0'; zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait'!0'; zinit light zdharma/fast-syntax-highlighting
zinit ice wait'!0'; zinit light zsh-users/zsh-completions # 補完
# zinit light zdharma/history-search-multi-word
# zinit light zsh-users/zsh-history-substring-search
# zinit light momo-lab/zsh-abbrev-alias # 略語を展開する

# prompt
zinit light mafredri/zsh-async # need for pure prompt
# zinit light sindresorhus/pure
zinit light shuuuuun/pure
# zinit light nksoff/muslim
# zinit light isqua/bureau

# zinit wait lucid atload"zicompinit; zicdreplay" blockf for zsh-users/zsh-completions


#
# prompt
#
# PURE_PROMPT_SYMBOL='%*$'
# PURE_PROMPT_LEFT='%*'
PURE_PREPROMPT_LEFT='%*'
PURE_PROMPT_SYMBOL='$'
PURE_PROMPT_SYMBOL_COLOR='magenta'
PURE_PROMPT_SYMBOL_ERROR_COLOR='red'
PURE_DISABLE_SET_TITLE=true
# PURE_GIT_PULL=0
PURE_PREPROMPT_DIRECTORY_COLOR='cyan'
type prompt_pure_setup > /dev/null 2>&1 && prompt_pure_setup

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

if has direnv; then
  eval "$(direnv hook zsh)"
fi

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
