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
# path=(
#   /usr/local/{bin,sbin}
#   $path
# )

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
# PATH
#
# echo $PATH
# /usr/libexec/path_helper -s

if [[ -n $TMUX ]]; then
  # tmux の場合は親シェルのPATHが引き継がれちゃうのでリセット
  path=(
    /usr/local/{bin,sbin}
    /System/Cryptexes/App/usr/bin
    /usr/bin
    /bin
    /usr/sbin
    /sbin
    # $path
  )
fi

if [ -d /opt/homebrew  ]; then
  export PATH=/opt/homebrew/bin:$PATH
fi
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:~/.local/bin
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
export PATH=$PATH:~/.cargo/bin # Rust
export PATH=$PATH:~/.mix/escripts # elixir, erlang
export PATH=$PATH:~/Library/Python/3.11/bin
export PATH=$PATH:~/lib/flutter/bin
export GOPATH=$HOME/repo
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/.sh/commands


#
# LS_COLORS
#
dircolors_path="$HOME/.sh/lib/seebi/dircolors-solarized/dircolors.ansi-universal"
if [ -f $dircolors_path ]; then
  eval $(gdircolors $dircolors_path)
fi

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
export ERL_AFLAGS='-kernel shell_history enabled' # elixir iex
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export AWS_PAGER=""
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
export LIMA_INSTANCE=docker
export RUBY_CONFIGURE_OPTS=--enable-yjit
export ECSPRESSO_FILTER_COMMAND=peco

# asdf
# doc: https://asdf-vm.com/guide/getting-started.html
ASDF_DIR="${ASDF_DATA_DIR:-$HOME/.asdf}"
if [ -d $ASDF_DIR ]; then
  export PATH="$ASDF_DIR/shims:$PATH"

  mkdir -p "$ASDF_DIR/completions"
  asdf completion zsh > "$ASDF_DIR/completions/_asdf"

  # append completions to fpath
  fpath=($ASDF_DIR/completions $fpath)
  # initialise completions with ZSH's compinit
  autoload -Uz compinit && compinit
fi

# aqua (asdfより後に設定)
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
