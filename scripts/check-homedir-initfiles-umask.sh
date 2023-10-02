#!/bin/bash

set -x
for i_user in $(cat /etc/shadow | grep -v ^.*:[!*] |cut -d ":" -f1)
do
	line=$(grep ^${i_user}: /etc/passwd | cut -d: -f6)
	if [ ! -e "${line}" ];then
		exit 1
	else	
		# if umask not set, return error
		UMASK_IS_SET=`grep -d skip -i umask /home/*/.* | grep -v ":#" | grep -v ".viminfo" | grep -v ".bash_history" | wc -l`
		if [ "${UMASK_IS_SET}" -eq 0 ];then
			# Check in /etc/profile
			if [ $(grep -v '^#' /etc/profile | grep umask.*077 | wc -l) -eq 0 ]; then
				exit 1
			fi
		else
			# umask set is to mode 700 or less permissive.
			COUNT=`grep -d skip -i umask /home/*/.* | grep -v ":#" | grep -v ".viminfo" | grep -v ".bash_history" | grep -v ".77" | wc -l`
			if [ "${COUNT}" -eq 0 ];then
				:
			else
				exit 1
			fi
		fi
	fi
done

