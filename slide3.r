library(tidyverse)
library(tidyr)
library(readr)

slide2_data <- read_csv("Table 11 HE by state of residence per capita.csv")


names(slide2_data) <- lapply(slide2_data[1, ], as.character)
slide2_data <- slide2_data[-1,]