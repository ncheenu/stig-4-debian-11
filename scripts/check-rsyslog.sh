#!/bin/bash
set -x

case $1 in
	aggregation-server)
		COUNT=$(cat /etc/rsyslog.conf /etc/rsyslog.d/* | grep -c "^\*\.\*.*@")
		if [ "${COUNT}" -eq 1 ]; then 
			exit 0
		else
			exit 1
		fi
	;;
	imtcp)
		if grep imtcp /etc/rsyslog.conf  | grep -v "^#";then
			exit 1
		fi
	;;
	authlog)
		if ! grep -hrE 'auth|authpriv|daemon' /etc/rsyslog.conf | grep -v "^#"; then
			exit 1
		fi
	;;
esac
