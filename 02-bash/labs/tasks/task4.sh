#!/bin/bash

backup() {

read -p "Enter a source directory: " source_dir
mkdir /tmp/Backup

if [ -d source_dir ]; then
    if [ ! -d /tmp/Backup ]; then
        mkdir /tmp/Backup
    fi

    cp source_dir/*.txt /tmp/Backup
    echo "Backup complete! Files backed up $(ls | wc -l)" 

}

backup 