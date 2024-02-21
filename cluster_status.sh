#!/bin/bash
# setup/cluster_status.sh

echo "=== start of setup/cluster_status.sh" $(date)

echo "--- My Current SLURM queue:"
squeue -u $USER

echo "--- Currently idle resources:"
sinfo -t idle

echo "--- My Account Fairshare:"
sshare -a -l -A animalsci,biocommunity,schnabellab,general -u $USER

echo "=== end of setup/cluster_status.sh" $(date)
