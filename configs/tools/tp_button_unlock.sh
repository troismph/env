/usr/bin/dbus-monitor --session "type='signal',interface='org.xfce.ScreenSaver'" |
    while read x; do
        case "$x" in
            *"boolean true"*) /bin/echo SCREEN_LOCKED >> /tmp/xinput;;
            *"boolean false"*) $HOME/tools/disable_tp_middle_button.sh;;
        esac
    done &
