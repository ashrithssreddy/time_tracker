# Determine name of the file using system date
system_date_filename=$(date '+%Y-%m-%d')
system_date_filename+=".txt"

# Change directory to folder containing log files
cd "C:\Users\Ashrith Reddy\Google Drive\time_tracker_logs"

# Open the log file if it exists
if test -f "$system_date_filename"; then
	start $system_date_filename
else
# If log file does not exist already, create one using template and open it
	cp "C:\ashrith\98_open_source_development\ad-hoc-projects\time_tracker\02_manually_open_time_tracker\00_template.txt" $system_date_filename
	start $system_date_filename
	
	# Open wasted hour results from previous day
	start .
	start "time_tracking_log.xlsx"
fi

# Stray codes below - Please ignore
# system_date_filename="logs/${system_date_filename}"
# start "${PWD}"
	# previous_date_filename=$(date -d '1 day ago' '+%Y-%m-%d')
	# previous_date_filename+=".txt"	