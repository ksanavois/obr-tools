#!/bin/bash
title="oh-my-zsh installer"
shell=$(echo $SHELL)
if [ "$shell" = "/bin/bash" ]
then zenity --error --text "zsh is not your default shell";exit
else ohmyzsh=$(zenity --list --title="$title" --height=70 --text  "Oh-my-zsh is a configuration for the Z shell, including the option for many themes, plugins, etc.\n\nWould you like to install oh-my-zsh" --radiolist --column "Select" --column "Options" FALSE yes FALSE no)
fi
if [ "$ohmyzsh" = "no" ]
then exit
fi
if (pacman -Q grml-zsh-config > /dev/null)
	then zenity rtpasswd=$(zenity --entry --title="$title" --text "Please enter your password." --hide-text)
	echo $rtpasswd | sudo pacman -R --noconfirm grml-zsh-config
fi

if [ "$ohmyzsh" = "yes" ]
then 
echo "# Installing oh-my-zsh..." 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
zenity --info --text "The process is complete, please exit"
fi
exit=$(zenity --list --title= "$title" --radiolist --column "Select" --column "Options" "open zsh config file" FALSE "exit" )
if [ "$exit" = "open zsh config file" ]
 then leafpad $HOME/.zshrc
else exit
fi









