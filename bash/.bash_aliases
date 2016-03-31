alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '

# ls aliases ====================================================
# ubuntu
LS_COLORS=$LS_COLORS:'di=1;32:'; export LS_COLORS
# mac
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

alias ll='ls -alF'
alias la='ls -GFlash'
alias l='ls -CF'
alias ls="ls -G"

#make GREP color output
export GREP_COLOR='1;35;40'
alias grep="grep --color=auto"

alias untar="tar -zxvf"

# appliactions
alias eclipse="nohup ECLIPSE_PATH >/dev/null 2>&1 &"
alias chrome="nohup CHOME_PATH >/dev/null 2>&1 &"
