#!/bin/bash

TITLE="configure:"
CONFIGS_DIR=$(readlink -f $(dirname $0))

FILES="bashrc conkyrc mplayer toprc uzbl vim vimrc Xdefaults xmonad"
PROGRAMS="conky-cli xmonad rxvt-unicode ttf-droid"

# Create soft links
for file in $FILES
do
    system_file="$HOME/.$file"
    if [ -e $system_file ]
    then
        read -p "Overwrite $system_file (y/[n])" choice
        case "$choice" in
            y|Y) ;;
            *) continue;;
        esac
    fi
    echo "$TITLE Creating soft link for $file"
    ln -fs "$CONFIGS_DIR/$file" "$system_file"
done

# Install stuff
if [ $(uname -r | sed 's/.*ARCH/ARCH/') == 'ARCH' ]
then
    echo "$TITLE Installing $PROGRAMS"
    yaourt -S $PROGRAMS
fi
