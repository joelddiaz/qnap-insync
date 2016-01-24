#!/bin/bash -x
# vim: expandtab:tabstop=4:shiftwidth=4

if [ -e /root/first_boot_complete ] ; then
    # Because the QNAP containers get stoped then restarted (instead of starting 
    # cleanly each time), here we have been "restarted". No need to set up the
    # account again. Just start back up.
    insync-headless start
else
    if [ ! -v INSYNC_AUTH ] ; then
        echo "Set INSYNC_AUTH environment before launching"
        echo "Go to https://goo.gl/jv797S to get the code"
        exit 10
    fi

    if [ ! -v GDRIVE_PATH ] ; then
        echo "Set GDRIVE_PATH to where you mounted the Google Drive contents into this container"
        exit 11
    fi

    insync-headless start && sleep 2 && insync-headless pause_syncing && sleep 2

    insync-headless add_account -p /$GDRIVE_PATH -a $INSYNC_AUTH && sleep 2

    insync-headless resume_syncing

    touch /root/first_boot_complete
fi

echo "Looping forever so the container doesn't exit"
while true ; do sleep 3600 ; done
