#!/bin/sh
mount -t proc proc /proc 2>/dev/null
mount -t sysfs sysfs /sys 2>/dev/null
echo "Yocto System Started!"
/sbin/getty -L ttyS0 115200 vt100 &
exec /bin/sh