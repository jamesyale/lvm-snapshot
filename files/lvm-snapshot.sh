#!/bin/bash

# Create / remove / mount / umount LVM snapshots in a simplistic manner

command=$1
lv=$3
vg=$2

snapsize='50G'
mount="/mnt/$lv-snapshot"
snapdev="/dev/$vg/snap_$lv"

create="/sbin/lvcreate -L$snapsize -s -n snap_$lv /dev/$vg/$lv"

case $command in
	create )
		echo $create ; $create ;;
	remove )
		/sbin/lvremove -f $snapdev ;;
	mount )
		/bin/mount $snapdev $mount ;;
	umount )
		/bin/umount $mount ;;
esac
