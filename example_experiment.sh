#!/bin/bash

num_tasks=1000
num_tasks_per_job=20

# create unique experiment id
experiment_id="experiment=example"

sbatch_args=(
  --job-name $experiment_id
  example_job.sbatch
)

for i in $(seq $num_tasks); do
  i=$(printf "%04d" $i)

  # create unique task id
  task_id="task=$i"

  # create task command
  task_seconds=$(($RANDOM % (60 * 5)))  # up to 5 minutes
  task_command="$PWD/example_task.py $i --task-seconds $task_seconds"

  # echo task path and command
  echo $experiment_id $task_id $task_command

done | filter_tasks.sh | group_tasks.sh $experiment_id $num_tasks_per_job "${sbatch_args[@]}"
