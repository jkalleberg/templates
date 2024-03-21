#!/bin/bash
# start_venv.sh

# AGAIN, YOU MUST HAVE THE CORRECT PYTHON MODULE LOADED FIRST!
. ./py-venv/modules.sh

# check that the venv has been built
. ./py-venv/build-venv-py3.6.sh

# then activate venv
if [[ -f $VENV ]]
then
    # load the virtual python environment
    source $VENV
    echo "=== Virtual environment ${VENV} exists."
fi
