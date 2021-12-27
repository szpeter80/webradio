#!/usr/bin/env bash

##############################################################################
INSTALL_ROOT="/opt/github-webradio"

RUN_USER="pi"
RUN_GROUP="pi"

RUN_DIR="/var/run/webradio-service"
RUN_PIDFILE="$RUN_DIR/player-daemon.pid"
### Logging to syslog, because it has timestamps and it is easier to correlate
### issues with other system events
### RUN_LOGFILE="$RUN_DIR/vlcd.log"


PLAYLIST="$INSTALL_ROOT/webradio.m3u"

# Depends on the steam, how much prebuffer it permits to download
# After that amount, the buffer can only be filled real-time,
# meaning one second of extra buffer also means one second of added delay
# before playing. This can be annoying when going over a playlist.
BUFFER_MSEC="5000"

##############################################################################

### Workaround for https://github.com/raspberrypi/linux/issues/4780
sudo ifconfig eth0 down

killall $0

# ffplay reference: https://ffmpeg.org/ffplay.html

sudo mkdir -p $RUN_DIR
sudo chown $RUN_USER:$RUN_GROUP $RUN_DIR


logger "*** Starting up Webradio - player daemon ****************************"
logger "Runnig as: $RUN_USER:$RUN_GROUP"
#logger "Logfile: $RUN_LOGFILE"
#logger "Playlist: $PLAYLIST"
logger "System hw throttling: $(vcgencmd get_throttled)"
logger "*********************************************************************"

RUN_USER="pi";
PLAYLIST="https://slagerfm.netregator.hu:7813/slagerfm320.mp3";
#PLAYLIST="http://stream1.radio88.hu:8300/;stream";
sudo -u $RUN_USER ffplay \
-nodisp \
-hide_banner \
-loglevel trace \
$PLAYLIST ;

