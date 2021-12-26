# Webradio

A playlist of some radio stations.
And an environment for Raspberry Pi to make the board a webradio.

VLC daemon code is shamelessly stolen from Pimoroni's Phat-beat project (<https://github.com/pimoroni/phat-beat/>)

## Install

1. Set up networking, install git and vlc on the Pi
1. Clone this repo to /opt/github-webradio on the Pi
1. Put this to `/etc/rc.local` on the Pi

    ```bash
    /opt/github-webradio/vlcd.sh
    sleep 1
    /opt/github-webradio/vlc-commands.sh /path/to/vlc-commands.txt
    ```

    Example comand file is provided in the repo.
1. Enjoy music from internet
