: ' Determine file name'
system_date_filename=$(date '+%Y-%m-%d')
system_date_filename+=".txt"
system_date_filename="logs/${system_date_filename}"

cd "C:\ashrith\98_open_source_development\ad-hoc-projects\time_tracker"

# Open the file if it exists
if test -f "$system_date_filename"; then
	start $system_date_filename
else
# If file does not exist already, create a file using template
	cp "logs/00_template.txt" $system_date_filename
	start $system_date_filename
	
	# Open previous day's tracker
	start $PWD
	# previous_date_filename=$(date -d '1 day ago' '+%Y-%m-%d')
	# previous_date_filename+=".txt"	
fi