#!/bin/bash

# List all IPs in the network prefix
# /24 only

# usage: bash iplist_1.sh 10.0.17
[ $# -ne 1 ] && echo "Usage: $script <Prefix>" && exit 1

#Prefix is the first input taken
prefix=$1

#Verify input length
[ ${#1} -le 5 ] && \
echo "Prefix length is too short\nPrefix example: 10.0.17\n" && \
exit 1

for i in {0..255}
do

	echo "$1.$i"

done
