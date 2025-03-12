#!/bin/bash

#SBATCH --partition short
#SBATCH --time 24:00:00
#SBATCH --signal TERM@1800
# setup your sbatch options here, e.g. edit the lines above, or add others

# setup other necessary code here, e.g., signal handling
# DON'T change the command line arguments

# do not edit the lines below
du-run-tasks.sh "$@"
