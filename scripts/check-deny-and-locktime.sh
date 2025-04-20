#!/bin/bash

bash scripts/check-password-flags.sh /etc/pam.d/common-auth pam_faillock deny ge 3 > /dev/null 2>&1
CHECK_AUDIT=$?
bash scripts/check-password.sh /etc/pam.d/common-auth pam_faillock deny ge 3 > /dev/null 2>&1
CHECK_DENY=$?
bash scripts/check-password.sh /etc/pam.d/common-auth pam_faillock unlock_time ge 900 > /dev/null 2>&1
CHECK_LOCKTIME=$?
bash scripts/check-password.sh /etc/pam.d/common-auth pam_faillock fail_interval eq 900 > /dev/null 2>&1
CHECK_FAIL_INTERVAL=$?

if [ ${CHECK_DENY} -ne 0 -o ${CHECK_LOCKTIME} -ne 0 -o ${CHECK_AUDIT} -ne 0 -o ${CHECK_FAIL_INTERVAL} -ne 0 ];then
	exit 1
fi
exit 0
