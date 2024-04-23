#!/bin/sh
MAINDIR=/tmp/Kobo-Rclone-Menu
Logs=${MAINDIR}
Lib=${MAINDIR}/Library
SD=${MAINDIR}/sd
UserConfig=${MAINDIR}/kobo-rclonerc
RCloneConfig=~/.config/rclone/rclone.conf
Dt="date +%Y-%m-%d_%H:%M:%S"
RCLONEDIR="/usr/bin/"
RCLONE="${RCLONEDIR}rclone"
PLATFORM=PC
