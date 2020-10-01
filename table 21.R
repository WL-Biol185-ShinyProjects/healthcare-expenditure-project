library(tidyverse)
library(tidyr)
library(readr)

table21 <- read_csv("Table 21.csv")

tidy21 <- table21 %>%
  gather
  
