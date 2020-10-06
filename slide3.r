library(tidyverse)
library(tidyr)
library(dplyr)
library(readr)
library(ggplot2)

slide3_data <- read_csv("Table 11 HE by state of residence per capita.csv")
names(slide3_data) <- lapply(slide3_data[1, ], as.character)

# slide3_del <- slide3_data[-c(62), ]
# slide3_del <- slide3_data[-c(2, 9, 16, 30, 43, 48, 54, 61, 62), ]

slide3 <- slide3_data[-1,]

tidy_slide3 <- gather(slide3[1:25],
                      key = "year",
                      value = "USD",
                      2:25) %>%
  rename(State = "Region/state of residence") %>%
  filter(!is.na(USD)) %>%
  mutate(Year = as.numeric(year)) %>%
  select(-(year))

tidy_slide3$USD <- gsub("$", "", tidy_slide3$USD, fixed = TRUE)
tidy_slide3$USD <- gsub(",", "", tidy_slide3$USD, fixed = TRUE)


tidy_slide3 <- tidy_slide3 %>%
  mutate(dollars = as.numeric(USD)) %>%
  select(-(USD))

US <- tidy_slide3 %>%
  filter(State == "United States")

ggplot(US, aes(Year, dollars)) +
  geom_line()

regions <- tidy_slide3 %>%
  filter(State == "New England" | State == "Mideast" | State == "Great Lakes") | State == "Plains" | State == "Southeast" | State == "Southwest" | State == "Rocky Mountains" | State == "Far West")

