#!/bin/bash
# templates/start_Cue.sh

echo "=== start of templates/start_Cue.sh" $(date)

./templates/cluster_status.sh

echo "--- Change to Cue project working directory"
cd /mnt/pixstor/schnabelr-drii/jakth2/
echo $(pwd)

echo "=== end of templates/start_Cue.sh" $(date)
