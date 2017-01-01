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
eval "$(anyenv init -)"


# ------------------
export DISPLAY=':0.0'


# PATH ----------
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
export GOPATH=$HOME/go


# Editors ----------
export EDITOR='vim'
export VISUAL='vim' 
export PAGER='less'


