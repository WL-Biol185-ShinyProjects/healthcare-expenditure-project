#import statements
library(tidyverse)
library(tidyr)
library(dplyr)
library(readr)
library(ggplot2)

slide4_data <- read_csv("Table 7 personal health care per capita AGE GENDER.csv")

# this line is setting the names of columns equal to the data in the third row which contains the years
names(slide4_data) <- lapply(slide4_data[3, ], as.character)

# this line removes rows 1:3
slide4 <- slide4_data[-1:-3,]

total <- slide4[-9:-25,]

male_female <- slide4[-1:-8,]

male <- male_female[-9:-17,]

female <- male_female[-1:-8,]


names(table7_new) <- lapply(table7[1, ], as.character)
table7_new <- table7_new[-1,]

#just want the levels, not the average annual growth
#delete the average annual growth

#the gather function should only take the first 8
tidy_slide4 <- gather(slide4[1:8],
                      key = "year",
                      value = "USD",
                      2:8) %>%
  rename(State = "Region/state of residence") %>%
  filter(!is.na(USD)) %>%
  mutate(Year = as.numeric(year)) %>%
  select(-(year))



