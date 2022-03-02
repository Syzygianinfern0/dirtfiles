#!/bin/bash

BACKUP_DIR="/mnt/nvme0n1p5/Life"
JOPLIN_BIN="joplin"
NOW=$( date '+%F_%H:%M:%S' )

rm -rf $BACKUP_DIR/Joplin
$JOPLIN_BIN --profile ~/.config/joplin-desktop/ export --format md $BACKUP_DIR/Joplin
cd $BACKUP_DIR
git add .
git commit -m "update-$NOW"
git push
