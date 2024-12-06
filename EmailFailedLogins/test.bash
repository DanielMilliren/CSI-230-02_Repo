#!/bin/bash

echo "To: daniel.milliren@mymail.champlain.edu" > emailform.txt
echo "Subject: Security Incident" >> emailform.txt
echo "Test" >> emailform.txt
cat emailform.txt | ssmtp daniel.milliren@mymail.champlain.edu
