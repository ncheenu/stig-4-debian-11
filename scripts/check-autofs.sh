#!/bin/bash
set -x

if systemctl status autofs | grep "Active:.*(running)";then
	exit 1  
fi

