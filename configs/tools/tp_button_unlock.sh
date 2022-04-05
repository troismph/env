# /usr/bin/dbus-monitor --session "type='signal',interface='org.xfce.ScreenSaver'" |
#     while read x; do
#         case "$x" in
#             *"boolean true"*) /bin/echo SCREEN_LOCKED >> /tmp/xinput;;
#             *"boolean false"*) $HOME/tools/disable_tp_middle_button.sh;;
#         esac
#     done &
/usr/bin/dbus-monitor --session "type='signal',interface='org.blueman.Applet',member='VisibilityChanged'" |
    while read x; do
        DT=`/usr/bin/date`
        case "$x" in
            *"boolean true"*) sleep 3; /bin/echo "$DT" >> /tmp/xinput; $HOME/tools/disable_tp_middle_button.sh;;
            *"boolean false"*) sleep 3; /bin/echo "$DT" >> /tmp/xinput; $HOME/tools/disable_tp_middle_button.sh;;
            #*"boolean false"*) $HOME/tools/disable_tp_middle_button.sh;;
        esac
    done &
