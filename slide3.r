library(tidyverse)
library(tidyr)
library(readr)
library(janitor)

slide2_data <- read_csv("Table 11 HE by state of residence per capita.csv")

slide2 <- slide2_data %>%
  row_to_names(row_number = 1)

names(slide2_data) <- lapply(slide2_data[1, ], as.character)
slide2_data <- slide2_data[-1,]