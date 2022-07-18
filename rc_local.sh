#!/bin/bash
# Invoke this from /etc/rc.local

screen -dm bash -c /opt/github-webradio/unattended-upgrade.sh

/opt/github-webradio/vlcd.sh
#sleep 25
#/opt/github-webradio/vlc-commands.sh /root/vlc-commands.txt

exit 0
