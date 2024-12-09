#!/bin/bash

myIP=$(bash /home/champuser/CSI-230-02_Repo/BashIPs/get_ip.sh)


# Todo-1: Create a helpmenu function that prints help for the script


# Return ports that are serving to the network
function ExternalNmap(){
  rex=$( nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
  echo $rex
}

# Return ports that are serving to localhost
function InternalNmap(){
  rin=$( nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
  echo $rin
}


# Only IPv4 ports listening from network
function ExternalListeningPorts(){

# Todo-2: Complete the ExternalListeningPorts that will print the port and application
# that is listening on that port from network (using ss utility)
# Note: [::1] is the ipv6 loopback address.
# Also note that sed 's/Address PortProcess//g' is used to filter out some table headers.

	elpo_raw=$( ss -ltpn | sed 's/\[::1\]/127.0.0.1/g' \
	| sed 's/\[::/L/g' | awk  -F"[[:space:]:(),]+" '$4 !~ /127.0.0./ {print $5,$9}' | tr -d "\"" )
	elpo=$( echo $elpo_raw | sed 's/Address PortProcess//g' )
	echo $elpo

}


# Only IPv4 ports listening from localhost
function InternalListeningPorts(){
# Note: [::1] is the ipv6 loopback address.

	ilpo=$( ss -ltpn | sed 's/\[::1\]/127.0.0.1/g' \
	| sed 's/\[::/L/g' | awk  -F"[[:space:]:(),]+" '$4 ~ /127.0.0./ {print $5,$9}' | tr -d "\"" )
	echo $ilpo

}

function HelpMenu(){

	echo "   HELP MENU   "
	echo "==============="
	echo "-n : Use nmap for this scan."
	echo "  -n external : External nmap scan"
	echo "  -n internal : Internal nmap scan"
	echo "-s : Use ss for this scan."
	echo "  -s external : External ss(Netstat) scan"
	echo "  -s internal : Internal ss(Netstat) scan"
	echo "==============="
	echo "Usage: bash $0 -n/-s external/internal"

}

# Todo-3: If the program is not taking exactly 2 arguments, print helpmenu

# Todo-4: Use getopts to accept options -n and -s (both will have an argument)
# If the argument is not internal or external, call helpmenu
# If an option other then -n or -s is given, call helpmenu
# If the options and arguments are given correctly, call corresponding functions
# For instance: -n internal => will call NMAP on localhost
#               -s external => will call ss on network (non-local)

function ChooseNmap(){

	if [[ $mode == "external" ]]; then
		ExternalNmap
	elif [[ $mode == "internal" ]]; then
		InternalNmap
	else
		HelpMenu
		exit;
	fi
}

function ChooseSs(){

	if [[ $mode == "external" ]]; then
		ExternalListeningPorts
	elif [[ $mode == "internal" ]]; then
		InternalListeningPorts
	else
		HelpMenu
		exit;
	fi
}

if [[ ${#} -ne 2 ]]; then
	HelpMenu
	exit;
fi

mode="${2}"
while getopts "n:s:" option
do

	case $option in
	n)
		ChooseNmap
	;;
	s)
		ChooseSs
	;;
	?)
		HelpMenu
	esac

done
