REM @echo off
cmd /c bash --login -i -- "C:\ashrith\98_open_source_development\ad-hoc-projects\time_tracker\open_file_manually.sh"
R CMD BATCH --no-save --no-restore "C:\ashrith\98_open_source_development\ad-hoc-projects\time_tracker\results_collation_v2.R"