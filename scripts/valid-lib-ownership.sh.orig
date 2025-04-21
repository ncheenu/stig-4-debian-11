#!/bin/bash
set -x

if [ "$(find /lib /lib64 /usr/lib -perm /022 -type f -exec stat -c "%n %a" '{}' \; | wc -l)" -gt 0 ];then
	exit 1
fi

