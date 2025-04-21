#!/bin/bash
set -x
case $1 in
	ciphers)
		if python3 scripts/check-member.py $(grep -i "^[[:space:]]*Ciphers" /etc/ssh/ssh_config | tr -s " " | cut -d " " -f2) aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes128-ctr,aes192-ctr; then
			:
		else
			exit 1 
		fi
	;;
	macs)
		if python3 scripts/check-member.py $(grep -i "^[[:space:]]*Macs" /etc/ssh/ssh_config | tr -s " " | cut -d " " -f2) hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256; then
			:
		else
			exit 1
		fi
	;;
	kex)
		if python3 scripts/check-member.py $(grep -i "^[[:space:]]*Macs" /etc/ssh/ssh_config | tr -s " " | cut -d " " -f2) hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256; then
			:
		else
			exit 1
		fi
	;;
esac
