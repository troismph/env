#!/bin/bash

./v2gen -u https://my.yunti.monster/link/WbBgi0t0QXornuCZ?sub=3 -o ./vcore/config.json -config v2gen_init.conf -best
systemctl --user restart v2ray


