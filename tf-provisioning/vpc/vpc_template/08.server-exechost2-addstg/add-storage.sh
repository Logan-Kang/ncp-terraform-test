#!/bin/bash

mkdir $MOUNTDIR
DIR='/dev/xvdb'
DIR2='/dev/xvdb1'
INPUT='/tmp/input'
echo "===Default Setting==="
echo "DIR="$DIR
echo "DIR2="$DIR2
echo "INPUT="$INPUT

rm -f $INPUT
echo 'n' >> $INPUT
echo 'p' >> $INPUT
echo '1' >> $INPUT
echo '' >> $INPUT
echo '' >> $INPUT
echo 't' >> $INPUT
echo '83' >> $INPUT
echo 'w' >> $INPUT

echo "===fdisk input==="
fdisk $DIR < $INPUT

mkfs.ext4 $DIR2
mount $DIR2 $MOUNTDIR

mkdir /mnt/backup
cp /etc/fstab /mnt/backup/fstab-backup

BLKID=$(blkid |grep $DIR2 |cut -d ' ' -f2)
echo $BLKID' '$MOUNTDIR' ext4 defaults 0 0' >> /etc/fstab
echo "=== add-storage.sh END ==="