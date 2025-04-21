#!/bin/bash
set -x
if [ $(timedatectl status | grep -i "time zone.*utc" | wc -l) -lt 1 ]; then
    exit 1
fi
