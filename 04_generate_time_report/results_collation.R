library("dplyr")
rm(list=ls())
cat("\014")

# setwd("logs")
# setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("C:/Users/Ashrith Reddy/Google Drive/time_tracker_logs/logs")
file_names = dir(pattern = ".txt")
file_names = file_names[file_names != "00_template.txt"]

# file = file_names[2]
final_results = data.frame(stringsAsFactors = F)
for(file in file_names){
  print(file)
  
  text = readLines(file) %>% 
    stringr::str_squish() %>% 
    as.data.frame() %>% 
    setNames("text")
  
  text = text %>% 
    filter(text != "") %>% 
    mutate(text = tolower(text)) %>% 
    # tidyr::separate(col = text, into = c("time", "activity"), sep = " : ") %>% 
    filter(grepl(text, pattern = "wasted"))
  
  wasted_time_hours = text %>% 
    nrow() %>% 
    `*`(15/60)
  
  one_day_productivity = data.frame(calendar_date = file %>% stringr::str_replace(".txt",""), wasted_time_hours, 
                                    stringsAsFactors = F)
  final_results = final_results %>% rbind(one_day_productivity)
}

final_results %>% 
  arrange(desc(calendar_date)) %>% 
  # mutate(calendar_date = as.Date(calendar_date)) %>% 
  # mutate(week_id = lubridate::week(calendar_date)) %>% 
  openxlsx::write.xlsx("final_results.xlsx")

# q('no')

# strftime(c("2020-01-01","2020-01-02", "2020-01-05", "2020-01-06"), format = "%V")
# %>% 

# Next Steps
# Replace  == wasted with column containing wasted