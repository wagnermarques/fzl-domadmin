#!/bin/bash

file_name=$1
seconds_to_sleep=$2

sleep $seconds_to_sleep
import -window root $file_name

ffplay -x 800 -y 600 $file_name
