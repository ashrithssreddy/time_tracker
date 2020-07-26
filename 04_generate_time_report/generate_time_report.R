#### Objective: Generate an excel report of where the time is spent #### 

# Setting up
library("dplyr")
rm(list=ls()); cat("\014")

# Set working directory to folder containing log files
# Ensure log files are the only .txt files in this folder.
setwd("C:/Users/Ashrith Reddy/Google Drive/time_tracker_logs")

# Derive list of all text files. 
file_names = dir(pattern = ".txt")

# Iterate over files to collect/collate all the log files
# Empty dataframe to collect wasted hours at daily level
log_files = data.frame(
  date = character(0),
  time = numeric(0),
  task = character(0),
  stringsAsFactors = F)

# file = file_names[1]
all_log_files = NULL 
for(file in file_names){
  
  # Each line of the file to be a row in data.frame 
  # Data Manipulation on log file
  text = readLines(file) %>% 
    stringr::str_squish() %>% # Remove empty spaces 
    as.data.frame() %>% 
    setNames("text") %>% 
    filter(text != "") %>%  # Remove blank lines
    mutate(calendar_date = stringr::str_replace(file, ".txt","")) 
  
  all_log_files = all_log_files %>% rbind(text)
}
rm(text, file, files)

all_log_files = all_log_files %>% 
  mutate(text = tolower(text)) %>% 
  mutate(wasted = if_else(grepl(text, pattern = "wasted"),1,0)) %>% 
  mutate(timestamp = substr(text,1,13), task = substr(text, 17,nchar(text))) %>% 
  select(calendar_date, timestamp, task, wasted) %>% 
  arrange(desc(calendar_date), desc(timestamp)) %>% 
  mutate(week_id = strftime(calendar_date, format = "%Y-%V")) %>%
  mutate(day_of_week = weekdays(as.Date(calendar_date))) 

all_log_files_day_level = all_log_files %>% 
  group_by(calendar_date, week_id, day_of_week) %>% 
  summarise(wasted_hours = 0.25*sum(grepl(task, pattern = "wasted")))
# all_log_files_day_level %>%
#   openxlsx::write.xlsx("time_tracking_log.xlsx", sheetName = "day_level", append = T)

all_log_files_task_level = all_log_files %>% 
  group_by(task) %>% 
  summarise(wasted_hours = 0.25*sum(grepl(task, pattern = "wasted")))
# all_log_files_task_level %>%
#   openxlsx::write.xlsx("time_tracking_log.xlsx", sheetName = "task_level", append = T)




file.remove("time_tracking_log.xlsx")
workbook <- openxlsx::createWorkbook("time_tracking_log.xlsx")

openxlsx::addWorksheet(workbook, "all_log_files")                  # Add a new empty sheet for this particular colum
openxlsx::setColWidths(workbook, sheet = 1, cols = 1:5, widths = "auto")
openxlsx::writeData(workbook, 1, all_log_files)                  # Write frequency table to workbook at ith position


openxlsx::addWorksheet(workbook, "all_log_files_task_level")                  # Add a new empty sheet for this particular colum
openxlsx::setColWidths(workbook, sheet = 2, cols = 1:5, widths = "auto")
openxlsx::writeData(workbook, 2, all_log_files_task_level)                  # Write frequency table to workbook at ith position

openxlsx::addWorksheet(workbook, "all_log_files_day_level")                  # Add a new empty sheet for this particular colum
openxlsx::setColWidths(workbook, sheet = 3, cols = 1:5, widths = "auto")
openxlsx::writeData(workbook, 3, all_log_files_day_level)                  # Write frequency table to workbook at ith position

openxlsx::saveWorkbook(workbook, file = "time_tracking_log.xlsx")             # Write final excel and unmount it from R