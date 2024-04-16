#!/bin/sh

# Uninstall kobo-rclone-menu

#load config
. $(dirname $0)/config.sh

rm -f /etc/udev/rules.d/97-kobo-rclone-menu.rules
rm -rf /usr/local/kobo-rclone-menu/
rm -rf ${RCLONEDIR}
rm -f ${MENUDIR}/rclone.menu
rm -f $Logs/*.*
rm -f $UserConfig
