#!/bin/bash
if [ $(find /usr/bin/journalctl -exec stat -c "%n %${1}" {} \; | grep -v root | wc -l ) -gt 0 ]; then
    exit 1
fi
exit 0
