#!/bin/bash

PID_FILE="/tmp/tunnel_sys.pid"
if [ -f $PID_FILE ]; then
    echo "Terminating existing tunnel..."
    pkill -F $PID_FILE
fi
AUTOSSH_PIDFILE=$PID_FILE autossh -f -i /home/ph/.ssh/ph -N -R 10026:localhost:22 g4z3@tread.miniogre.com
# ssh -i /home/ph/.ssh/ph -N -R 10026:localhost:22 g4z3@tread.miniogre.com
