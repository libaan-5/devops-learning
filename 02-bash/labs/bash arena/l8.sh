#!/bin/bash


if [ -d "$2" ]; then
    grep -l "$1" "$2"/*.log

    if [ ! -d "$DIRECTORY" ]; then
    echo "Directory does not exist."
    exit 1
fi

# /var/log/auth.log
# dlopen