#!/bin/sh
ROOT=/tmp/Kobo-Rclone-Menu
MAINDIR=$ROOT
Logs=${MAINDIR}
Lib=${MAINDIR}/Library
SD=${MAINDIR}/sd
UserConfig=${MAINDIR}/kobo-rclonerc
RCloneConfig=~/.config/rclone/rclone.conf
Dt="date +%Y-%m-%d_%H:%M:%S"
RCLONEDIR="/usr/bin/"
RCLONE="${RCLONEDIR}rclone"
PLATFORM=PC
