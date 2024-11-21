#!/bin/bash

setterm blank 0
setterm powerdown 0

dbus-launch /usr/bin/xfce4-session > /dev/null 2>&1
