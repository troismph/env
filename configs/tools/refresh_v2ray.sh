#!/bin/bash

BASEDIR=/home/g4z3/tools
LOGFILE=/tmp/refresh_v2ray.log
echo "refreshing v2ray config" >> $LOGFILE
date >> $LOGFILE
$BASEDIR/v2gen -u https://my.yunti.monster/link/WbBgi0t0QXornuCZ?sub=3 -o $BASEDIR/vcore/config.json -config $BASEDIR/v2gen_init.conf -best >> $LOGFILE 2>&1
echo "restarting v2ray service" >> $LOGFILE
systemctl --user restart v2ray
date >> $LOGFILE
echo "refresh done" >> $LOGFILE
