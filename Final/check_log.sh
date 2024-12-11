#!/bin/bash

function helpMenu(){

echo "Usage: bash $0 <log_file> <ioc_file>"
exit;

}

if [[ ${#} != 2 ]]; then helpMenu; fi


log_content=$(cat $1)
ioc_content=$(cat $2)

log_lc=$(wc -l "$1" | cut -d' ' -f1)
ioc_lc=$(wc -l "$2" | cut -d' ' -f1)

echo "" > report.txt

for (( i=1; i<=$log_lc; i++ ))
do

	log_line=$(echo "$log_content" | head -n $i | tail -n 1)

	for (( j=1; j<=$ioc_lc; j++ ))
	do

		ioc_line=$(echo "$ioc_content" | head -n $j | tail -n 1)

		line=$(echo $log_line | grep -e $ioc_line)

		if [[ $line != "" ]]; then

			outputline=$(echo $line | cut -d' ' -f1,4,7 | sed 's/\[//g')

			echo $outputline >> report.txt

		fi
	done
done
