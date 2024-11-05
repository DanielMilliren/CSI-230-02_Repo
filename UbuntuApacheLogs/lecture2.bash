#!bin/bash

function countingCurlAccess(){
cat "/var/log/apache2/access.log" | cut -d' ' -f1,12 | grep -E '"curl/' | sort | uniq -c
}

countingCurlAccess
