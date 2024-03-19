#!/bin/bash
# templates/start_VCFinto.sh

echo "=== start of templates/start_VCFintro.sh" $(date)

./templates/cluster_status.sh

echo "--- Change to Intro project working directory"
cd /mnt/pixstor/schnabelr-ccgi-drii/WORKING/jakth2/

echo $(pwd)

echo "=== end of templates/start_VCFintro.sh" $(date)
