#!/bin/bash
for i_user in $(cat /etc/shadow | grep -v ^.*:[!*] |cut -d ":" -f1)
do
	if [ ! -d "$(grep ^${i_user}: /etc/passwd | awk -F: '{printf $6}')" ];then
		exit 1
	fi
done

