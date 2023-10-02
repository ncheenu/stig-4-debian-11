#!/bin/bash
case $1 in
	showfailed)
		if  grep pam_lastlog /etc/pam.d/common-session | grep -v "^#";then
			INTERVAL=`grep pam_lastlog /etc/pam.d/common-session | grep -v "^#" | grep -c showfailed`
			if [ "${INTERVAL}" -ne 1 ];then
				exit 1
			fi
		else
			exit 1
		fi
	;;
esac
exit 0
