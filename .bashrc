# .bashrc

#
# Source global definitions
#
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi


#
# prompt
#
# export PROMPT_COMMAND='echo -en "\033];"$(pwd | sed "s@$HOME@~@")"\007"'
# export PS1="\[\e[34m\]\t\[\e[m\]\$ "


#
# function
#
source "$HOME/.sh/utils.sh"


#
# alias
#
source "$HOME/.sh/aliases.sh"


#
# history
#
export HISTSIZE=10000
export HISTCONTROL=ignoredups # 重複を無視
# export HISTIGNORE="fg*:bg*:history*" # 履歴に不要なコマンドを除外
export HISTTIMEFORMAT="%Y-%m-%d %T " # 使用時刻を表示
