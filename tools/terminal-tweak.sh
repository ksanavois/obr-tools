#!/bin/bash

# This is a tool to change shells and allow command line tweaks
# Written by Jody James for OBRevenge OS
#
#
# Function for Changing Shells
#
title="OBRevenge OS Terminal Tweak Tool"
#
# Getting list of available shells and username
shells="/bin/bash!/bin/zsh!/bin/sh"
user=$USER

change_shell() {
gksu "chsh -s $shell $user" && zenity --info --height=40 --title="$title" --text "Success!!\nYour Shell has been sucessfully changed to $shell.\nThe change will take effect after logout."
}


main() {
yad --width=400 --title="$title" --window-icon=preferences-desktop --center --text="This Utility will assist you in changing default shells,\nand installing oh-my-zsh." --image="/usr/share/Icons/obr-logo-sm.png" --form --date-format="%-d %B %Y" --field="Would you like to change shells?":CB --field="Select the shell that you would like to use as default:":CB --field="Would you like to install oh-my-zsh?\nIf so, zsh must be selected as your default shell.":CB \
"no!yes" "$shells" "n/a!yes!no" > .term.txt
sed -i -e 's/[|]/ /g' .term.txt

if [ "$?" = "1" ]
	then exit
fi

change=` cat .term.txt | awk '{print $1;}' `
shell=` cat .term.txt | awk '{print $2;}' `
omz=` cat .term.txt | awk '{print $3;}' `

}

# Execution

main

if [ "$change" = "yes" ]
	then change_shell;main
fi

if [ "$omz" = "yes" ]
	then zshconfig.sh;main
fi

rm .term.txt

