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
  mutate(year = as.numeric(year))

US <- tidy_slide3$year[tidy_slide3$state == "United States"]

ggplot(tidy_slide3, aes(tidy_slide3$year[tidy_slide3$State == "United States"], USD)) +
  geom_line()

