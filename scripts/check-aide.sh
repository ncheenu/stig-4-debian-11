#!/bin/bash

ISINSTALLED=$(dpkg -s aide |  grep -ci "Status:.*install.*ok.*installed")
if [ "${ISINSTALLED}" -eq 0 ];then
	exit 1
fi

case $1 in
	installed)
		exit 0
	;;

	silent)
		if ! grep '^[[:space:]]*SILENT' /etc/default/aide; then
			exit 1
		fi
	;;

	check)
		if [ $(dpkg --verify aide-common | grep "^..5" | awk '$2 != "c" { print $NF }' | xargs -I XXX bash -c "[ -f \"XXX\" ] && echo \"XXX\"" | wc -l) -gt 0 ];then
			exit 1
		fi
		if ! aide -c /etc/aide/aide.conf --check; then
			exit 1
		fi
	;;

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

    audit)
        if [ $(grep -Eh '(\/sbin\/(audit|au))' /etc/aide/aide.conf.d/* | wc -l) -lt 1 ]; then
            exit 1
        fi
    ;;
esac
