export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# run simple HTTP server
httpshare () {
  echo -e "Starting simple HTTP server. Listening on:\n"
  for ip in $(ifconfig | grep "inet " | grep -v "127.0" | awk '{ print $2 }'); do echo -e "\thttp://${ip}:8000"; done
  echo ""
  python -m SimpleHTTPServer 8000 2>/dev/null
}

#merck proxy -----------------------------------------------------------
export my_proxy=PROXY_IP

myProxy () {
  if [ -z "$my_proxy" ]; then
    echo "Bad configuration, $my_proxy is missing"
    return -1
  fi
  case "$1" in
    "start")
      echo "Starting proxy"
      export http_proxy=$my_proxy
      export https_proxy=$my_proxy
      export ftp_proxy=$my_proxy
      export ALL_PROXY=$my_proxy
      echo "[DONE]"
    ;;
    "stop")
      echo "Stopping proxy"
      unset http_proxy
      unset https_proxy
      unset ftp_proxy
      unset ALL_PROXY
      echo "[DONE]"
    ;;
    "status")
      if [ -z "$ALL_PROXY" ]; then
        echo "Not running"
      else
        echo "[Running]"
        echo "Using proxy: $my_proxy"
      fi
    ;;
    *)
      echo "merckProxy (start|stop|status)"
    ;;
  esac
}

# Add rbenv to bash so that it loads every time you open a terminal, https://gorails.com/setup/osx/10.10-yosemite
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# Hydra - set development PGHOST to localhost
export PGHOST=localhost


# python virtual enviroment
export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# bash prompt, enable showing git brnach
# default PS1 = \h:\W \u\$
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


# have a coloful nice prompt
#export PS1="\h\[\033[32m\] \W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
#export PS1="\[$(tput bold)\]\[$(tput setaf 6)\]\u \[$(tput sgr0)\]\[$(tput setaf 5)\]\W\[$(tput setaf 3)\]\$(parse_git_branch) \[\033[00m\]$ "

function __prompt_command() {
    local EXIT="$?" # This needs to be first
    PS1=""

    local HOSTNAME='MAC' # you might want to put '\h' instead
    local USERNAME='\u'

    local ResetColor='\[\e[0m\]'

    local Red='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'
    local White='\[\e[0;37m\]'

    if [ $EXIT != 0 ]; then
        PS1+="${Red}${USERNAME}${ResetColor}" # Add red if exit code non 0
    else
        PS1+="${Gre}${USERNAME}${ResetColor}"
    fi

    function parse_git_dirty {
      [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo '*'
    }

    function parse_git_branch {
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
    }

    PS1+="${ResetColor}@${White}${HOSTNAME} ${Pur}\W${BYel}$(parse_git_branch) ${BYel}$ ${ResetColor}"
}

PROMPT_COMMAND=__prompt_command  # Func to gen PS1 after CMDs
