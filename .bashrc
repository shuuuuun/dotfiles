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

