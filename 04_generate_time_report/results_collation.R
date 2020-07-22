#### Objective: Calculate the time wasted in a day #### 
#### Crawls time tracker log files and counts wasted hours using "wasted" keyword #### 

# Setting up #
library("dplyr")
rm(list=ls()); cat("\014")

# Set working directory to folder containing log files
# Ensure log files are the only .txt files in this folder.
setwd("C:/Users/Ashrith Reddy/Google Drive/time_tracker_logs")

# Derive list of all text files. 
file_names = dir(pattern = ".txt")

# Iterate over files to collect/collate results
# Empty dataframe to collect wasted hours at daily level
daily_wasted_hours = data.frame(
  calendar_date = character(0),
  wasted_time_hours = numeric(0),
  stringsAsFactors = F)

for(file in file_names){
  
  # Each line of the file to be a row in data.frame 
  text = readLines(file) %>% 
    stringr::str_squish() %>% # Remove empty spaces 
    as.data.frame() %>% 
    setNames("text")
  
  # Filter for line items pertaining to "wasted" time
  text = text %>% 
    filter(text != "") %>%  # Remove blank lines
    mutate(text = tolower(text)) %>% 
    filter(grepl(text, pattern = "wasted"))
  
  # Convert count of line-items to hours
  wasted_time_hours = text %>% 
    nrow() %>% 
    `*`(15/60)
  
  # Collect one day's productivity into final dataframe
  daily_wasted_hours = daily_wasted_hours %>% add_row(calendar_date = stringr::str_replace(file, ".txt",""), 
                                            wasted_time_hours = wasted_time_hours)
}

# Format and write final collated dataset
daily_wasted_hours %>% 
  arrange(desc(calendar_date)) %>% 
  # mutate(week_id = lubridate::week(calendar_date)) %>% 
  openxlsx::write.xlsx("daily_wasted_hours.xlsx")
