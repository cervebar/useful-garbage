
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_05/
export PATH=$PATH:/usr/lib/jvm/jdk1.8.0_05/bin
export PATH=$PATH:/home/babu/app/activator-1.2.3-minimal/activator

# Most of the time you don’t want to maintain two separate config files for login and non-login shells
# when you set a PATH, you want it to apply to both

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

if [ -f ~/.bash_aliases ]; then
   source ~/.bash_aliases
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

