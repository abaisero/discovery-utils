#!/bin/bash

# first command line argument is number of tasks per job
# other command line arguments are used as sbatch options

num_tasks_per_job=$1
shift
sbatch_args=("$@")

num_tasks_per_job_minus_1=$(($num_tasks_per_job - 1))
timestamp=$(date +%F.%T.%N)

# get jobname if possible
jobname=no-jobname
if echo "${sbatch_args[@]}" | grep -q -- --job-name; then
  jobname=$(echo "${sbatch_args[@]}" | sed -E 's/^.*--job-name (\w+).*$/\1/')
fi

# split standard input into chunks
job_idx=-1
while true; do
  job_idx=$(($job_idx + 1))

  if read -r line; then
    {
    echo "$line"

    for _ in $(seq $num_tasks_per_job_minus_1); do

      if read -r line; then
        echo "$line"
      else
        break
      fi

    done
    } | {
    # save chunk of tasks into a jobfile
    job_label="job=$(printf "%03d" $job_idx)"
    jobfile="jobfiles/jobfile.$timestamp.$jobname.$job_label.txt"
    mkdir -p $(dirname $jobfile)
    cat >$jobfile

    # run job
    ntasks=$(wc -l <$jobfile)
    mkdir -p outputs
    sbatch --ntasks $ntasks --input $jobfile "${sbatch_args[@]}"
    }

  else
    break

  fi

done

exit 0
