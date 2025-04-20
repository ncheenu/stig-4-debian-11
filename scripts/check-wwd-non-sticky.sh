#!/bin/bash

if [ $(find / -type d -perm -002 ! -perm -1000 2>/dev/null| wc -l) -gt 0 ]; then
    exit 1
fi
exit 0
