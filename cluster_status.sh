#!/bin/bash
# templates/cluster_status.sh

echo "=== start of templates/cluster_status.sh" $(date)

echo "--- My Current SLURM queue:"
squeue -u $USER

echo "--- Currently idle resources:"
sinfo -t idle | grep idle

echo "--- My Account Fairshare:"
sshare -a -l -A schnabelr-lab,bac,general -u $USER

echo "=== end of templates/cluster_status.sh" $(date)
