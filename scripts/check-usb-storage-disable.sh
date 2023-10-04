#!/bin/bash
set -x
COUNT=`grep -ic "install.*usb-storage.*/bin/true" /etc/modprobe.d/* | grep -v :0$ | wc -l`

if [ "${COUNT}" -lt 1 ];then 
	exit 1
fi


