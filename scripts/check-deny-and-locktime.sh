#!/bin/bash

bash scripts/check-password.sh /etc/pam.d/common-auth pam_faillock deny ge 3 > /dev/null 2>&1
CHECK_DENY=$?
bash scripts/check-password.sh /etc/pam.d/common-auth pam_faillock lock_time ge 900 > /dev/null 2>&1
CHECK_LOCKTIME=$?

if [ ${CHECK_DENY} -ne 0 -o ${CHECK_LOCKTIME} -ne 0 ];then
	exit 1
fi
exit 0
