#!/bin/bash

if [ -e /etc/systemd/system/ctrl-alt-del.target ];then
        if ! ls -l /etc/systemd/system/ctrl-alt-del.target | grep "/dev/null";then
                exit 1
        fi
else
        exit 0
fi
