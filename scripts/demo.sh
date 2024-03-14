#!/bin/bash

echo "=== demo.sh start > $(date)"
echo "Our ${1} ${SCRIPT_TYPE} script worked!"
sleep 10

if [[ $1 = "1st" ]]; then
    echo "Our ${1} ${SCRIPT_TYPE} script is still working!"
elif [[ $1 = "2nd" ]]; then
    echo "ERROR: Our ${1} ${SCRIPT_TYPE} script is not working"
    exit 1 # terminate and indicate error (any number but 0)
fi
sleep 10

echo "=== demo.sh end > $(date)"
