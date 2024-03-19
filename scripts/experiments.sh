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

echo "=== experiments.sh end > $(date)"