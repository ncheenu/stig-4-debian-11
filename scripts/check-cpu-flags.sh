#!/bin/bash
if [ $(grep flags /proc/cpuinfo | grep -w ${1} | sort -u | wc -l) -gt 0 ]; then
    exit 0
fi
exit 1
