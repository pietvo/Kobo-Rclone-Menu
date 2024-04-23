#!/bin/sh
MAINDIR=/mnt/onboard/.add/kobo-rclone-menu
Logs=${MAINDIR}
Lib=${MAINDIR}/Library
SD=/mnt/sd/kobo-rclone-menu
UserConfig=${MAINDIR}/kobo-rclonerc
RCloneConfig=${MAINDIR}/rclone.conf
MENUDIR=/mnt/onboard/.adds/nm
Dt="date +%Y-%m-%d_%H:%M:%S"
RCLONEDIR="${MAINDIR}/bin/"
RCLONE="${RCLONEDIR}rclone"
PLATFORM=Kobo
