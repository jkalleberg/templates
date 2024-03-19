#!/bin/bash
# scripts/experiments.sh

echo "=== experiments.sh start > $(date)"

echo "=== command line arguments entered:"
# For loop expecting command line arguments
itr=0
for i in $@
do
    itr=$((itr+1))
    echo -e "\tArgument #${itr}: ${i}"
done

# First argument should be a valid path to store SLURM jobs/logs
echo "=== output path entered | ${1}"

# Create that output directory, if one does not exist
# and create two directories to store SLURM jobs/logs
# -p creates any missing parent directories as well

sub_dirs=("jobs" "logs")

echo "INFO: finding default sub directories..."
itr=0
for dir in ${sub_dirs[@]}; do
    new_dir="${1}/${dir}"
    itr=$((itr+1))
    if [ ! -d $new_dir ]; then
        echo "INFO: creating sub directory #${itr} | ${new_dir}"
        mkdir -p $new_dir
    else
        echo "INFO: found existing path | ${new_dir}"
    fi
done



echo "=== experiments.sh end > $(date)"