#!/bin/bash

if [ "$(find /lib /usr/lib /lib64 ! -${2} root -type $1 -exec stat -c "%n %U" '{}' \; | wc -l)" -gt 0 ];then
        exit 1
fi
