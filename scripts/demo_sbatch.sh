#!/bin/bash
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --mem=1G
#SBATCH --time=0:20:00
#SBATCH --account=schnabelr-lab
#SBATCH --job-name=demo_sbatch
#SBATCH --output=/home/jakth2/demo_outputs/logs/%x_%j.out
#SBATCH --mail-user=jakth2@mail.missouri.edu
#SBATCH --mail-type=REQUEUE,FAIL,END
##-- SCIENCE GOES HERE -- ## 
echo "=== SBATCH start > $(date)"
echo "=== SBATCH running on: $(hostname)"
echo "=== SBATCH running in: ${PWD}"
echo "=== Memory Requested: ${SLURM_MEM_PER_NODE}"

time /home/jakth2/demo.sh

sleep 30
echo "=== SBATCH IS STILL RUNNING $(date)"
sleep 30
echo "=== SBATCH IS STILL RUNNING $(date)"
sleep 30
echo "=== SBATCH IS STILL RUNNING $(date)"

echo "=== SBATCH end > $(date)"
