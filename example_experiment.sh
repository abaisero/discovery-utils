#!/bin/bash

num_tasks=1000
num_tasks_per_job=20

sbatch_args=(
  --job-name example-job
  example_job.sbatch
)

# create unique experiment id
experiment_id="experiment=example"

for i in $(seq $num_tasks); do
  i=$(printf "%04d" $i)

  # create unique task id
  task_id="task=$i"

  # create task command
  task_seconds=$(($RANDOM % (60 * 5)))  # up to 5 minutes
  task_command="./example_task.py $i --task-seconds $task_seconds"

  # echo task path and command
  echo $experiment_id $task_id $task_command

done | filter_tasks.sh | group_tasks.sh $num_tasks_per_job "${sbatch_args[@]}"
