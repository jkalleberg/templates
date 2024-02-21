# 1. OPEN UP TERMINAL/SHELL

# 2. Remote connect to HPC Cluster
ssh hb

# 3. Check HPC Cluster Status
### NOTE: You can run each of the commands below, or create a script excuted with "bash setup/cluster_status.sh"

echo "=== start of setup/cluster_status.sh" $(date)

### NOTE: Confirm if this matches expectations (Are any jobs left hanging? i.e. running but not doing anything)
echo "--- My Current SLURM queue:"
squeue -u $USER

### NOTE: Determine if you should switch to another partition, as opposed to Interactive/BioCompute
echo "--- Currently idle resources:"
sinfo -t idle

### NOTE: Determine which account is appropriate, switch to whichever is highest if submitting lots of SLURM jobs
echo "--- My Account Fairshare:"
sshare -a -l -A animalsci,biocommunity,schnabellab,general -u $USER

echo "=== end of setup/cluster_status.sh" $(date)

# 4. Move out of your $HOME directory
### NOTE: highly recommend creating a <project_name> directory under $USER!!!
echo "--- Change to project working directory"
cd /storage/hpc/group/UMAG_test/WORKING/$USER
echo $(pwd)

# 5. Look for active "screen" session
### NOTE: Always entered manually
screen -ls

# 6. Activate exiting, or create a new session
### NOTE: Always entered manually
### RE-ACTIVATE
screen -rd <session_name> or <####>

### CREATE NEW
### NOTE: highly recommend using a project-specific name for your screen session
screen -s <session_name>

# 7. Move off of the login node!!
# ====== ALWAYS START SCREEN FIRST BEFORE MOVING OFF LOGIN NODE ======
# This will keep your work if you loose connection :)

### NOTE: You can manually copy/paste one of the "srun" lines, or 
###       create a script that enables you to easily switch 
###       between resources depending on the output of "sshare"
###       which is executed with ". scripts/start_interactive.sh"

#!/bin/bash
# scripts/start_interactive.sh
# An example script of requesting interactive resources for the Lewis SLURM Cluster
# NOTE: You will need to change this to match your own setup, such as 
# altering the partition name  and qos (i.e. 'Interactive') or,
# altering your account (i.e. 'schnabellab')

# srun --pty -p gpu3 --time=0-04:00:00 -A animalsci /bin/bash
# srun --pty -p hpc6 --time=0-04:00:00 --mem=0 --exclusive -A animalsci /bin/bash
# srun --pty -p Interactive --qos=Interactive --time=0-04:00:00 --mem=0 --exclusive -A animalsci /bin/bash
# srun --pty -p Interactive --qos=Interactive --time=0-04:00:00 --mem=30G -A schnabellab /bin/bash
srun --pty -p Lewis --time=0-04:00:00 --mem=30G -A schnabellab /bin/bash


# 8. Load any existing software available on the cluster (a.k.a. "modules")
### NOTE: You can manually copy/paste one of the lines below, or 
###       create a script that enables you to keep a written record
###       of the software versions used for the project, which is 
###       executed with ". scripts/setup/modules.sh"

#!/usr/bin/bash
## scripts/setup/modules.sh

echo "=== scripts/setup/modules.sh start > $(date)"

echo "$(date '+%Y-%m-%d %H:%M:%S') INFO: Wiping modules... "
module purge
echo "$(date '+%Y-%m-%d %H:%M:%S') INFO: Done wipe modules"

echo "$(date '+%Y-%m-%d %H:%M:%S') INFO: Loading modules... "

# Enable loading of pkgs from prior manager
module load rss/rss-2020

# Update to a newer, but still old, version of Curl, for downloading files
module load curl/7.72.0

# Update to a newer version of git,
# Required for Git extensions on VSCode
module load git/2.29.0

### NOTE: only necessary if using CONDA rather than VENV
# Enable "conda activate" rather than,
# using "source activate"
module load miniconda3/4.9
export CONDA_BASE=$(conda info --base)
echo -e "$(date '+%Y-%m-%d %H:%M:%S') INFO: Conda Base Environment:\n${CONDA_BASE}"

# System Requirement to use 'conda activate' 
source ${CONDA_BASE}/etc/profile.d/conda.sh
conda deactivate

### NOTE: only necessary if using VENV rather than CONDA
# module load python/3.8.6
### OR
# module load python/3.11.1
### NOTE: be SURE to specify module version #s, to avoid accidentally loading an unexpected version !!!


# Example modules used frequently in genomics
# module load bcftools/1.16
# module load htslib/1.16
# module load samtools/1.16

echo "$(date '+%Y-%m-%d %H:%M:%S') INFO: Done Loading Modules"

echo "$(date '+%Y-%m-%d %H:%M:%S') INFO: Default Python Version:"
python3 --version

echo "$(date '+%Y-%m-%d %H:%M:%S') INFO: Default Python located here:"
which python3




# 9. If using Python/R, then activate the project environment via (VENV, CONDA, DOCKER/SINGULARITY)
### VENV
### NOTE: Create an "activate" script with the following:
# activate.sh
echo "=== activate.sh start > $(date)"

VENV='./myenv/bin/activate'

. ./build.sh

if [[ -f $VENV ]]
then
        source $VENV
        echo "=== Virtual environment ${VENV} exists."
fi

echo "=== activate.sh > end $(date)"

### NOTE: Create a "build" script with the following:
#!/bin/bash
# build.sh

echo "=== build.sh start > $(date)"

VENV='myenv/bin/activate'

if [[ ! -f $VENV ]]
then
  echo "=== ${VENV} doesn't exist"
  python3 -m venv myenv
  echo "myenv/"
  source $VENV
  pip install --upgrade pip
  pip install pandas --upgrade
  pip install numpy --upgrade
  pip install python-dateutil
fi
echo "=== build.sh > end $(date)"

### NOTE: Then activate VENV by running the following manually:
### BE SURE TO CHANGE THE PATH BASED ON WHERE YOU'RE RUNNING THINGS
### EXAMPLE: if running things in /root/bin/user/PROJECT_NAME, but "activate.sh" is located
###          @ /root/bin/user/PROJECT_NAME/Env_Create, you will need the relative path 
###          from the current working directory to the script!! (i.e. source ./Env_Create/activate.sh)
source activate.sh

echo "$(date '+%Y-%m-%d %H:%M:%S') INFO: New Python Version:"
python3 --version

echo "$(date '+%Y-%m-%d %H:%M:%S') INFO: New Python located here:"
which python3

#### EXAMPLE OF USING CONDA ###
### Create a "build_conda.sh" script similar to below
### ====== MAKE THE CHANGES NECESSARY FOR YOUR PROJECT WITHIN <> BRACKETS! ======
#!/bin/bash
# scripts/setup/build_beam.sh

echo -e "=== scripts/setup/build_beam.sh > start $(date)"

##--- NOTE: ----##
##  You must have an interactive session
##  with more memory than defaults to work!
##--------------##

if [ ! -d ./miniconda_envs/<conda> ] ; then
     # If missing an enviornment called <"conda">, 
     # initalize this env with only the anaconda package 
     conda create --yes --prefix ./miniconda_envs/<conda>
fi

# Then, activate the new environment
source ${CONDA_BASE}/etc/profile.d/conda.sh
conda deactivate
conda activate ./miniconda_envs/<conda>

##--- Configure an environment-specific .condarc file ---##
## NOTE: Only performed once:
# Changes the (env) prompt to avoid printing the full path
conda config --env --set env_prompt '({name})'

# Put the package download channels in a specific order
conda config --env --add channels defaults
conda config --env --add channels bioconda
conda config --env --add channels conda-forge

# Download packages flexibly
conda config --env --set channel_priority flexible

# Install the project-specific packages
# in the currently active env

### NOTE: You will need to search "https://anaconda.org/anaconda/repo" for specific packages
          and what "channel" they are available through (i.e. "conda-forge" vs "bioconda" etc.)
### NOTE: THE MORE SPECIFIC YOU ARE THE FASTER THIS WILL WORK
### NOTE: I HIGHLY RECOMMEND MANUALLY ADDING 1-3 PACKAGES AT A TIME -- to make sure they work together,
###       and to easily find packages that are weird, then delete the entire env, and re-create with the script
conda install -p ./miniconda_envs/<conda> -y -c conda-forge python=3.8 pandas numpy python-dotenv regex spython natsort

# Deactivate the conda env to continue with setup process
conda deactivate

###===== Notes about specific packages =====###
### Python = Apache Beam Python SDK only supports v3.6-3.8
### PACKAGE NAME = WHY IS THIS REQUIRED?

### NOTE: Then activate CONDA by running the following manually:
### BE SURE TO CHANGE THE PATH BASED ON WHERE YOU'RE RUNNING THINGS
### EXAMPLE: if running things in /root/bin/user/PROJECT_NAME, but "<conda>" is located
###          @ /root/bin/user/PROJECT_NAME/Env_Create, you will need the relative path 
###          from the current working directory to the script!! (i.e. source ./Env_Create/<conda>)
conda activate ./miniconda_envs/<conda>===

echo "$(date '+%Y-%m-%d %H:%M:%S') INFO: New Python Version:"
python3 --version

echo "$(date '+%Y-%m-%d %H:%M:%S') INFO: New Python located here:"
which python3


# NOW, YOU CAN DO SOME CODE WRITING/DEBUGGING/SCIENCE! :)

