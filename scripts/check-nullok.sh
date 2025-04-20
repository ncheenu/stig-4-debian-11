#!/bin/bash

case $1 in
        auth)
		if [ -f "/etc/pam.d/common-auth" ];then
			COUNT=`grep pam_unix /etc/pam.d/common-auth  | grep -v "^#" | grep -c nullok`
			if [ "${COUNT}" -ge 1 ];then	
				exit 1
			fi
		fi
		;;

        password)
		if [ -f "/etc/pam.d/common-password" ];then
			COUNT=`grep pam_unix /etc/pam.d/common-password  | grep -v "^#" | grep -c nullok`
			if [ "${COUNT}" -ge 1 ];then	
				exit 1
			fi
		fi
		;;

        shadow)
		if [ -f "/etc/shadow" ];then
			COUNT=`awk -F: '!$2 {print $1}' /etc/shadow | wc -l`
			if [ "${COUNT}" -ge 1 ];then	
				exit 1
			fi
		fi
		;;
        dictcheck)
		if [ ! -f "/etc/security/pwquality.conf" ];then
            exit 1
		fi
        COUNT=$(grep '^[[:space:]]*dictcheck.*=.*1' /etc/security/pwquality.conf | wc -l)
		if [ "${COUNT}" -lt 1 ];then	
			exit 1
		fi
		;;
esac
