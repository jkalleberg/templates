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
echo "=== output path entered: ${1}"

# Create that Output directory
# -p creates any missing parent directories as well
if [ ! -d $1 ]; then
    echo "INFO: creating a new directory: ${1}"
    mkdir -p $1
else
    echo "INFO: found existing path: ${1}"
fi

echo "=== experiments.sh end > $(date)"