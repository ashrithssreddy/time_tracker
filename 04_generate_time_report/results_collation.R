#### Objective: Calculate the time wasted in a day using "wasted" keyword #### 

library("dplyr")
rm(list=ls()); cat("\014")

# Set working directory to folder containing log files
# Ensure log files are the only .txt files in this folder.
setwd("C:/Users/Ashrith Reddy/Google Drive/time_tracker_logs")

# Derive list of all text files. 
file_names = dir(pattern = ".txt")

# Iterate over files to collect/collate results
# Empty dataframe ot collect final_results
final_results = data.frame(stringsAsFactors = F)
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
  one_day_productivity = data.frame(calendar_date = stringr::str_replace(file, ".txt",""), 
                                    wasted_time_hours, 
                                    stringsAsFactors = F)
  final_results = final_results %>% rbind(one_day_productivity)
}

# Format and write final collated dataset
final_results %>% 
  arrange(desc(calendar_date)) %>% 
  # mutate(calendar_date = as.Date(calendar_date)) %>% 
  # mutate(week_id = lubridate::week(calendar_date)) %>% 
  openxlsx::write.xlsx("final_results.xlsx")