#!/bin/bash

echo "What would you gonna wipe?\n
    [1]-Partition/FullDisk\n
    [2]-MBR\n"

echo "Showing available partitions\n"
sudo lsblk -fm

echo "Write the path that you gonna wipe e.g:sda :sda/sda1\n"
read path

STR="/dev/"
FullPath="$STR$path"

read modoBorrado

if [ "$modoBorrado" -eq 1 ];then
    echo "You have select Partition\n"
    echo "Filling with zeros...\n"
    sudo dd if=/dev/zero of=$FullPath bs=1M
    echo "Filling with random numbers\n"
    sudo dd if=/dev/urandom of=$FullPath bs=1M
    echo "Wiping data\n"
    sudo shred -vz -n 3 $FullPath
elif [ "$modoBorrado" -eq 2 ];then
    echo "Wiping Master Boot Recotd (MBR)"
    sudo dd if=/dev/zero of=$FullPath bs=446 count=1
else   
    echo "You must choose 1 or 2"
    exit 0
fi
