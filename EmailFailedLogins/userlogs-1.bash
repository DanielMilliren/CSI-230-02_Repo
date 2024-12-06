#!/bin/bash

authfile="/var/log/auth.log"

function getLogins(){
	logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
	dateAndUser=$(echo "$logline" | cut -d' ' -f1,3,12 | tr -d '\.')
	echo "$dateAndUser"
}

function getFailedLogins(){
# Todo - 1
# a) Make a little research and experimentation to complete the function
# b) Generate failed logins and test

#Note: /var/log/auth.log has a double space between the month and day. cut -d' ' -f2 therefore
#Doesn't get the 2nd term, but instead gets an empty space.

	contents=$(cat "$authfile" | grep 'authentication failure')
	#echo $contents

	fails=$(echo "$contents" | cut -d' ' -f1,3,17 | sed 's/user=//g')

	echo $fails

}

#getFailedLogins

function sendFailedLogins(){
# Sending logins as email

	echo "To: daniel.milliren@mymail.champlain.edu" > emailform.txt
	echo "Subject: Failed Logins" >> emailform.txt
	getFailedLogins >> emailform.txt
	cat emailform.txt | ssmtp daniel.milliren@mymail.champlain.edu

}

sendFailedLogins
