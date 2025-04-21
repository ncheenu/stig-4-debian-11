#!/bin/bash
set -x

if [ "$(find /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin -perm /022 -type ${1} -exec stat -c "%n %a" '{}' \; | wc -l)" -gt 0 ];then
	exit 1
fi

