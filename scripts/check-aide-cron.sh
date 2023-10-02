#!/bin/bash

if [ "$(grep -c aide /etc/crontab /etc/cron.*/* | grep -v :0$ | wc -l)" -ne 0 ];then
        exit 0
fi
