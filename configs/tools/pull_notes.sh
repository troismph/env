#!/bin/bash

LOG_FILE=/tmp/pull_notes.log
echo "`date` Starting pull" >> $LOG_FILE
cd ~/Documents/org
git pull --no-edit >> /tmp/pull_notes.log
echo "`date` Done" >> $LOG_FILE
