#!/bin/bash
/usr/bin/inotifywait -mrq -e create,move,delete,modify /home/yiyesy/ | while read D E F
do
/usr/bin/rsync -ahqzt --delete /home/yiyesy/ root@9.98.13.50:/home/backuptest
done