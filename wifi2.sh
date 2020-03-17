#!/bin/bash
reset=`tput sgr0`
red="\033[0;31m"
yellow=`tput setaf 3`
Yellow="\033[0;33m"
Blue="\033[0;34m"
Purple="\033[0;35m"
Cyan="\033[0;36m"
White="\033[0;37m"
clear #ssss
echo -e "${White} Scanning Wifi networks, please wait....${reset}"
airport -s > out.log
#awk  'NR==1 { print $0}' out.log | column -t
awk -v white="$White" 'NR==1 {print white $0}' out.log | column -t
#echo -e "\n"
#awk -v cyan="$Cyan" 'NR>=2 { print cyan $0}' out.log | column -t
awk  -v red="$red"  -v yellow="$Yellow" -v cyan="$Cyan" -v purple="$Purple" -F" "  'NR>=2 {print cyan NR-1 " " red $1 " " yellow $2 " " cyan 10**((27.55-(20*(log(2412)/log(10)))-($3))/20) " "$3" " purple $4 " " red $5 " " $6 " " "\033[0m" $7 " " $8 }' out.log | column -t 
#echo -e "\n"
printf 'Enter Wifi number: '
read -r opt
echo -e "\n"
i=$(( opt + 1))
network=`awk -v line="$i" 'NR==line { print $1 }' out.log`
mac=`awk -v line="$i" 'NR==line { print $2 }' out.log`
enc=`awk -v line="$i" 'NR==line { print $7 }' out.log`
signal=`awk -v line="$i" 'NR==line { print $3 }' out.log`
echo -e "Network     :${Cyan} $network ${reset}\n"
echo -e "Mac Address :${Cyan} $mac ${reset}\n"
echo -e "Signal      :${Cyan} $signal ${reset}\n"
echo -e "Encryption  :${Cyan} $enc ${reset}\n"
echo -en   "${yellow}Enter your Wifi password: ${reset}" ; read -s pass
echo -e "\n"
echo -e "${Cyan}Connecting to Network ${reset}${yellow}$network${reset} please wait...${reset}"
networksetup -setairportnetwork en1 $network $pass
state=`airport -I | grep 'state' |awk -F":" '{print $2}'`
if [ $state = "running" ]; then
	echo -e "${Purple}Connected!${reset}"
	echo -e "State: ${yellow}$state${reset}"
else
	echo "Something went wrong, not connected yet!!"
fi
echo -e "\n"






