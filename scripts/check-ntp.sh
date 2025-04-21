#!/bin/bash
set -x
case $1 in 
	active)
		if systemctl is-enabled ntp || systemctl is-active ntp; then
			exit 0
		fi
		exit 1
	;;
	tinker)
		if ! grep tinker.*step /etc/ntp.conf; then
			exit 0
		fi
		exit 1
	;;
esac
