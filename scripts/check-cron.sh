#!/bin/bash

case $1 in
	allowfileown)
		if [ -e /etc/cron.allow ];then
			if [ "$(stat -c "%G" /etc/cron.allow)" != "root" ];then
				exit 1
			fi
		fi
	;;
	allowfilegown)
		if [ -e /etc/cron.allow ];then
			if [ "$(stat -c "%U" /etc/cron.allow)" != "root" ];then
			exit 1
			fi
		fi
	;;
	cronlog)
		conf_file=$(grep "^cron\.\*" /etc/rsyslog.conf /etc/rsyslog.d/*.conf | head -1 | cut -d ":" -f1)
		if [ -z "${conf_file}" ]
		then
			exit 1
		fi
		if grep "^cron\.\*" ${conf_file};then
			LINE1=`grep "^cron\.\*" ${conf_file} -n | awk -F : '{print $1}'`
			if grep "^\*\.\*.*~" ${conf_file};then
				LINE2=`grep "^\*\.\*.*~" ${conf_file}  -n | awk -F : '{print $1}'`
				if [ "${LINE1}" -gt "${LINE2}" ];then
					exit 1
				fi
			fi
		else
			exit 1
		fi
		
	;;
esac
