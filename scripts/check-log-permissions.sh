#!/bin/bash
set -x
if [ $(find /var/log -perm /137 ! -name '*[bw]tmp' ! -name '*lastlog' -type f -exec stat -c "%n %a" {} \; | wc -l) -gt 0 ]; then
    exit 1
fi
