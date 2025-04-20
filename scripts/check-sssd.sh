#!/bin/bash
case $1 in 
    ldap)
    if [ -f /etc/sssd/sssd.conf ]
    then
	    COUNT=$(grep -i '^ldap_user_certificate.*userCertificate' /etc/sssd/sssd.conf | wc -l)
	    if [ ! $COUNT -gt 0 ]
	    then
	        exit 1
	    fi
    fi
    ;;
    pam)
    if [ -f /etc/sssd/sssd.conf ]
    then
        COUNT=$(grep -A 1 '^\[sssd\]' /etc/sssd/sssd.conf | grep '^[[:space:]]*service.*pam' | wc -l)
	    if [ ! $COUNT -gt 0 ]
	    then
	        exit 1
	    fi
    fi
    ;;
    ca-trust)
    if [ -f /etc/pam_pkcs11/pam_pkcs11.conf ]
    then
        COUNT=$(grep use_pkcs11_module /etc/pam_pkcs11/pam_pkcs11.conf | awk '/pkcs11_module opensc {/,/}/' /etc/pam_pkcs11/pam_pkcs11.conf | grep cert_policy | grep ca | wc -l)
	    if [ ! $COUNT -gt 0 ]
	    then
	        exit 1
	    fi
    fi
    ;;
    ca-policy)
    if [ -f /etc/pam_pkcs11/pam_pkcs11.conf ]
    then
        COUNT=$(grep cert_policy /etc/pam_pkcs11/pam_pkcs11.conf | grep  -E -- 'crl_auto|crl_offline' | wc -l)
	    if [ ! $COUNT -gt 0 ]
	    then
	        exit 1
	    fi
    fi
    ;;
esac
