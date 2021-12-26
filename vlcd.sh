#!/usr/bin/env bash
INSTALL_ROOT="/opt/github-webradio"

RUN_USER="pi"
RUN_GROUP="pi"

RUN_DIR="/var/run/vlcd"
RUN_LOGFILE="$RUN_DIR/vlcd.log"
RUN_PIDFILE="$RUN_DIR/vlcd.pid"

VLC_HTTP_PASSWORD="webradio"
VLC_PLAYLIST="$INSTALL_ROOT/webradio_meta.m3u"

##############################################################################

### Workaround for https://github.com/raspberrypi/linux/issues/4780
ifconfig eth0 down

killall vlc

sudo mkdir -p $RUN_DIR
sudo chown $RUN_USER:$RUN_GROUP $RUN_DIR

if [ -f "~/.config/vlc/vlcrc" ]; then
    volpref=$(grep "^alsa-gain" ~/.config/vlc/vlcrc)
    if [ -z $volpref ]; then
        volpref="alsa-gain 0.065"
    fi
fi
volpref="alsa-gain 0.065"

echo -e "\n"
echo "Runnig as: $RUN_USER:$RUN_GROUP"
echo "Logfile: $RUN_LOGFILE"
echo "Playlist: $VLC_PLAYLIST"
echo "Volpref: $volpref"
echo -e "\n"

sudo -u $RUN_USER /usr/bin/vlc \
--no-quiet \
--verbose 2 \
--file-logging \
--logfile $RUN_LOGFILE \
--daemon \
--pidfile $RUN_PIDFILE \
--intf dummy \
--extraintf rc:http \
--rc-host 0.0.0.0:9294 --rc-fake-tty \
--http-host 0.0.0.0 --http-port 8080 --http-password $VLC_HTTP_PASSWORD \
--network-caching 5000 \
--repeat \
--playlist-autostart \
--playlist-tree \
--one-instance \
$VLC_PLAYLIST

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
