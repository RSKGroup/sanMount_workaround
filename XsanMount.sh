#!/bin/bash
diskNumber=$(diskutil list | awk '/dev/ { disk=$1 } $0~/ Apple_Xsan / { print disk; exit}')
diskName=$(diskutil list | awk '$0~/ Apple_Xsan / { print $3}')

mkdir /Volumes/"$diskName"
/System/Library/Filesystems/acfs.fs/Contents/bin/mount_acfs -o nofollow "$diskNumber" /Volumes/"$diskName"
