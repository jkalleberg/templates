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

# Write a SLURM SBATCH file to "jobs" dir
jobs_dir="${1}/jobs"
logs_dir="${1}/logs"

sbatch_header="#!/bin/bash
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --mem=1G
#SBATCH --time=0:20:00
#SBATCH --account=schnabelr-lab
#SBATCH --job-name=demo_sbatch
#SBATCH --output=${logs_dir}/%x_%j.out
#SBATCH --mail-user=jakth2@mail.missouri.edu
#SBATCH --mail-type=REQUEUE,FAIL,END
echo \"=== SBATCH start > \$(date)\"
echo \"=== SBATCH running on: \$(hostname)\"
echo \"=== SBATCH running in: \${SLURM_SUBMIT_DIR}\"
echo \"=== Memory Requested: \${SLURM_MEM_PER_NODE}\"
"

sbatch_contents="##-- SCIENCE GOES HERE -- ##
export SCRIPT_TYPE=demo
export MESSAGE='running demo.sh'
export STATUS_FILE=${logs_dir}/tracker.txt
source ./scripts/setup/helper_functions.sh 

bash /home/jakth2/templates/scripts/demo.sh 1st
capture_status \"1st time \${MESSAGE}\" \${STATUS_FILE}
echo \"=== SBATCH IS STILL RUNNING \$(date)\"
sleep 40
echo \"=== SBATCH IS STILL RUNNING \$(date)\"
sleep 30
echo \"=== SBATCH IS STILL RUNNING \$(date)\"
sleep 30
echo \"=== SBATCH end > \$(date)\"
"

echo "INFO: automated SLURM job creation"
echo "${sbatch_header}
${sbatch_contents}"

# Write the SBATCH file
slurm_job_file="${jobs_dir}/demo_sbatch1.sh"
if [ ! -f $slurm_job_file ]; then
    echo "INFO: creating SLURM job | ${slurm_job_file}"
    echo "${sbatch_header}${sbatch_contents}" > $slurm_job_file
else
    echo "INFO: found existing SLURM job | ${slurm_job_file}"
fi

# # Submit the SBATCH file
# if [ -f $slurm_job_file ]; then
#     sbatch $slurm_job_file
#     sleep 0.3
# fi


echo "=== experiments.sh end > $(date)"