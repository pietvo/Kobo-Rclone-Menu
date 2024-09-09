#!/bin/sh
ROOT=/mnt/onboard
MAINDIR=$ROOT/.add/kobo-rclone-menu
Logs=${MAINDIR}
Lib=${MAINDIR}/Library
SD=/mnt/sd/kobo-rclone-menu
UserConfig=${MAINDIR}/kobo-rclonerc
RCloneConfig=${MAINDIR}/rclone.conf
MENUDIR=$ROOT/.adds/nm
Dt="date +%Y-%m-%d_%H:%M:%S"
RCLONEDIR="${MAINDIR}/bin/"
RCLONE="${RCLONEDIR}rclone"
PLATFORM=Kobo
