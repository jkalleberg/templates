#!/bin/bash
# setup/start_DeepVariant.sh

echo "=== start of setup/start_DeepVariant.sh" $(date)

./setup/cluster_status.sh

echo "--- Change to DV-TrioTrain project working directory"
cd /storage/hpc/group/UMAG_test/WORKING/jakth2/DV-TrioTrain/

echo $(pwd)

echo "=== end of setup/start_DeepVariant.sh" $(date)
