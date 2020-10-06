library(tidyverse)
library(tidyr)
library(dplyr)
library(readr)

slide2_data <- read_csv("Table 11 HE by state of residence per capita.csv")


names(slide2_data) <- lapply(slide2_data[1, ], as.character)
slide2 <- slide2_data[-1,]

slide_new <- slide2_data %>%
  rownames_to_column("1") %>%
  rename(State = "Region/state of residence")
  

slide_new <- subset(!slide_new["Region/state of residence"] == "United States")
