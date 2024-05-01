#!/bin/bash

tail -f "$@" | xargs -IL date +"%Y-%m-%d %H:%M:%S - L"
