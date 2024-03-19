#!/bin/bash
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --mem=1G
#SBATCH --time=0:20:00
#SBATCH --account=schnabelr-lab
#SBATCH --job-name=demo_sbatch5
#SBATCH --output=/home/jakth2/templates/scripts/demo_outputs/logs/%x_%j.out
#SBATCH --mail-user=jakth2@mail.missouri.edu
#SBATCH --mail-type=REQUEUE,FAIL,END
echo "=== SBATCH start > $(date)"
echo "=== SBATCH running on: $(hostname)"
echo "=== SBATCH running in: ${SLURM_SUBMIT_DIR}"
echo "=== Memory Requested: ${SLURM_MEM_PER_NODE}"
##-- SCIENCE GOES HERE -- ##
export SCRIPT_TYPE=demo
export MESSAGE='running demo.sh'
export STATUS_FILE=/home/jakth2/templates/scripts/demo_outputs/logs/tracker.txt
source ./scripts/setup/helper_functions.sh 

bash /home/jakth2/templates/scripts/demo.sh 1st
capture_status "1st time ${MESSAGE}" ${STATUS_FILE}
echo "=== SBATCH IS STILL RUNNING $(date)"
sleep 40
echo "=== SBATCH IS STILL RUNNING $(date)"
sleep 30
echo "=== SBATCH IS STILL RUNNING $(date)"
sleep 30
echo "=== SBATCH end > $(date)"

