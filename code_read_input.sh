#!/bin/bash

system_date_filename=$(date '+%Y-%m-%d')
system_date_filename+=".txt"
echo "apple a day" >> $system_date_filename
$SHELL