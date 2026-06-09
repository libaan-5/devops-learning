#!/bin/bash

if [ ! -d Battlefield]; then
mkdir Battlefield 
touch Battlefield/knight.txt Battlefield/sorcerer.txt Battlefield/rogue.txt
fi


if [ -f Battlefield/knight.txt ]; then
mkdir Archive
mv Battlefield/knight.txt Archive
fi

ls Battlefield Archive