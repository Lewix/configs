
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias cd='pushd'
PS1='[\u@\h \W]\$ '
alias bluephone='sudo obexfs -b 38:E7:D8:C3:42:B6 /media/telephone/'
alias pacmanc='pacman-color'
alias dnitrogen='nitrogen /mnt/media/Pictures/wallpapers/'
alias dscrot='scrot -cd 5 /mnt/media/Pictures/screen.jpg'
alias music='sudo /mnt/media/Dropbox/Scripts/Linux/mpd.sh'
alias pwfproxy='ssh -D 8080 -fN lab61@linux.pwf.cam.ac.uk'
alias pwf='ssh lab61@linux.pwf.cl.cam.ac.uk'
alias srcf='ssh lab61@shell.srcf.ucam.org'
export PATH="$PATH:/home/lewis/.local/bin:/usr/local/sbin:/usr/lib/surfraw"
export EDITOR="vim"
export PACMAN="pacman-color"
export FOREGROUND_COLOR="#DDDDDD"
export URGENT_COLOR="#AE4747"
export FOCUSED_COLOR="#6F99B4"
