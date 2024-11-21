#!/bin/bash

setterm blank 0
setterm powerdown 0
sudo if ! mountpoint -q /tmp; then
 sudo mount -t tmpfs none /tmp
fi
sudo if ! mountpoint -q /run; then
 sudo mount -t tmpfs none /run
fi
/usr/bin/dbus-launch /usr/bin/i3 > /dev/null 2>&1
