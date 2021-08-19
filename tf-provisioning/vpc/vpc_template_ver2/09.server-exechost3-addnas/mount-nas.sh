#!/bin/bash

mkdir $MOUNTDIR
echo "MOUNT_POINT="$MOUNTDIR
echo "NAS_VOL="$NAS_VOL
mount -t nfs $NAS_VOL $MOUNTDIR

mkdir /mnt/backup
cp /etc/fstab /mnt/backup/fstab-backup

echo $NAS_VOL' '$MOUNTDIR' nfs defaults 0 0' >> /etc/fstab
echo "=== mount-nas.sh END ==="

