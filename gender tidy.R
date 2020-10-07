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

# removes unwanted client
slide4 <- slide4[1:8]


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
  

total <- slide4[-9:-25,]

total_2 <- gather(total[1:8],
                  key = "year",
                  value = "USD",
                  2:8) %>%
  mutate(group = "total") %>%
  rename(ageGroup = "Age group")

total_2$USD <- gsub(",", "", total_2$USD, fixed = TRUE)

total_2 <- total_2 %>%
  mutate(year = as.numeric(year),
         dollars = as.numeric(USD)) %>%
  select(ageGroup, group, year, dollars) %>%
  rename(USD = dollars)


male_female <- slide4[-1:-8,]

male <- male_female[-9:-17,] 

male_2 <- gather(male[1:8],
                 key = "year",
                 value = "USD",
                 2:8) %>%
  mutate(group = "male") %>%
  rename(ageGroup = "Age group")

male_2$USD <- gsub(",", "", male_2$USD, fixed = TRUE)

male_2 <- male_2 %>%
  mutate(year = as.numeric(year),
         dollars = as.numeric(USD)) %>%
  select(ageGroup, group, year, dollars) %>%
  rename(USD = dollars)

female <- male_female[-1:-8,]

female_2 <- gather(female[1:8],
                   key = "year",
                   value = "USD",
                   2:8) %>%
  mutate(group = "female") %>%
  rename(ageGroup = "Age group") %>%
  filter(!is.na(USD))

female_2$USD <- gsub(",", "", female_2$USD, fixed = TRUE)

female_2 <- female_2 %>%
  mutate(year = as.numeric(year),
         dollars = as.numeric(USD)) %>%
  select(ageGroup, group, year, dollars) %>%
  rename(USD = dollars)


gender <- bind_rows(total_2, male_2, female_2)

gender_total <- gender %>%
  filter(ageGroup == "Total" | ageGroup == "Males" | ageGroup == "Females")

ggplot(gender_total, aes(year, USD, color = group)) +
  geom_line()

age_total <- gender %>%
  filter(!ageGroup == "Total") %>%
  filter(!ageGroup == "Males") %>%
  filter(!ageGroup == "Females")

age_females <- age_total %>%
  filter(!group == "total") %>%
  filter(!group == "male")

ggplot(age_total, aes(year, USD, color = ageGroup)) +
  geom_line()
