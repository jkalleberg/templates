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

# Second argument == "demo" to print file contents, but not sumbit
if [[ ${2} == "demo" ]]; then
    export DEMO_MODE=true
else
    export DEMO_MODE=false
fi

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

# Write MULTIPLE SBATCH files
# Start with 10s then move up to 100s --> 1000s
total_jobs=10

for job_num in $(seq 1 $total_jobs); do
    slurm_job_file="${jobs_dir}/demo_sbatch${job_num}.sh"
    if [ ! -f $slurm_job_file ]; then
        sbatch_header="#!/bin/bash
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --mem=1G
#SBATCH --time=0:20:00
#SBATCH --account=schnabelr-lab
#SBATCH --job-name=demo_sbatch${job_num}
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
        if [[ $DEMO_MODE == true ]]; then
            echo "DEMO: pretending to create new SLURM job ${job_num}-of-${total_jobs}"
            echo "DEMO: output path | ${slurm_job_file}"
            echo "DEMO: SLURM job contents..."
            echo "${sbatch_header}${sbatch_contents}"
            echo "------------------------------------------------------"
        else
            echo "INFO: writing new SLURM job | ${job_num}-of-${total_jobs}"
            echo "INFO: output path | ${slurm_job_file}"
            echo "${sbatch_header}${sbatch_contents}" > $slurm_job_file
        fi
    else
        echo "INFO: found existing SLURM job | ${slurm_job_file}"
    fi

    # Submit the SBATCH file
    if [ -f $slurm_job_file ]; then
        if [[ $DEMO_MODE == true ]]; then
            echo "DEMO: pretending to submit SLURM job ${job_num}-of-${total_jobs} | ${slurm_job_file}"
        else
            echo "INFO: submitting SLURM job ${job_num}-of-${total_jobs} | ${slurm_job_file}" 
            sbatch $slurm_job_file
            sleep 0.3
        fi
    fi
done








echo "=== experiments.sh end > $(date)"