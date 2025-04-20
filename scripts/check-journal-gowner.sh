#!/bin/bash
if [ $(find /run/log/journal /var/log/journal  -type ${1} -exec stat -c "%n %${2}" {} \; | grep -v ${3} | wc -l) -gt 0 ]; then
    exit 1
fi
exit 0
