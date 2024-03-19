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

# Create that output directory,
# and create two directories to store SLURM jobs/logs
# -p creates any missing parent directories as well

sub_dirs=("jobs" "logs")

echo "INFO: adding sub directories..."
itr=0
for dir in ${sub_dirs[@]}; do
    itr=$((itr+1))
    echo "INFO: creating sub dir ${itr} | ${dir}"
done

if [ ! -d $1 ]; then
    echo "INFO: creating a new directory | ${1}"
    mkdir -p $1
else
    echo "INFO: found existing path | ${1}"
fi

echo "=== experiments.sh end > $(date)"