#!/bin/bash
# setup/start_Cue.sh

echo "=== start of setup/start_Cue.sh" $(date)

./setup/cluster_status.sh

echo "--- Change to Cue project working directory"
cd /storage/hpc/group/UMAG_test/WORKING/jakth2/SVS_230718
echo $(pwd)

echo "=== end of setup/start_Cue.sh" $(date)
