#!/data/data/com.termux/files/usr/bin/bash
clear

Color_Off='\033[0m'
Red='\033[0;31m'
Green='\033[0;32m'
Cyan='\033[0;36m'

bashrc="$PREFIX/etc/bash.bashrc"

echo -e "# Command history tweaks:
# - Append history instead of overwriting
#   when shell exits.
# - When using history substitution, do not
#   exec command immediately.
# - Do not save to history commands starting
#   with space.
# - Do not save duplicated commands.
shopt -s histappend
shopt -s histverify
export HISTCONTROL=ignoreboth

# Default command line prompt.
PROMPT_DIRTRIM=2
PS1='\[\e[0;32m\]\w\[\e[0m\] \[\e[0;97m\]\$\[\e[0m\] '

# Handles nonexistent commands.
# If user has entered command which invokes non-available
# utility, command-not-found will give a package suggestions.
if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
	command_not_found_handle() {
		/data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
	}
fi
" > "$bashrc"

echo -e $Green "Installing dependencies..." $Color_Off
pkg update -y && pkg upgrade -y
pkg install neofetch fish figlet -y
set -U fish_greeting
clear

echo -e $Red
figlet -f smslant "Termux Fish"
echo -e $Color_Off
printf '\n\n'
echo -e "${Green}Clearing greeting text of termux..."
echo "clear" >> "$bashrc"
echo -e $Cyan"*Cleared greeting text of termux"
printf '\n\n'
echo -e $Green"Adding neofetch to homepage..." $Red
while true; do
    read -p "Do you want the android logo in homepage?" yn
    case $yn in
        [Yy]* ) echo "neofetch" >> "$bashrc"; break;;
        [Nn]* ) echo "neofetch --off" >> "$bashrc"; break;;
        * ) echo "Please answer yes(y) or no(n).";;
    esac
done
printf '\n\n'
echo -e $Cyan"*Added neofetch to homepage" $Green
printf '\n\n'
echo -e "Adding fish to the homepage..." $Cyan
printf '\n\n'
echo "fish" >> "$bashrc"
echo -e "*Added fish to the homepage..."
printf '\n\n'
printf  $Green"Done!\nNow exit termux and enter again to see the magic!"
