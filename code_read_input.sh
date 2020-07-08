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

else 
	echo "Enter data at 30 minute interval"
	
fi

$SHELL