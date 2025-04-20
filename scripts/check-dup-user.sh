#!/bin/bash
if [ $(awk -F ":" 'list[$3]++{print $1, $3}' /etc/passwd |wc -l) -gt 0 ]; then
    exit 1
fi
