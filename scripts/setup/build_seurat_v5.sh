#!/bin/bash
# setup/build_seurat_v5.sh

echo -e "=== setup/build_seurat_v5.sh > start $(date)"

##--- NOTE: ----##
##  You must have an interactive session
##  with more mem than defaults to work!
##--------------##

if [ ! -d ./miniconda_envs/seurat_v5 ] ; then
     # If missing an enviornment called "seurat_v5", 
     # initalize this env with only the anaconda package 
     conda create --yes --prefix ./miniconda_envs/seurat_v5
fi

# Then, activate the new environment
source ${CONDA_BASE}/etc/profile.d/conda.sh
conda deactivate
conda activate ./miniconda_envs/seurat_v5

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
conda install -p ./miniconda_envs/seurat_v5 -y -c conda-forge r-seurat

# Deactivate the conda env to continue with build process
conda deactivate

###===== Notes about R specific packages =====###
### Seurat = for RNA-seq analysis

echo -e "=== setup/build_seurat_v5.sh > end $(date)"
