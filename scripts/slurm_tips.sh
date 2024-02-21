#!/bin/bash

### AUTHOR: Jenna Kalleberg
### DESCRIPTION: some helpful commands to use the Mizzou Hellbender Research Computing Cluster

# Get your current path
pwd

# Describes where you are (aka login node vs compute node)
hostname

# Prints what the system calls YOU
whoami
echo $USER

# check how much physical space you have left
# lfs quota -h <insert/a_path/here>

# Describes storage used in current directory, and all sub directories
du -h

# Describes the storage systems available
df -h

# tool that allows you to view the "page" by scrolling up or down
# press "q" to escape
# less <enter_a_file_name_here>

# shows you what is available on the CPU you are currently using
lscpu | less

# shows you the IPv3 and IPv6 addresses of the node you ask it to look up
# can use this during ssh or port forwarding (Jupyter Notebooks, etc.)
host hellbender-login.rnet.missouri.edu

## HELPFUL LINKS TO LEARN MORE ABOUT THE COMMAND LINE INTERFACE (CLI):
## https://swcarpentry.github.io/shell-novice/
## https://hpc-carpentry.github.io/hpc-shell/

#### ------- SLURM-SPECIFIC COMMANDS ------ ###

# telling the scheduler on the cluster (SLURM) you want default resources from any of the 
# "Interactive" nodes, and then you want to submit a task to have the node sleep for 15 seconds, 
# and the quit
srun -p Interactive sleep 15 

# check which groups you have access to 
groups $USER

# check which partitions (compute nodes) you have access to, 
# and which accounts (priority), and with QOS (aka time extension)
sacctmgr show assoc user=$USER format=user,account,qos%50

# check the usage of multiple accounts
sshare | grep $USER

# check which partitions are currently free to use
sinfo -t idle

# check the number of cores are available on a specific partition
## %C -- allocated/idle/other/total cores
## %z -- number of sockets/cores/threads in (S:C:T) format per node
sinfo -o %n,%C,%m,%z -p Interactive

# check the status of all your currently running jobs
# NOTE: DO THIS FREQUENTLY AND CANCEL ANY HANGING JOBS!!
## Add a --start flag to get an estimate of when the job will start running from SLURM
squeue -u $USER --Format=JobID,Partition:30,Name:50,UserName,State,TimeUsed,ReasonList

# check the resources available on a single node
## NOTE: RealMem=total memory available in Mb (not Gb)
# scontrol show node <insert_valid_nodename_here>

# cancel all of your pending jobs
scancel -u $USER --state=PENDING

# cancel multiple jobs with a specific name format
for t in $(seq 3 19)
do
	name=convert-happy$t-Mother12
	echo '--- Canceling job: '$name
	scancel -u $USER --name $name
done

# check the status of a completed job
# outputs status, elapsed time, the number of CPUs used for each "srun" within a SLURM job
# Units can be [K,M,G,T,P]
# include a --parsable flag to split with a "|" instead of whitespace, makes machine parseable
## NOTE: get "jobid" from SQUEUE
sacct -j<jobid> --format=JobID,JobName%50,State,ExitCode,Node%40,Elapsed,Alloc,CPUTime,MaxRSS,MaxVMSize --units=G

## HELPFUL LINK TO LEARN MORE: 
# https://docs.rc.fas.harvard.edu/kb/convenient-slurm-commands/  
