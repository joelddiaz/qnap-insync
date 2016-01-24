#!/bin/bash -x

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

insync-headless start_syncing
