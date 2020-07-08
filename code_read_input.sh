#!/bin/bash

: ' Determining the start time of 10 minute periods'
time_30_mins_ago=$(date -d '30 minutes ago' '+%Y-%m-%d %H:%M')
time_20_mins_ago=$(date -d '20 minutes ago' '+%Y-%m-%d %H:%M')
time_10_mins_ago=$(date -d '10 minutes ago' '+%Y-%m-%d %H:%M')
time_0_mins_ago=$(date -d '0 minutes ago' '+%Y-%m-%d %H:%M')

: ' Determining the file to write to'
system_date_filename=$(date '+%Y-%m-%d')
system_date_filename+=".txt"

read -p "Duration: " duration
echo $duration

read -p "Duration: " duration
echo $duration

if [ $duration == 10 ]
then 
	echo "Enter data at 10 minute interval"
	read -p "Enter what you did from $time_30_mins_ago to $time_20_mins_ago: " task_10_mins_1
	read -p "Enter what you did from $time_20_mins_ago to $time_10_mins_ago: " task_10_mins_2
	read -p "Enter what you did from $time_10_mins_ago to $time_0_mins_ago: " task_10_mins_3
	echo "$time_30_mins_ago to $time_20_mins_ago: $task_10_mins_1" >> $system_date_filename
	echo "$time_20_mins_ago to $time_10_mins_ago: $task_10_mins_2" >> $system_date_filename
	echo "$time_10_mins_ago to $time_0_mins_ago: $task_10_mins_3" >> $system_date_filename
else 
	echo "Enter data at 30 minute interval"
	read -p "Enter what you did from $time_30_mins_ago to $time_0_mins_ago: " task_30_mins
	echo "$time_30_mins_ago to $time_20_mins_ago: $task_30_mins" >> $system_date_filename
	echo "$time_20_mins_ago to $time_10_mins_ago: $task_30_mins" >> $system_date_filename
	echo "$time_10_mins_ago to $time_0_mins_ago: $task_30_mins" >> $system_date_filename
fi

$SHELL