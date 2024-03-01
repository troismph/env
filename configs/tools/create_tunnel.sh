#!/bin/bash

echo starting autossh...

PID_FILE="/tmp/tunnel_sys.pid"
if [ -f $PID_FILE ]; then
    pkill -F $PID_FILE
fi
AUTOSSH_PIDFILE=$PID_FILE AUTOSSH_MAXSTART=-1 autossh -o ControlMaster=no -f -N -R 10025:localhost:22 g4z3@tread.miniogre.com

echo autossh started

