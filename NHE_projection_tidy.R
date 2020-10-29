library(tidyverse)

NHE_project <- read_csv("Table02NHEProjections.csv")

names(NHE_project) <- lapply(NHE_project[2, ], as.character)
NHE_project <- NHE_project[-1:-2,]
NHE_project <- NHE_project[1:22, 1:18]

NHE_tidy <- gather(NHE_project[1:18],
                   key = "year",
                   value = "USD",
                   2:18)                          
NHE_tidy$USD <- gsub(",", "", NHE_tidy$USD, fixed = TRUE)
NHE_tidy$USD <- gsub("$", "", NHE_tidy$USD, fixed = TRUE)
NHE_tidy <- NHE_tidy %>%
  mutate(USD = as.numeric(USD),
         year = as.numeric(year)
  )