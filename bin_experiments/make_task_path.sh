#!/bin/bash

experiment_id=$1
shift
task_id=$1
shift

experiment_path=$(make_experiment_path.sh $experiment_id)
echo "$experiment_path/tasks/$task_id"
