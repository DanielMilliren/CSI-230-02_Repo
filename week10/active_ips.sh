#!/bin/bash

#Usage: bash active_ips.sh 10.0.17
[ $# -ne 1 ] && echo "Usage: $script <Prefix> " && exit 1

prefix=$1

[ ${#1} -le 5 ] && \
echo "Prefix is too short\nPrefix example: 10.0.17\n" && \
exit 1

for i in {0..255}
do
	ping -c 1 "$1.$i" | grep -E "[0-9]+ bytes from " | \
	grep -E -o "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
done
