#!/bin/bash
set -x
case $1 in
        Protocol)
                if [ "$(sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/ssh/sshd_config | grep -w "^Protocol" | awk '{print $2}')" -ne 2 ];then
                        exit 1
                fi
        ;;
        rhosts)
                if [ "$(sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/ssh/sshd_config | grep -i IgnoreRhosts | awk '{print $2}')" != "yes" ];then
                        exit 1
                fi
        ;;
        hostauth)
                if [ "$(sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/ssh/sshd_config | grep -i HostbasedAuthentication | awk '{print $2}')" != "no" ];then
                        exit 1
                fi
        ;;
        permitroot)
                if [ "$(sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/ssh/sshd_config | grep -i PermitRootLogin | awk '{print $2}')" != "no" ];then
                        exit 1
                fi
        ;;
        emptypassword)
                if [ "$(sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/ssh/sshd_config | grep -i PermitEmptyPasswords | awk '{print $2}')" != "no" ];then
                        exit 1
                fi
                if [ "$(sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/ssh/sshd_config | grep -i PermitUserEnvironment | awk '{print $2}')" != "no" ];then
                        exit 1
                fi
        ;;
        emptypasswordenvironment)
                if [ "$(sed -e '/^#/d' -e '/^[ \t][ \t]*#/d' -e 's/#.*$//' -e '/^$/d' /etc/ssh/sshd_config | grep -i PermitEmptyPasswords | awk '{print $2}')" != "no" ];then
                        exit 1
                fi
        ;;
	ciphers)
		if python3 scripts/check-member.py $(grep -i "^[[:space:]]*Ciphers" /etc/ssh/sshd_config | tr -s " " | cut -d " " -f2) aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes128-ctr,aes192-ctr; then
			:
		else
			exit 1 
		fi
	;;
	banner)
		if grep -i banner /etc/ssh/sshd_config | grep -v "^#";then
			:
		else
			exit 1
		fi
	;;
	installed)
		OPENSSH_SERVER=`dpkg -s openssh-server | grep -i "Status:.*install.*ok.*installed" | wc -l`
		OPENSSH_CLIENT=`dpkg -s openssh-client | grep -i "Status:.*install.*ok.*installed" | wc -l`
		if [ ${OPENSSH_SERVER} -eq 1 -a ${OPENSSH_CLIENT} -eq 1 ];then
			:
		else
			exit 1
		fi	
	;;
	sshd_status)
		if systemctl status sshd | grep "Active:.*(running)";then
			:
		else
			exit 1
		fi 
	;;
	ClientAliveInterval)
		if grep ClientAliveInterval /etc/ssh/sshd_config | grep -v "^#";then
			INTERVAL=`grep ClientAliveInterval /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
			if [ ${INTERVAL} -gt 600 ];then
				exit 1
			fi
		else
			exit 1
		fi
	;;
	RhostsRSAAuthentication)
		# RhostsRSAAuthentication option deprecated in latest SSH
		# Not applicable for Debian 11
		exit 0
		if grep RhostsRSAAuthentication /etc/ssh/sshd_config | grep -v "^#";then
			SETVALUE=`grep RhostsRSAAuthentication /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
			if [ "${SETVALUE}" == "yes" ];then
				exit 1
			fi
		else
			exit 1
		fi
	;;
	ClientAliveCountMax)
		if grep ClientAliveCountMax /etc/ssh/sshd_config | grep -v "^#";then
			SETVALUE=`grep ClientAliveCountMax /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
			if [ ${SETVALUE} -ne 1 ];then
				INTERVAL=`grep ClientAliveInterval /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
				TOTAL_INT=$(( ${SETVALUE} * ${INTERVAL} ))
				if [ ${TOTAL_INT} -gt 600 ]; then
					exit 1
				fi
				exit 0
			fi
		else
			exit 1
		fi
	;;
	IgnoreRhosts)
		if grep IgnoreRhosts /etc/ssh/sshd_config | grep -v "^#";then
			SETVALUE=`grep IgnoreRhosts /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
			if [ "${SETVALUE}" == "no" ];then
				exit 1
			fi
		else
			exit 1
		fi
	;;
	PrintLastLog)
		if grep PrintLastLog /etc/ssh/sshd_config | grep -v "^#";then
			SETVALUE=`grep PrintLastLog /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
			if [ "${SETVALUE}" != "yes" ];then
				exit 1
			fi
		else
			exit 1
		fi
	;;
	pam)
		if grep UsePAM /etc/ssh/sshd_config | grep -v "^#";then
			SETVALUE=`grep UsePAM /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
			if [ "${SETVALUE}" != "yes" ];then
				exit 1
			fi
		else
			exit 1
		fi
	;;
	IgnoreUserKnownHosts)
		if grep IgnoreUserKnownHosts /etc/ssh/sshd_config | grep -v "^#";then
			SETVALUE=`grep IgnoreUserKnownHosts /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
			if [ "${SETVALUE}" != "yes" ];then
				exit 1
			fi
		else
			exit 1
		fi
	;;
	macs)
		if python3 scripts/check-member.py $(grep -i "^[[:space:]]*Macs" /etc/ssh/sshd_config | tr -s " " | cut -d " " -f2) hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256; then
			:
		else
			exit 1
		fi
	;;
	kex)
		if python3 scripts/check-member.py $(grep -i "^[[:space:]]*KexAlgorithms" /etc/ssh/sshd_config | tr -s " " | cut -d " " -f2) ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group14-sha256; then
			:
		else
			exit 1
		fi
	;;
	pubkeypermissive)
		COUNT=`find /etc/ssh/ -type f -name "*.pub" -perm  /133  -exec ls -l {} \; | wc -l`
		if [ ${COUNT} -eq 0 ];then
			:
		else
			exit 1
		fi
	;;
	hostkeypermissive)
		COUNT=`find /etc/ssh/ -type f -name "*ssh_host*key" -perm  /177  -exec ls -l {} \; | wc -l`
		if [ ${COUNT} -eq 0 ];then
			:
		else
			exit 1
		fi
	;;
	GSSAPIAuthentication)
		if grep GSSAPIAuthentication /etc/ssh/sshd_config | grep -v "^#";then
                        SETVALUE=`grep GSSAPIAuthentication /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
                        if [ "${SETVALUE}" != "no" ];then
                                exit 1
                        fi
                else
                        exit 1
                fi
	;;
	KerberosAuthentication)
		if grep KerberosAuthentication /etc/ssh/sshd_config | grep -v "^#";then
                        SETVALUE=`grep KerberosAuthentication /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
                        if [ "${SETVALUE}" != "no" ];then
                                exit 1
                        fi
                else
                        exit 1
                fi
	;;
	StrictModes)
		if grep StrictModes /etc/ssh/sshd_config | grep -v "^#";then
                        SETVALUE=`grep StrictModes /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
                        if [ "${SETVALUE}" != "yes" ];then
                                exit 1
                        fi
                else
                        exit 1
                fi
	;;
	UsePrivilegeSeparation)
		# UsePrivilegeSeparation deprecated in Debian 11
		exit 0
		if grep UsePrivilegeSeparation /etc/ssh/sshd_config | grep -v "^#";then
                        SETVALUE=`grep UsePrivilegeSeparation /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
                        if [ "${SETVALUE}" != "yes" -a "${SETVALUE}" != "sandbox" ];then
                                exit 1
                        fi
                else
                        exit 1
                fi
	;;
	Compression)
		if grep Compression /etc/ssh/sshd_config | grep -v "^#";then
                        SETVALUE=`grep Compression /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
                        if [ "${SETVALUE}" != "no" -a "${SETVALUE}" != "delayed" ];then
                                exit 1
                        fi
                else
                        exit 1
                fi
	;;
	X11Forwarding)
		if grep X11Forwarding /etc/ssh/sshd_config | grep -v "^#";then
                        SETVALUE=`grep X11Forwarding /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
                        if [ "${SETVALUE}" != "no" ];then
                                exit 1
                        fi
                else
                        exit 1
                fi
        ;;
	X11UseLocalhost)
		if grep X11UseLocalhost /etc/ssh/sshd_config | grep -v "^#";then
                        SETVALUE=`grep X11UseLocalhost /etc/ssh/sshd_config | grep -v "^#" | awk '{printf $2}'`
                        if [ "${SETVALUE}" != "yes" ];then
                                exit 1
                        fi
                else
                        exit 1
                fi
        ;;
	enabled)
		if ! systemctl is-enabled ssh; then exit 1; fi
		if ! systemctl is-active ssh; then exit 1; fi
        ;;

esac
