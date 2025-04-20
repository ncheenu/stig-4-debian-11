#!/bin/bash
if systemctl is-active kdump.servie; then
    exit 1
fi
exit 0
