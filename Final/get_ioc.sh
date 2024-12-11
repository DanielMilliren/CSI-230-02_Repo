#!/bin/bash

#This is to get the IOCs from 10.0.17.11 (since I'm hosting the file on my own VM)

rawtablecontents=$(curl -sL 'http://10.0.17.11/IOC-1.html' | xmlstarlet sel -t -c 'html/body/table/tr')

rawcontents_no_headers=$(echo $rawtablecontents | sed 's/<th>[^<]*<\/th>//g' | sed -e 's/<tr>[^<]*<\/tr>//g')

echo $rawcontents_no_headers | sed 's/<\/td>//g' | sed 's/<td>[^<]*<\/tr>//g' \
| sed 's/<td>/\n/g' | sed 's/<tr>//g' | grep "[^[:space:]]" > ioc.txt
