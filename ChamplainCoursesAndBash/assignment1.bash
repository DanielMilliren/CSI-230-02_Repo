#!/bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas

function displayCoursesofLoc(){

echo -n "Please Input a Location (such as JOYC 310): "
read locName

echo ""
echo "Courses of $locName :"
cat "$courseFile" | grep "$locName" | cut -d';' -f1,2,5,6,7 | \
sed 's/;/ | /g'
echo ""

}

# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas

function displayAvailableSections(){

echo -n "Please Input a Course Code: "
read courseCode

echo ""
echo "Available Courses for $courseCode :"

# Note that (seq 2 $linecount) is used because line 1 is the table headers
linecount="$(wc -l $courseFile | cut -d' ' -f1)"
indexlist=$(seq 2 $linecount)

for i in $indexlist
do
	line="$(cat $courseFile | head -n $i | tail -n 1)"
	linecode="$(echo $line | cut -d';' -f1)"
	seats="$(echo $line | cut -d';' -f4)"
	if [[ $(($seats)) > 0 ]] && [[ $(echo "$linecode" | grep "$courseCode") ]]
	then
		echo $line | sed 's/;/ | /g'
	fi
done
echo ""

}


while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses of a location"
	echo "[4] Display available sections for a course code"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		displayCoursesofLoc

	elif [[ "$userInput" == "4" ]]; then
		displayAvailableSections

	else
		echo "Please input a number from 1 to 5 (without any square brackets)"
		echo ""

	fi
done
