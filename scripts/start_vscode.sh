#!/bin/bash
# scripts/start_vscode.sh

# Description: start up a remote VSCode server to access via a tunnel on local VSCode GUI
#
# Usage: first, start interactive resource usage with ". scripts/start_interactive.sh"
#	 then, execute this script with ". scripts/start_vscode.sh"
#	 once the remote machine is running and permissions have been granted via GitHub,
# 	 then use "connect to tunnel..." within VSCode on your local computer.


## Install VScode Module
module purge
module load vscode/1.88.1

## Start up VSCode Tunnel
code tunnel
