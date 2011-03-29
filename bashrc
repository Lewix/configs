
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias pwfproxy='ssh -D 8080 -fN lab61@linux.pwf.cl.cam.ac.uk'
alias pwf='ssh lab61@linux.pwf.cl.cam.ac.uk'
alias srcf='ssh lab61@shell.srcf.ucam.org'

export PATH="$PATH:/home/lewis/.local/bin:/usr/local/sbin:/usr/lib/surfraw"
export CDPATH="/mnt/media/bookmarks"
export EDITOR="vim"
export PACMAN="pacman-color"
export TERM="rxvt-color"
export FOREGROUND_COLOR="#DDDDDD"
export URGENT_COLOR="#AE4747"
export FOCUSED_COLOR="#6F99B4"

eval `keychain --eval --agents ssh id_rsa`
