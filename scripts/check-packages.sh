#!/bin/bash

set -x
case $1 in
        telnetd)
                if dpkg -s telnetd ;then
                        exit 1
                fi
        ;;
        unattended-upgrades)
                if dpkg -s unattended-upgrades ;then
                        exit 1
                fi
        ;;
        timesyncd)
                if dpkg -s systemd-timesyncd ;then
                        exit 1
                fi
        ;;
        ntp)
                if dpkg -s ntp ;then
                        exit 1
                fi
        ;;
        rsyslog)
                if dpkg -s rsyslog ;then
                        exit 0
		else
			exit 1
                fi
        ;;
        audispd-plugins)
                if dpkg -s audispd-plugins ;then
                        exit 0
		else
			exit 1
                fi
        ;;
        auditd)
                if dpkg -s auditd ;then
                        exit 0
		else
			exit 1
                fi
        ;;
        chrony)
                if dpkg -s chrony ;then
                        exit 0
		else
			exit 1
                fi
        ;;
        apparmor)
                if dpkg -s apparmor ;then
                        exit 0
		else
			exit 1
                fi
        ;;
        2fa)
                if dpkg -s sssd ;then
                        exit 0
                elif dpkg -s libpam-google-authenticator ;then
			exit 0
		else
			exit 1
                fi
        ;;
        vlock)
                if dpkg -s vlock ;then
                        exit 0
		else
			exit 1
                fi
        ;;
        opensc)
                if dpkg -s opensc-pkcs11 ;then
                        exit 0
		else
			exit 1
                fi
        ;;
        pam-pkcs11)
                if dpkg -s libpam-pkcs11 ;then
                        exit 0
		else
			exit 1
                fi
        ;;
        pwquality)
                if dpkg -s libpam-pwquality ;then
                        exit 0
		else
			exit 1
                fi
        ;;
	firewall)
                if dpkg -s ufw || dpkg -s iptables; then
                        exit 0
		else
			exit 1
                fi
        ;;
        rsh-server)
                if dpkg -s rsh-server ;then
                        exit 1
                fi
        ;;
        ssh-server)
                if dpkg -s openssh-server ;then
                        exit 0
		else
			exit 1
                fi
        ;;
	vsftpd)
		if dpkg -s vsftpd ;then
                        exit 1
                fi
        ;;
        tftpd)
                if dpkg -s tftpd ;then
                        exit 1
                fi
        ;;
        x11-common)
                if dpkg -s x11-common ;then
                        exit 1
                fi
        ;;
        ypserv)
                if dpkg -s ypserv ;then
                        exit 1
                fi
        ;;
esac
