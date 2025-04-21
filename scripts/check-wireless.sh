#!/bin/bash
set -x
if [ $(find /sys/class/net -name wireless | wc -l) -eq 0 ]; then
	exit 0
fi
exit 1
