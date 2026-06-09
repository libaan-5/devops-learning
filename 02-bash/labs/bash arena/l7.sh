#!/bin/bash

if [ ! -d "$1" ]; then
    echo "Directory not found!"
    exit 1
    
    elif [ -d "$1" ]; then
        stat -c "%s %n" "$1"/*.txt | sort -n 
    fi
fi
