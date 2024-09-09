#!/bin/sh

#load config
. $(dirname $0)/config.sh

/usr/local/kobo-rclone-menu/get.sh > $Logs/get.log 2>&1
/usr/local/kobo-rclone-menu/add-log.sh get.log
