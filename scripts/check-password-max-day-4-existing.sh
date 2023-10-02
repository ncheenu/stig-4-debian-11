#!/bin/bash

PASSWDMAXDAYS=$1

COUNT_SUM=`cat /etc/shadow | grep -v ^.*:[!*] | awk -F: '$5 >'\"${PASSWDMAXDAYS}\"'{print $1}' | wc -l`

if [ "${COUNT_SUM}" -gt 0 ];then
	exit 1
fi

