
# Check for an interactive session
[ -z "$PS1" ] && return


### Aliases ###

alias ls='ls --color=auto'
alias pwfproxy='ssh -D 8080 -fN lab61@linux.pwf.cl.cam.ac.uk'
alias pwf='ssh lab61@linux.pwf.cl.cam.ac.uk'
alias srcf='ssh lab61@shell.srcf.ucam.org'

eval `keychain --eval --agents ssh id_rsa &> /dev/null`

### Environment variables ###

export PATH="$PATH:/home/lewis/.local/bin:/usr/local/sbin:/usr/lib/surfraw:/usr/share/eclipse"
export CDPATH="/mnt/media/bookmarks"
export HISTCONTROL=ignoredups:ignorespace

# Programs
export EDITOR="vim"
export PACMAN="pacman-color"
export TERM="rxvt-256color"

# Cursor
echo -ne "\033]12;#6f99b4\007"
# Prompt
title_bar()
{
  case "$BASH_COMMAND" in
    *\033]0*)
      ;;
    *)
      echo -ne "\033]0;$BASH_COMMAND\007"
      ;;
  esac
}
trap title_bar DEBUG
export PS1='[\[\e[0;34m\]\u@\h\[\e[m\] \W]\$ '
export PS2='\[\e[0;31m\]>\[\e[m\] '
