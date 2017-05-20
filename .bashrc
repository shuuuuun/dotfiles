#
# prompt
#
export PROMPT_COMMAND='echo -en "\033];"$(pwd | sed "s@$HOME@~@")"\007"'
export PS1="\[\e[34m\]\t\[\e[m\]\$ "


#
# alias
#
source "$HOME/.sh/aliases.sh"


#
# function
#
source "$HOME/.sh/utils.sh"
source "$HOME/.sh/functions.sh"


#
# other
#

# fzf
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
