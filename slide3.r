library(tidyverse)
library(tidyr)
library(dplyr)
library(readr)
library(ggplot2)

slide3_data <- read_csv("Table 11 HE by state of residence per capita.csv")


names(slide3_data) <- lapply(slide3_data[1, ], as.character)
slide3 <- slide3_data[-1,]

tidy_slide3 <- gather(slide3[1:25],
                      key = "year",
                      value = "USD",
                      2:25) %>%
  rename(State = "Region/state of residence") %>%
  mutate(Year = as.numeric(year)) %>%
  select(-(year))


tidy_slide3$USD <- gsub("$", "", tidy_slide3$USD, fixed = TRUE)

tidy_slide3 %>% mutate(dollars = as.numeric(USD))

NE_year <- tidy_slide3$Year[tidy_slide3$State == "New England"]
NE_dollars <- tidy_slide3$USD[tidy_slide3$State == "New England"]
NE_dollars <- as.numeric(NE_dollars)

ggplot(tidy_slide3, aes(NE_year, NE_dollars)) +
  geom_line()

