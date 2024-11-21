#!/bin/bash
setterm blank 0
setterm powerdown 0
export XDG_CURRENT_DESKTOP=GNOME
export XDG_SESSION_TYPE=x11
sudo if ! mountpoint -q /tmp; then
 sudo mount -t tmpfs none /tmp
fi
sudo if ! mountpoint -q /run; then
 sudo mount -t tmpfs none /run
fi
sudo service dbus start
/usr/bin/dbus-launch /usr/bin/gnome-shell --x11 -r > /dev/null 2>&1
