# .bash_profile

#
# Get the aliases and functions
#
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi


#
# Less
#
export LESS="-iMRS"


#
# PATHs
#
export PATH="$PATH:$HOME/.local/bin:$HOME/bin"


#
# xxenv
#
if [ -d ${HOME}/.rbenv  ] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
if [ -d ${HOME}/.ndenv  ] ; then
  export PATH="$HOME/.ndenv/bin:$PATH"
  eval "$(ndenv init -)"
fi
