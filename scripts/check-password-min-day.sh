#!/bin/bash

if [ `cat /etc/shadow | grep -v ^.*:[!*] | awk -F: '$4 < 1 {print $1}' | wc -l` -gt 0 ];then
	exit 1
fi
