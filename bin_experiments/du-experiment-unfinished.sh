#!/bin/bash

experiment_path=$1
shift

find "$experiment_path" -name "$TASK_DONE" -execdir [ ! -e "$TASK_DONE" ] \; -printf %h\\n
