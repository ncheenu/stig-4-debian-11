#!/bin/bash

ISINSTALLED=$(dpkg -s aide |  grep -ci "Status:.*install.*ok.*installed")
if [ "${ISINSTALLED}" -eq 0 ];then
	exit 1
fi

case $1 in
        acl)
		if [ "$(grep -v "^#" /etc/aide/aide.conf  | grep -c acl)" -eq 0 ];then
			if [ ! -d /etc/aide/aide.conf.d ] || \
				[ "$(grep -v "^#" /etc/aide/aide.conf.d/99_aide_root  | grep -c acl)" -eq 0 ];then
				exit 1
			fi
		fi
        ;;
        sha512)
		if [ "$(grep -v "^#" /etc/aide/aide.conf  | grep -c sha512)" -eq 0 ];then
			exit 1
		fi
        ;;
esac
