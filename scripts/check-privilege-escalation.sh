#!/bin/bash

set -x
case $1 in
        sudo)
                if grep -i "NOPASSWD" /etc/sudoers /etc/sudoers.d/* | sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' | grep -i "NOPASSWD";then
                        exit 1
                fi
                if grep -i '!authenticate' /etc/sudoers /etc/sudoers.d/* | sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' | grep -i '!authenticate';then
                        exit 1
                fi
        ;;
        authenticate)
                if grep -i '!authenticate' /etc/sudoers /etc/sudoers.d/* | sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' | grep -i '!authenticate';then
                        exit 1
                fi
        ;;
        sudoers)
		if [[ ! -z "$(grep ^sudo /etc/group | cut -d: -f4)" ]]; then
                        exit 1
                fi
        ;;
esac

