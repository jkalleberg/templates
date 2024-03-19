#!/bin/bash
# templates/start_DeepVariant.sh

echo "=== start of templates/start_DeepVariant.sh" $(date)

./templates/cluster_status.sh

echo "--- Change to DV-TrioTrain project working directory"
cd /mnt/pixstor/schnabelr-lab/WORKING/jakth2/DV-TrioTrain

echo $(pwd)

echo "=== end of templates/start_DeepVariant.sh" $(date)
