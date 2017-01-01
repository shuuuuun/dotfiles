export PROMPT_COMMAND='echo -en "\033];"$(pwd | sed "s@$HOME@~@")"\007"'
export PS1="\[\e[34m\]\t\[\e[m\]\$ "

alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lns='ln -s'
alias nanow='nano -w'
alias sl='open -a /Applications/Sublime\ Text\ 2.app'
alias les='less'

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

