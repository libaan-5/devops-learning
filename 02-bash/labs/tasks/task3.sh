#!/bin/bash

file_check() {

read -p "Enter a filename: " filename

if [ -f "$filename" ]; then
    if [ -w "$filename" ]; then
    echo "$filename is writeable"
    fi
    if [ -x "$filename" ]; then
    echo "$filename is executable" 
    fi
    if [ -r "$filename" ]; then
    echo "$filename is readable"
    fi
else 
    echo "The file doesn't exist."
fi

}

file_check
