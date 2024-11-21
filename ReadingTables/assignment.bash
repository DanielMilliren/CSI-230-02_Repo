#!/bin/bash

htmldoc="$(curl -sL http://10.0.17.30/Assignment.html)"

# Use XML Starlet to parse the doc
table_temp=$(echo $htmldoc | xmlstarlet format --html --recover 2>/dev/null | \
	xmlstarlet sel -t -v "//table[@id='temp']//tr//td" | \
	awk 'NR % 2 == 1')
table_press=$(echo $htmldoc | xmlstarlet format --html --recover 2>/dev/null | \
	xmlstarlet sel -t -v "//table[@id='press']//tr//td" | \
	awk 'NR % 2 == 1')
table_date=$(echo $htmldoc | xmlstarlet format --html --recover 2>/dev/null | \
	xmlstarlet sel -t -v "//table[@id='temp']//tr//td" | \
	awk 'NR % 2 != 1')


count=$(echo "$table_temp" | wc -l)
for (( i=1; i<="${count}"; i++ ))
do

	temp=$(echo "$table_temp" | head -n $i | tail -n 1)
	press=$(echo "$table_press" | head -n $i | tail -n 1)
	date=$(echo "$table_date" | head -n $i | tail -n 1)

	echo "$temp $press $date"

done
