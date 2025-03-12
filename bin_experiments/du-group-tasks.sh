#!/bin/bash

# first command line argument is the experiment id
# second command line argument is number of tasks per job
# other command line arguments are used as sbatch options

experiment_id=$1
shift
num_tasks_per_job=$1
shift
sbatch_args=("$@")

num_tasks_per_job_minus_1=$((num_tasks_per_job - 1))
timestamp=$(date +%F.%T.%N)

# split standard input into chunks
job_idx=-1
while true; do
  job_idx=$((job_idx + 1))

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
    job_id="job=$(printf "%03d" $job_idx)"
    # job_path="jobs/$timestamp.$job_id"
    job_path=$(du-make-path.py job "$experiment_id" "$timestamp" "$job_id")
    mkdir -p "$job_path"

    job_input="$job_path/input.txt"
    job_output="$job_path/output.txt"
    job_error="$job_path/error.txt"
    cat >"$job_input"

    # run job
    ntasks=$(wc -l <"$job_input")
    sbatch \
      --ntasks "$ntasks" \
      --input "$job_input" \
      --output "$job_output" \
      --error "$job_error" \
      "${sbatch_args[@]}"
    }

  else
    break

  fi

done
