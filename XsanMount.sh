#!/bin/bash

# the script must be run as root to create the mount point and mount the volume
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# get the Xsan volume names
volumeNames=$(diskutil list | awk '/ Apple_Xsan / { print $3 }')

# iterate over volumes
for name in $volumeNames; do
  # get the /dev/disk# of the Apple_Xsan volumes, ignoring all the LUNs (Apple_Xsan_Component)  
  number=$(diskutil list | awk "/ Apple_Xsan $name / { print \$6 }")
  # make the mount point in /Volumes for the volume name
  mkdir "/Volumes/$name"
  # mount the disk# to the mount point.  Be sure to add any additional options your volume requires
  /System/Library/Filesystems/acfs.fs/Contents/bin/mount_acfs -o nofollow "/dev/$number" "/Volumes/$name"
done
