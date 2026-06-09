#!/bin/bash

backup() {

timestamp=$(date +"Backup_%Y-%m-%d_%H-%M")

read -e -p "Enter a source directory: " source_dir

if [ ! -d /tmp/Backup ]; then
    mkdir /tmp/Backup
    echo "Backup directory created: $timestamp..."
fi

if [ ! -d "$source_dir" ]; then
    echo "Directory not found!"
else
    mkdir "/tmp/Backup/$timestamp"
    cp "$source_dir"/*.txt "/tmp/Backup/$timestamp"
    echo "Backup completed at: $timestamp! Files backed up: $(ls "/tmp/Backup/$timestamp" | wc -l)" 
fi
}

backup 