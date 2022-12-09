#!/bin/bash

#autossh -L 127.0.0.1:20080:localhost:12080 g4z3@tread.miniogre.com -N
autossh -D 12080 -N -C g4z3-dt
