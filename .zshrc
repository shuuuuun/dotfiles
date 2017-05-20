#
# zplug (Zsh Plugin Manager) https://github.com/zplug/zplug
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
source "$HOME/.zsh/aliases.sh"


#
# function
#
source "$HOME/.zsh/functions.sh"
# TODO: autoload使ったほうがいいのかも http://qiita.com/yuku_t/items/77c23390e52168a2754a


#
# load local settgins
#
source ~/.zshrc_local


#
# other
#

# tig
# cf. https://github.com/jonas/tig/blob/master/contrib/tig-completion.zsh
# TODO:
# fpath=($fpath /usr/local/Cellar/tig/2.2.1/share/zsh/site-functions)

# 上矢印で入力中の単語にマッチした履歴を出してくれるやつがほしくてそれだけ書こうとしたけど
# ちゃんと分からないので
# とりあえずoh-my-zshのkey-bindingを読み込む
source ~/.oh-my-zsh/lib/key-bindings.zsh
