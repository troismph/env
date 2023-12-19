#!/bin/bash

IM_ENGINE=ibus
#/usr/bin/gnome-session
# /usr/bin/xfce4-session
#GNOME_SESSION_PID=$!
#export SESSION_MANAGER=local/`hostname`:@/tmp/.ICE-unix/$GNOME_SESSION_PID,unix/`hostname`:/tmp/.ICE-unix/$GNOME_SESSION_PID

echo $IM_ENGINE > /tmp/im_engine_want

if [ $IM_ENGINE != "" ]
then
    echo $IM_ENGINE > /tmp/im_engine
    export QT_IM_MODULE=$IM_ENGINE
    export GTK_IM_MODULE=$IM_ENGINE
    export XMODIFIERS=@im=$IM_ENGINE
    export QT4_IM_MODULE=$IM_ENGINE
    export CLUTTER_IM_MODULE=$IM_ENGINE
    export LC_CTYPE=zh_CN.UTF-8
fi
#sleep 3
#xfwm4 --replace&
xfsettingsd&
#if [ $IM_ENGINE = "ibus" ]
#then
#    ibus-daemon -r -d -R&
#elif [ $IM_ENGINE = "fcitx" ]
#then
#    fcitx -r -d
#fi
xfce4-panel&
