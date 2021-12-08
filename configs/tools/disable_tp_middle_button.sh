#!/bin/bash

DT=`date`
echo "$DT running tp script" >> /tmp/xinput
DISPLAY=:0 /usr/bin/xinput set-button-map "ThinkPad Multi Connect Bluetooth Keyboard with Trackpoint Mouse" 1 0 3 4 5 6 7 &>> /tmp/xinput
DEVID=`DISPLAY=:0 xinput list --id-only "pointer:Lenovo ThinkPad Compact USB Keyboard with TrackPoint"`
DISPLAY=:0 /usr/bin/xinput set-button-map $DEVID 1 0 3 4 5 6 7 &>> /tmp/xinput
DISPLAY=:0 /usr/bin/xinput set-button-map "TPPS/2 Elan TrackPoint" 1 0 3 4 5 6 7 &>> /tmp/xinput
