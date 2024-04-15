#!/bin/sh
#RClone Menu command

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

RCLONE_OP=""
if grep -q "^REMOVE_DELETED$" $UserConfig; then
    echo "Will delete files no longer present on remote"
    # Remove deleted, do a sync.
    RCLONE_OP="sync"
else
    # Don't remove deleted, do a copy.
    RCLONE_OP="copy"
fi

TRANSFERRED=0
while read url || [ -n "$url" ]; do
  if echo "$url" | grep -q '^#'; then
    continue
  elif [ -n "$url" ]; then
    echo "Getting $url"    
    remote=$(echo "$url" | cut -d: -f1)
    dir="$Lib/$remote/"
    mkdir -p "$dir"
    # --modify-window 3s
    # see https://www.mobileread.com/forums/showpost.php?p=4299209&postcount=11
    RCLONE_COMMAND="${RCLONE} ${RCLONE_OP} --modify-window 3s --no-check-certificate --error-on-no-transfer -v --config ${RCloneConfig}"
    echo ${RCLONE_COMMAND} \"$url\" \"$dir\"
    ${RCLONE_COMMAND} "$url" "$dir"
    rclone_status=$?
    # Exit code 9 = success, but no files transferred
    # because of option --error-on-no-transfer
    # In case of error, we assume that some files may have been transferred
    if [ $rclone_status != 9 ]
    then
        TRANSFERRED=1
        if [ $rclone_status != 0 ]
        then echo "rclone: Error code $rclone_status"
        fi
    fi
  fi
done < $UserConfig

if [ "$TEST" = "" ]
then
    if [ $TRANSFERRED = 1 ]
    then
       # Use NickelDBus for library refresh
       /usr/bin/qndb -t 3000 -s pfmDoneProcessing -m pfmRescanBooksFull
    else
        echo "No files transferred"
    fi
fi

rm "$Logs/index" >/dev/null 2>&1
echo "`$Dt` done"
