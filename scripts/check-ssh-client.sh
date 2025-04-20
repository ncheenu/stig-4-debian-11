#!/bin/bash
case $1 in
	ciphers)
		if grep -i "^[[:space:]]*Ciphers aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes128-ctr" /etc/ssh/ssh_config; then
			:
		else
			exit 1 
		fi
	;;
	macs)
		if grep -i "^[[:space::]]*MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256"  /etc/ssh/ssh_config;then
			:
		else
			exit 1
		fi
	;;
	kex)
		if grep -i "^[[:space::]]*KexAlgorithms ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group14-sha256$"  /etc/ssh/ssh_config;then
			:
		else
			exit 1
		fi
	;;
esac
