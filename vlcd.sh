#!/usr/bin/env bash

##############################################################################
INSTALL_ROOT="/opt/github-webradio"

RUN_USER="pi"
RUN_GROUP="pi"

RUN_DIR="/var/run/vlcd"
RUN_PIDFILE="$RUN_DIR/vlcd.pid"
### Logging to syslog, because it has timestamps and it is easier to correlate
### issues with other system events
### RUN_LOGFILE="$RUN_DIR/vlcd.log"

VLC_HTTP_PASSWORD="webradio"
VLC_PLAYLIST="$INSTALL_ROOT/webradio.m3u"
# Depends on the steam, how much prebuffer it permits to download
# After that amount, the buffer can only be filled real-time,
# meaning one second of extra buffer also means one second of added delay
# before playing. This can be annoying when going over a playlist.
VLC_NETWORK_CACHE_MSEC="5000"

##############################################################################

### Workaround for https://github.com/raspberrypi/linux/issues/4780
ifconfig eth0 down

killall vlc

sudo mkdir -p $RUN_DIR
sudo chown $RUN_USER:$RUN_GROUP $RUN_DIR


logger "******************** Starting up VLC daemon *************************"
logger "Runnig as: $RUN_USER:$RUN_GROUP"
logger "Logfile: $RUN_LOGFILE"
logger "Playlist: $VLC_PLAYLIST"
logger "System hw throttling: $(vcgencmd get_throttled)"
logger "*********************************************************************"


sudo -u $RUN_USER /usr/bin/vlc \
--daemon \
--pidfile $RUN_PIDFILE \
--no-quiet \
--verbose 2 \
--syslog \
--intf dummy \
--extraintf rc:http \
--rc-host 0.0.0.0:9294 --rc-fake-tty \
--http-host 0.0.0.0 --http-port 8080 --http-password $VLC_HTTP_PASSWORD \
--http-reconnect \
--network-caching $VLC_NETWORK_CACHE_MSEC \
--repeat \
--playlist-autostart \
--playlist-tree \
--one-instance \
$VLC_PLAYLIST


sudo renice -10 "$(cat $RUN_PIDFILE)"
sudo ionice -c 1 -n 1 -p "$(cat $RUN_PIDFILE)"


# --file-logging \
# --logfile $RUN_LOGFILE \

# --$volpref \
# --audio-filter compressor,volnorm \
# --norm-buff-size 10 \
# --norm-max-level 80.0 \
# --norm-max-level -3 \
# --compressor-attack 50.0 \
# --compressor-release 200.0 \
# --compressor-ratio 20.0 \
# --compressor-threshold 0.0 \
# --compressor-rms-peak 0.0 \
# --compressor-knee 1.0 \
# --compressor-makeup-gain 0.0 \
