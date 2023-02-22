#!/bin/bash

# first command line argument is number of tasks per job
# other command line arguments are used as sbatch options

num_tasks_per_job=$1
shift
sbatch_args=("$@")

num_tasks_per_job_minus_1=$(($num_tasks_per_job - 1))
timestamp=$(date +%F.%T.%N)

# get job_name if possible
job_name=no-job-name
if echo "${sbatch_args[@]}" | grep -q -- --job-name; then
  job_name=$(echo "${sbatch_args[@]}" | sed -E 's/^.*--job-name (\w+).*$/\1/')
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
    # save chunk of tasks into a job_file
    job_label="job=$(printf "%03d" $job_idx)"
    job_file="job_files/job_file.$timestamp.$job_name.$job_label.txt"
    mkdir -p $(dirname $job_file)
    cat >$job_file

    # run job
    ntasks=$(wc -l <$job_file)
    mkdir -p outputs
    sbatch --ntasks $ntasks --input $job_file "${sbatch_args[@]}"
    }

  else
    break

  fi

done

exit 0
