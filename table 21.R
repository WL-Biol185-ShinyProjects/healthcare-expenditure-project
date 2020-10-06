library(tidyverse)
library(tidyr)
library(readr)

table21 <- read_csv("Table 21.csv")

tidy21 <- gather(table21[1:25],
                 key = "year",
                 value = "USD",
                 2:25)
<<<<<<< HEAD

tidy21_clean <- tidy21 %>%
  rowwise() %>%
  
  
=======
>>>>>>> 2c928a0d84e2a2751e01ffd74e0cff666fd63915
