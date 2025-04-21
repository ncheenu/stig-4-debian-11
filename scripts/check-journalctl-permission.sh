#!/bin/bash
set -x
case $1 in
	bin)
		set -x
		if [ $(find /usr/bin/journalctl -exec stat -c "%n %a" {} \; | grep 740 | wc -l) -lt 1 ]; then
			exit 1
		fi
	;;
	log)
		set -x
		if [ $(find /run/log/journal /var/log/journal -perm /137 -type f| wc -l) -ge 1 ]; then
			exit 1
		fi
	;;
esac
exit 0
