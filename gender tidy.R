library(tidyverse)
library(tidyr)
library(dplyr)
library(readr)
library(ggplot2)

table7_0 <- read_csv("Table 7 personal health care per capita AGE GENDER.csv")
names(table7_0) <- lapply(table7_0[3, ], as.character)
table7 <- table7_0[-2,]

# names(table7_new) <- lapply(table7[1, ], as.character)
# table7_new <- table7_new[-1,]

table7_tidy <- gather(table7[1:8], 
                      key = "Year",
                      value = "USD",
                      2:8
                      ) %>%
  filter(!is.na(USD) | )
