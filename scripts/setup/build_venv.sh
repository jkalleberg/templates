#!/bin/bash
# build_venv.sh

# YOU MUST INSTALL PYTHON MODULE FIRST!
. ./py-venv/modules.sh

VENV='py-venv/py3.6-venv/bin/activate'

if [[ ! -f $VENV ]]
then
  echo "=== ${VENV} doesn't exist"
  python3 -m venv py3.6-venv
  echo "py3.6-venv/" > py-venv/.gitignore
  source $VENV
  pip install --upgrade pip
  pip install pandas
  pip install scipy
fi
