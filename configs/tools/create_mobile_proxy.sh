#!/bin/bash

autossh -L 127.0.0.1:12080:192.168.2.1:12080 g4z3@tread.miniogre.com -N
#autossh -D 12080 -N -C g4z3-dt
