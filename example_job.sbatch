#!/bin/bash

#SBATCH --output outputs/slurm.%x.%j.out
#SBATCH --partition short
#SBATCH --time 24:00:00
#SBATCH --signal USR1@900
# setup your sbatch options here, e.g. edit the lines above, or add others

# setup other necessary code here, e.g., signal handling
# DON'T change the command line arguments

# do not edit the lines below
run_tasks.sh "$@"
