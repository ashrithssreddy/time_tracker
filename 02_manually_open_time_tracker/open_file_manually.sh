: ' Determine file name'
system_date_filename=$(date '+%Y-%m-%d')
system_date_filename+=".txt"
#system_date_filename="logs/${system_date_filename}"

cd "C:\Users\Ashrith Reddy\Google Drive\time_tracker_logs"

# Open the file if it exists
if test -f "$system_date_filename"; then
	start $system_date_filename
else
# If file does not exist already, create a file using template
	cp "00_template.txt" $system_date_filename
	start $system_date_filename
	
	# Open previous day's tracker
	# start "${PWD}"
	start .
	start "final_results.xlsx"
	# previous_date_filename=$(date -d '1 day ago' '+%Y-%m-%d')
	# previous_date_filename+=".txt"	
fi