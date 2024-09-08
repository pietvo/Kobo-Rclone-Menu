#!/bin/sh
#Rclone Menu setup

TEST=$1

#load config
. $(dirname $0)/config.sh

#check if Kobo-Rclone-Menu contains the line "UNINSTALL"
if grep -q '^UNINSTALL$' $UserConfig; then
    echo "Uninstalling Kobo-Rclone-Menu!"
    $KC_HOME/uninstall.sh
    exit 0
fi


if [ "$TEST" = "" ]
then
    #check internet connection
    echo "`$Dt` waiting for internet connection"
    r=1;i=0
    while [ $r != 0 ]; do
    if [ $i -gt 60 ]; then
        ping -c 1 -w 3 aws.amazon.com >/dev/null 2>&1
        echo "`$Dt` error! no connection detected" 
        exit 1
    fi
    ping -c 1 -w 3 aws.amazon.com >/dev/null 2>&1
    r=$?
    if [ $r != 0 ]; then sleep 1; fi
    i=$(($i + 1))
    done
fi

if [ "$PLATFORM" = "Kobo" ]
then
  # check for qbdb
  if [ -f "/usr/bin/qndb" ]
  then
      echo "NickelDBus found"
  else
      echo "NickelDBus not found: installing it!"
      wget "https://github.com/shermp/NickelDBus/releases/latest/download/KoboRoot.tgz" -O - | tar xz -C /
  fi

  # check for libnm
  if [ -f "/usr/local/Kobo/imageformats/libnm.so" ]
  then
      echo "NickelMenu found"
  else
      echo "NickelMenu not found: installing it!"
      wget "https://github.com/pgaskin/NickelMenu/releases/latest/download/KoboRoot.tgz" -O - | tar xz -C /
  fi
  if [ ! -f ${MENUDIR}/rclone.menu ]
  then sed "s+\\\$Logs+$Logs+" $KC_HOME/rclone.menu > ${MENUDIR}/rclone.menu
       echo "Installing rclone.menu"
  fi
  
  RCLONEVERSION=1.67.0
  RCLONESIZE=56819874

  # check for rclone
  if [[ -f "${RCLONE}"  &&  $(stat -c %s "${RCLONE}") = "${RCLONESIZE}" ]]
  then
      echo "rclone found"
  else
      echo "rclone not found: installing rclone version ${RCLONEVERSION} (size ${RCLONESIZE})!"
      mkdir -p "${RCLONEDIR}"
      rcloneTemp="${RCLONEDIR}/rclone.tmp.zip"
      rm -f "${rcloneTemp}"
      # get rclone distribution with wget, unzip it, but remove it if it failed
      wget "https://github.com/rclone/rclone/releases/download/v${RCLONEVERSION}/rclone-v${RCLONEVERSION}-linux-arm-v7.zip" -O "${rcloneTemp}" &&
      unzip -p "${rcloneTemp}" rclone-v${RCLONEVERSION}-linux-arm-v7/rclone > ${RCLONE} || rm ${RCLONE}
      rm -f "${rcloneTemp}"
  fi
fi

echo "`$Dt` done"
