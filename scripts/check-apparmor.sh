#!/bin/bash

case $1 in
        active)
		if systemctl is-active apparmor.service 2>/dev/null; then
			exit 0
		else
			exit 1
		fi
	;;
esac
