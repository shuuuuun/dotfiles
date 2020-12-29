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
# anyenv
#
if type anyenv > /dev/null 2>&1; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi
