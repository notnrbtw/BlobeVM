#!/bin/bash

setterm blank 0
setterm powerdown 0

if ! mountpoint -q /tmp; then
    sudo mount -t tmpfs none /tmp
fi

if ! mountpoint -q /run; then
    sudo mount -t tmpfs none /run
fi

sudo chmod +x /install-kde6.sh
/usr/bin/dbus-launch /usr/bin/startplasma-x11 > /dev/null 2>&1
