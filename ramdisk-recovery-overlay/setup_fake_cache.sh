#!/bin/sh

DATA_MOUNT_CODE=1

if grep -qs '/data ' /proc/mounts; then
       echo "userdata already mounted" >> /dev/kmsgs
       DATA_MOUNT_CODE=0
else
       while [ "$DATA_MOUNT_CODE" != "0" ]; do
	       mount -t ext4 /dev/block/bootdevice/by-name/userdata /data 2> /dev/kmsgs
	       DATA_MOUNT_CODE=$?
	       sleep 1
       done
fi

mkdir /data/cache >> /dev/kmsg
mount -o bind /data/cache /cache >> /dev/kmsgs

setprop halium.datamount.done 1

exit 0
