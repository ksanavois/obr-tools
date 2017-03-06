#!/bin/bash

# This is a graphical tool to change desktop activity settings in OBRevenge OS
#
# Written by Jody James for OBRevenge OS
#
#
# Greeting user and provding choices
#
main() {
yad --width=400 --title="$title" --window-icon=preferences-desktop --no-cancel --center --button=gtk-save:0 --text="This utility will assist you in making configuration changes to your desktop." --image="/usr/share/Icons/obr-logo-sm.png" --form --date-format="%-d %B %Y" --field="Number of Virtual Workspaces:":CB --field="Allow changing workspaces using the mouse wheel:":CB \
"1!2!3!4" "no!yes" > ~/.desktop.txt
sed -i -e 's/[|]/ /g' ~/.desktop.txt

choice=` cat ~/.desktop.txt | awk '{print $1;}' `
num="<number>${choice}</number>"
wheel=` cat ~/.desktop.txt | awk '{print $2;}' `
}

number() {
# getting current setting
currents=$(grep "<number>" ~/.config/openbox/rc.xml)
current=$(echo $currents)
# changing setting
wmctrl -n $choice
sed -i '/wmctrl/d' ~/.config/openbox/autostart
echo "wmctrl -n $choice &" >> ~/.config/openbox/autostart
}

wheel() {
if [ "$wheel" = "yes" ]
	then rm ~/.config/openbox/rc.xml;cp ~/.config/openbox/rc.xml_orig ~/.config/openbox/rc.xml;openbox --reconfigure
	else
	rm ~/.config/openbox/rc.xml;cp ~/.config/openbox/rc.xml_noscroll ~/.config/openbox/rc.xml;openbox --reconfigure 
fi
}

# copying config files to home directory
cp /etc/skel/.config/openbox/rc.xml_noscroll ~/.config/openbox/
cp /etc/skel/.config/openbox/rc.xml_orig ~/.config/openbox/
cp /etc/skel/.config/openbox/menu.xml_nitrogen ~/.config/openbox/
cp /etc/skel/.config/openbox/menu.xml_pcmanfm ~/.config/openbox/

main
number
wheel

rm ~/.desktop.txt


