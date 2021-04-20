#!/data/data/com.termux/files/usr/bin/bash
clear

Color_Off='\033[0m'
Red='\033[0;31m'
Green='\033[0;32m'
Cyan='\033[0;36m'

config="$PREFIX/etc/fish/config.fish"

clear

prerequisite() {
	{ echo; echo -e "${Green}Installing Dependencies..."${CYAN}; echo; }
	if [[ (-f $PREFIX/bin/fish) && (-f $PREFIX/bin/figlet) && (-f $PREFIX/bin/neofetch)]]; then
		{ echo "${Green}Dependencies are already Installed!"; }
	else
		{ pkg update -y; pkg install -y fish figlet neofetch -y; }
		(type -p fish figlet neofetch &> /dev/null) && { echo; echo "${Green}Dependencies are succesfully installed!"; } || { echo; echo "${Red}Error Occured, failed to install dependencies."; echo -e $Color_Off;  exit 1; }
	fi
}

prerequisite

set -U fish_greeting
clear

echo -e "function __fish_command_not_found_handler --on-event fish_command_not_found
	/data/data/com.termux/files/usr/libexec/termux/command-not-found $argv[1]
end
function cls
    clear
end
" > "$config"

echo -e $Red
figlet -f smslant "Termux Fish"
echo -e $Color_Off
printf '\n'
echo -e "${Green}[*]Clearing greeting text of termux..."
sleep 2s
[[( -f "$PREFIX/etc/motd")]] && rm "$PREFIX/etc/motd"
printf '\n'
echo -e $Cyan"*Cleared greeting text of termux*"
printf '\n'
if [[ (-f $PREFIX/etc/motd) ]]
then
	rm $PREFIX/etc/motd
fi
sleep 2s
echo -e $Green"[*]Adding neofetch to homepage..." $Red
printf '\n'
sleep 2s
while true; do
    read -p "Do you want the android logo in homepage?(y/n)" yn
    case $yn in
        [Yy]* ) echo "neofetch" >> "$config"; break;;
        [Nn]* ) echo "neofetch --off" >> "$config"; break;;
        * ) echo "Please answer yes(y) or no(n).";;
    esac
done
printf '\n'
sleep 2s
echo -e $Cyan"*Added neofetch to homepage*" $Green
printf '\n'
sleep 2s
echo -e "[*]Setting fish as the default shell..." $Cyan
printf '\n'
sleep 2s
chsh -s fish
echo -e "*Set fish as the default shell*"
sleep 2s
printf '\n'
printf  $Green"Done!\n\nNow restart termux.\n\n"
