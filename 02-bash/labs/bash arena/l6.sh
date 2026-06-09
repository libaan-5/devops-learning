#!/bin/bash

if [ -f "$1" ]; then
    wc -l < "$1" 
elif [-z "$1"]; then
    echo "File not provided."
    exit 1
elif [ ! -f "$1"]; then
    echo "File not found."
    exit 1
fi