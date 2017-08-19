# .bash_profile

#
# Get the aliases and functions
#
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi


#
# PATHs
#
export PATH="$PATH:$HOME/.local/bin:$HOME/bin"
export GOPATH="$HOME/go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"


#
# rbenv
#
if [ -d ${HOME}/.rbenv  ] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
