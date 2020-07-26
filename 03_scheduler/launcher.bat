REM @echo off

:: Run shell script that opens time tracker log file
cmd /c bash --login -i -- "C:\ashrith\98_open_source_development\ad-hoc-projects\time_tracker\02_manually_open_time_tracker\open_file_manually.sh"

:: Run r code that summarises all the log files till system date
R CMD BATCH --no-save --no-restore "C:\ashrith\98_open_source_development\ad-hoc-projects\time_tracker\generate_time_report.R"