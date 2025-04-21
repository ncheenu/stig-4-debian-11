#!/usr/bin/python3
import sys

from_list=sys.argv[1].split(',')
check_list=sys.argv[2].split(',')

for k in from_list:
    if k not in check_list:
        print(f"Item {k} not in check list {check_list}")
        exit(1)

exit(0)
