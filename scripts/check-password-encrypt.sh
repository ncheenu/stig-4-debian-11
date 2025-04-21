#!/bin/bash
set -x
if ! grep '^[[:space:]]*ENCRYPT_METHOD.*SHA512' /etc/login.defs; then
    exit 1
fi
