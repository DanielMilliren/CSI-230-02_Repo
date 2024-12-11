#!/bin/bash

report=$(cat report.txt)
report_lc=$(wc -l report.txt | cut -d' ' -f1)

echo "<html>">report.html
echo "<head>">>report.html
echo "	<title>IOC Report</title>">>report.html
echo "	<style>">>report.html
echo "		table, th, td {">>report.html
echo "			border: 1px solid black;">>report.html
echo "		}">>report.html
echo "	</style>">>report.html
echo "</head>">>report.html
echo "<body>">>report.html
echo "	Access logs with indicators of compromise:<br></br>">>report.html
echo "	<table>">>report.html

for (( i=1; i<=$report_lc; i++ )); do

	line=$(echo "$report" | head -n $i | tail -n 1)

	if [[ $line != "" ]]; then
		echo "		<tr>">>report.html
		term1=$(echo $line | cut -d' ' -f1)
		term2=$(echo $line | cut -d' ' -f2)
		term3=$(echo $line | cut -d' ' -f3)
		echo "			<td>$term1</td>">>report.html
		echo "			<td>$term2</td>">>report.html
		echo "			<td>$term3</td>">>report.html
		echo "		</tr>">>report.html
	fi

done

echo "	</table>">>report.html
echo "</body>">>report.html
echo "</html>">>report.html

mv report.html /var/www/html
