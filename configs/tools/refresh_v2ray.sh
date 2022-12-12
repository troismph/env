#!/bin/bash

SUBSCRIPTION="https://sub-sg01.yunti.monster/link/WbBgi0t0QXornuCZ?sub=3&extend=1"
BASEDIR=~/tools
LOGFILE=/tmp/refresh_v2ray.log
CONFIG_OUTPUT=$BASEDIR/vcore/config.json
CONFIG_OUTPUT_ALL_PROXY=$BASEDIR/vcore/config_all_proxy.json
RETRY_INTERVAL=15
echo "refreshing v2ray config" >> $LOGFILE
date >> $LOGFILE
CK="0"
while [ $CK -eq "0" ]
do
    $BASEDIR/v2gen -template $BASEDIR/v2template.json -u $SUBSCRIPTION -o $CONFIG_OUTPUT -config $BASEDIR/v2gen_init.conf -best -thread 50 >> $LOGFILE 2>&1
    #$BASEDIR/v2gen -template $BASEDIR/v2template_all_proxy.json -u $SUBSCRIPTION -o $CONFIG_OUTPUT_ALL_PROXY -config $BASEDIR/v2gen_init_all_proxy.conf -best -thread 50 >> $LOGFILE 2>&1
    CK=`jq '.outbounds[] | select( .protocol == "vmess" ) | .settings.vnext[0].port' < $CONFIG_OUTPUT | grep -E "[0-9]+" | wc -l`
    if [ $CK -eq "0" ]
    then
        echo "Refresh failed, sleeping $RETRY_INTERVAL before retrying" >> $LOGFILE
        sleep $RETRY_INTERVAL
    fi
done
echo "Refresh done, restarting v2ray" >> $LOGFILE
systemctl --user restart v2ray
date >> $LOGFILE
echo "All done" >> $LOGFILE
