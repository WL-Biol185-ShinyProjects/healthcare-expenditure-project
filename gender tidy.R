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

#the gather function should only take the first 8
tidy_slide4 <- gather(slide4[1:8],
                      key = "year",
                      value = "USD",
                      2:8) %>%
  rename(ageGroup = "Age group") %>%
  #filters out rows with "NA"
  filter(!is.na(USD)) %>%
  #converts years to numeric
  mutate(Year = as.numeric(year))

#removes all of the commas and replaces it with a "" character
tidy_slide4$USD <- gsub(",", "", tidy_slide4$USD, fixed = TRUE)

#converts string USD into int USD
tidy_slide4 <- tidy_slide4 %>%
  mutate(USD = as.numeric(USD)) %>%
  select(-(year))
  
#making male a vector  
