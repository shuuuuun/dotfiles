#
# Language
#
if [[ -z "$LANG" ]]; then
  # export LANG='en_US.UTF-8'
  export LANG='ja_JP.UTF-8'
fi

#
# Paths
#
# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

#
# Less
#
#default# export LESS='-F -g -i -M -R -S -w -X -z-4'
export LESS="-iMRS"

#
# LS_COLORS
#
dircolors_path="$HOME/.sh/lib/seebi/dircolors-solarized/dircolors.ansi-universal"
if [ -f $dircolors_path ]; then
  eval $(gdircolors $dircolors_path)
fi

#
# Temporary Files
#
if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"


#
# anyenv
#
export PATH="$HOME/.anyenv/bin:$PATH"
if type anyenv > /dev/null 2>&1; then
  eval "$(anyenv init -)"
fi


#
# PATH
#
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
export PATH=$PATH:~/Library/Python/2.7/bin
export PATH=$PATH:~/lib/flutter/bin
# export GOPATH=$HOME/go
export GOPATH=$HOME/repo
export PATH=$PATH:$GOPATH/bin


#
# Editors
#
export EDITOR='vim'
export VISUAL='vim' 
export PAGER='less'


#
# Others
#
export DISPLAY=':0.0'
