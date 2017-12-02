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
source "$HOME/.sh/functions.sh"


#
# alias
#
source "$HOME/.sh/aliases.sh"


#
# other
#
if is_mac; then
  set-window-title
fi
