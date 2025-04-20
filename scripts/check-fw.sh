#!/bin/bash

case $1 in
        status)
		# Either UFW has to run
                if dpkg -s ufw > /dev/null && systemctl is-active ufw > /dev/null ; then
                        exit 0
                fi
		# Or iptables has to be configured
                if dpkg -s iptables > /dev/null && iptables-save | grep '^-A' > /dev/null; then
                        exit 0
                fi
        ;;
esac
exit 1
