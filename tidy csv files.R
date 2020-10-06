library(lubridate)
library(tidyverse)


tidyTables <- function(table) {
  
  # read in csv file
  data <- read_csv(table)
  
  # replacing column x names with years, removing duplicate column header row
  names(data) <- lapply(data[1, ], as.character)
  data <- data[-1,]
  
  # gather years into a column
  # rename column, remove NA values, convert year data type to numeric, remove original year column
  tidyTable <- gather(data[1:25],
                      key = "year",
                      value = "USD",
                      2:25) %>%
    rename(State = "Region/state of residence") %>%
    filter(!is.na(USD)) %>%
    mutate(Year = as.numeric(year)) %>%
    select(-(year))
  
  # remove "$" and "," from USD variable
  tidyTable$USD <- gsub("$", "", tidyTable$USD, fixed = TRUE)
  tidyTable$USD <- gsub(",", "", tidyTable$USD, fixed = TRUE)

  # convert USD data type to numeric
  tidyTable <- tidyTable %>%
    mutate(dollars = as.numeric(USD)) %>%
    select(-(USD))
  
  # return new table
  tidyTable
  
}


table11 <- tidyTables("Table 11 HE by state of residence per capita.csv")
