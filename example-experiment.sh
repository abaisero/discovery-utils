#!/bin/bash

num_tasks=1000
num_tasks_per_job=20

# create unique experiment id
experiment_id="experiment=example"

sbatch_args=(
  --job-name "$experiment_id"
  example-job.sbatch
)

for i in $(seq $num_tasks); do
  i=$(printf "%04d" "$i")

  # create unique task id
  task_id="task=$i"

  # create task command
  task_seconds=$((RANDOM % (60 * 5)))  # up to 5 minutes
  task_command="$PWD/example-task.py $i --task-seconds $task_seconds"

  # echo task path and command
  echo "$experiment_id" "$task_id" "$task_command"

done | du-filter-tasks.sh | du-group-tasks.sh "$experiment_id" "$num_tasks_per_job" "${sbatch_args[@]}"
