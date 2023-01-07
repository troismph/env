#!/bin/bash

/usr/bin/gnome-session
#/usr/bin/xfce4-session
GNOME_SESSION_PID=$!
export SESSION_MANAGER=local/`hostname`:@/tmp/.ICE-unix/$GNOME_SESSION_PID,unix/`hostname`:/tmp/.ICE-unix/$GNOME_SESSION_PID
export QT_IM_MODULE=ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT4_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus
export LC_CTYPE=zh_CN.UTF-8
sleep 5
#fcitx -r -d&
xfsettingsd&
ibus-daemon&
terminator&
xfce4-panel
