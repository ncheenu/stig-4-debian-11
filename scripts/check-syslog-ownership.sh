#!/bin/bash
case $1 in
    owner)
        if [[ "$(stat -c "%U" /var/log)" != "root" ]]; then
            exit 1
        fi
        ;;
    dir-permission)
        if [[ "$(stat -c "%a" /var/log)" != "755" ]]; then
            exit 1
        fi
        ;;
    gowner)
        if [[ "$(stat -c "%G" /var/log/syslog)" != "adm" ]]; then
            exit 1
        fi
        ;;
    permission)
        if [ $(find /var/log/syslog -type f \( -perm /0137 \) ! -perm 0640 | wc -l) -gt 0 ]; then
            exit 1
        fi
        ;;
esac
exit 0
