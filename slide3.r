library(tidyverse)
library(tidyr)
library(dplyr)
library(readr)

slide3_data <- read_csv("Table 11 HE by state of residence per capita.csv")


names(slide3_data) <- lapply(slide3_data[1, ], as.character)
slide3 <- slide3_data[-1,]

tidy_slide3 <- gather(slide3[1:25],
                      key = "year",
                      value = "USD",
                      2:25)

