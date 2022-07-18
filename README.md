# Webradio

A playlist of some radio stations.
And an environment for Raspberry Pi to make the board a webradio.


VLC daemon code is shamelessly stolen from Pimoroni's Phat-beat project (<https://github.com/pimoroni/phat-beat/>).

**Update:** do not use VLC in embedded environments. It responds badly to bad
network conditions, especially when you are streaming and the connection
between you and the streaming server is disrupted.

Developers say it is a feature and not a bug, despite users are requesting a change
in behaviour.  See
(<https://code.videolan.org/videolan/vlc/-/issues/4774>) and
(<https://bugs.launchpad.net/ubuntu/+source/vlc/+bug/790216>)

## Todo

- migrate to ffplay
- Proper systemd integration



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
