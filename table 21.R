library(tidyverse)
library(tidyr)
library(readr)

table21 <- read_csv("Table 21.csv")

tidy21 <- gather(table21[1:25],
                 key = "year",
                 value = "USD",
                 2:25)
