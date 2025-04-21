#!/bin/bash
set -x
if systemctl is-enabled $1 && systemctl is-active $1; then
	exit 0
fi
exit 1
