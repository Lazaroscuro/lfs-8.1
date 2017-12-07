#!/bin/bash
/sbin/swapoff -v /dev/sdb3
RET=$?

umount -v $LFS/boot
RET=$?
if [ $RET -ne 0 ]; then
	exit $RET
fi

umount -v $LFS
RET=$?
if [ $RET -ne 0 ]; then
	exit $RET
fi
