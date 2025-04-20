#!/bin/bash
case $1 in
    pwlock)
        if passwd -S root | cut -d " " -f2 | grep L; then
            exit 0
        fi
        exit 1
    ;;
esac
