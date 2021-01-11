#
# util function
#

# cf. https://github.com/b4b4r07/dotfiles/blob/master/.zsh/10_utils.zsh

function has {
    # type command > /dev/null 2>&1
    type "${1:?too few arguments}" &>/dev/null
}

function source_if_exist {
  file="${1:?too few arguments}"
  if [ -f "$file" ]; then
    source "$file"
  fi
}

# ostype returns the lowercase OS name
function ostype {
    # echo ${(L):-$(uname)} # zsh
    # echo ${$(uname):l} # zsh
    # echo ${$(uname),,} # bash4.0
    uname | tr '[:upper:]' '[:lower:]'
}

# os_detect export the PLATFORM variable as you see fit
function os_detect {
    export PLATFORM
    case "$(ostype)" in
        *'linux'*)  PLATFORM='linux'   ;;
        *'darwin'*) PLATFORM='mac'     ;;
        *'bsd'*)    PLATFORM='bsd'     ;;
        *)          PLATFORM='unknown' ;;
    esac
}

# is_mac returns true if running OS is Macintosh
function is_mac {
    os_detect
    if [[ $PLATFORM == "mac" ]]; then
        return 0
    else
        return 1
    fi
}

# is_linux returns true if running OS is GNU/Linux
function is_linux {
    os_detect
    if [[ $PLATFORM == "linux" ]]; then
        return 0
    else
        return 1
    fi
}

# is_bsd returns true if running OS is FreeBSD
function is_bsd {
    os_detect
    if [[ $PLATFORM == "bsd" ]]; then
        return 0
    else
        return 1
    fi
}

# get_os returns OS name of the platform that is running
function get_os {
    local os
    for os in mac linux bsd; do
        if is_$os; then
            echo $os
        fi
    done
}

function is_zsh {
  # which zsh &>/dev/null && [ "$SHELL" = `which zsh` ]
  if echo $SHELL | grep -qs zsh; then
    return 0
  else
    return 1
  fi
}
