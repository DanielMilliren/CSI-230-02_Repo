#!bin/bash

ipaddr_text="$(ip addr | grep -o -E 'inet [0-9]{1,3}.[0-9]{1,3}.[0-9].{1,3}.[0-9]{1,3}/[0-9]{1,2} brd')"
ip_result="$(echo $ipaddr_text | grep -o -E '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}')"

echo $ip_result

