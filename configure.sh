#!/bin/bash

TITLE="configure:"
CONFIGS_DIR=$(pwd)

FILES="bashrc conkyrc mplayer toprc vim vimrc Xdefaults xmonad gitconfig zshrc"
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
    read -p "Install $PROGRAMS (y/[n])" choice
    case "$choice" in
        y|Y)
            echo "$TITLE Installing $PROGRAMS"
            yaourt -S $PROGRAMS
            ;;
        *) ;;
    esac
fi
