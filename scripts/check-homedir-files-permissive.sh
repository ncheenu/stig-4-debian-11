#!/bin/bash
set -x
for i_user in $(cat /etc/shadow | grep -v ^.*:[!*] |cut -d ":" -f1)
do
	line=$(grep ^${i_user}: /etc/passwd | cut -d: -f6)
	if [ ! -e "${line}" ];then
		exit 1
	else
		COUNT=`find "${line}" -type f  -perm  /027  -exec ls -l {} \; | wc -l`
		if [ "${COUNT}" -eq 0 ];then
			:
		else
			exit 1
		fi
	fi
done
