#!/bin/bash

setterm blank 0
setterm powerdown 0
sudo if ! mountpoint -q /tmp; then
 sudo mount -t tmpfs none /tmp
fi
sudo if ! mountpoint -q /run; then
 sudo mount -t tmpfs none /run
fi
dbus-launch /usr/bin/xfce4-session > /dev/null 2>&1
