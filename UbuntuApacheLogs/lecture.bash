#!bin/bash

function pageCount(){
cat "/var/log/apache2/access.log" |  cut -d' ' -f7 | grep -E "/" | sort | uniq -c 
}

pageCount
