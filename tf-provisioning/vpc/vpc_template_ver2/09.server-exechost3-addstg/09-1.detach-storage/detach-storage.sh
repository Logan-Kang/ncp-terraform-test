#!/bin/bash

umount $MOUNTDIR 
df -h
echo "=== umount Complete ==="

rm -rf /etc/fstab
cp /mnt/backup/fstab-backup /etc/fstab
echo "=== /etc/fstab edited ==="