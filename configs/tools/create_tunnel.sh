#!/bin/bash

PID_FILE="/tmp/tunnel_sys.pid"
if [ -f $PID_FILE ]; then
    pkill -F $PID_FILE
fi
AUTOSSH_PIDFILE=$PID_FILE autossh -i ~/.ssh/id_rsa -f -N -R 10023:localhost:22 g4z3@tread.miniogre.com