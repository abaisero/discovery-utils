#!/bin/bash

# Find the IDs of all running and pending jobs owned by the current user
job_ids=$(squeue -u $USER -t RUNNING,PENDING --noheader --format="%i" | paste -sd: -)

sbatch_args=(
  --partition short
  --time 24:00:00
  --job-name=wandb-log
  --output=wandb-log.out
  --dependency=singleton,afterany:$job_ids 
)

# Submit the new job with a dependency on all running and pending jobs
sbatch ${sbatch_args[@]} --wrap 'wandb sync --sync-all --append'
