#!/bin/bash

# the script must be run as root to create the mount point and mount the volume
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# get the /dev/disk# of the Apple_Xsan volume, ignoring all the LUNs (Apple_Xsan_Component)  
diskNumber=$(diskutil list | awk '/dev/ { disk=$1 } $0~/ Apple_Xsan / { print disk; exit}')
# get the Xsan volume name from the same source
diskName=$(diskutil list | awk '$0~/ Apple_Xsan / { print $3}')

# make the mount point in /Volumes for the volume name
mkdir /Volumes/"$diskName"
# mount the disk# to the mount point.  Be sure to add any additional options your volume requires
/System/Library/Filesystems/acfs.fs/Contents/bin/mount_acfs -o nofollow "$diskNumber" /Volumes/"$diskName"
