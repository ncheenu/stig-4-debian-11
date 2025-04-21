#!/bin/bash


if [ "$(find /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin ! -${2} root -type $1 -exec stat -c "%n %U" '{}' \; | wc -l)" -gt 0 ];then
        exit 1
fi
