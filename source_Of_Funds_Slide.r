#library imports
library(tidyverse)
library(tidyr)
library(dplyr)
library(readr)
library(ggplot2)
library(hrbrthemes)

slide5_data <- read_csv("Table 06 Personal Health Care Expenditures.csv")
#takes the second row and makes it the column headers as characters
names(slide5_data) <- lapply(slide5_data[2, ], as.character)

#removes the following lines
slide5_data <- slide5_data[-1:-3,]

#removes the 3 empty columns
slide5_data <- slide5_data[,-10:-12]

#remove rows at the end
slide5_data <- slide5_data[-23:-113,]

#rename all of the column headers to be one word
slide5_data <- rename(slide5_data, total = "Total1")
slide5_data <- rename(slide5_data, outOfPocket = "Out of Pocket")
slide5_data <- rename(slide5_data, healthInsurance = "Health Insurance2")
slide5_data <- rename(slide5_data, privateHealthInsurance = "Private Health Insurance")
slide5_data <- rename(slide5_data, medicare = "Medicare")
slide5_data <- rename(slide5_data, medicaid = "Medicaid")
slide5_data <- rename(slide5_data, otherHealthInsurancePrograms = "Other Health Insurance Programs3")
slide5_data <- rename(slide5_data, otherThirdPartyPayers = "Other Third Party Payers4")

#removes all of the "$"
slide5_data$total <- gsub("$", "", slide5_data$total, fixed = TRUE)
slide5_data$outOfPocket <- gsub("$", "", slide5_data$outOfPocket, fixed = TRUE)
slide5_data$healthInsurance <- gsub("$", "", slide5_data$healthInsurance, fixed = TRUE)
slide5_data$privateHealthInsurance <- gsub("$", "", slide5_data$privateHealthInsurance, fixed = TRUE)
slide5_data$medicare <- gsub("$", "", slide5_data$medicare, fixed = TRUE)
slide5_data$medicaid <- gsub("$", "", slide5_data$medicaid, fixed = TRUE)
slide5_data$otherHealthInsurancePrograms <- gsub("$", "", slide5_data$otherHealthInsurancePrograms, fixed = TRUE)
slide5_data$otherThirdPartyPayers <- gsub("$", "", slide5_data$otherThirdPartyPayers, fixed = TRUE)

#removes all of the ","
slide5_data$total <- gsub(",", "", slide5_data$total, fixed = TRUE)
slide5_data$outOfPocket <- gsub(",", "", slide5_data$outOfPocket, fixed = TRUE)
slide5_data$healthInsurance <- gsub(",", "", slide5_data$healthInsurance, fixed = TRUE)
slide5_data$privateHealthInsurance <- gsub(",", "", slide5_data$privateHealthInsurance, fixed = TRUE)
slide5_data$medicare <- gsub(",", "", slide5_data$medicare, fixed = TRUE)
slide5_data$medicaid <- gsub(",", "", slide5_data$medicaid, fixed = TRUE)
slide5_data$otherHealthInsurancePrograms <- gsub(",", "", slide5_data$otherHealthInsurancePrograms, fixed = TRUE)
slide5_data$otherThirdPartyPayers <- gsub(",", "", slide5_data$otherThirdPartyPayers, fixed = TRUE)

#make all of the columns numeric
slide5_data <- mutate(slide5_data, total = as.numeric(total))
slide5_data <- mutate(slide5_data, outOfPocket = as.numeric(outOfPocket))
slide5_data <- mutate(slide5_data, healthInsurance = as.numeric(healthInsurance))
slide5_data <- mutate(slide5_data, privateHealthInsurance = as.numeric(privateHealthInsurance))
slide5_data <- mutate(slide5_data, medicare = as.numeric(medicare))
slide5_data <- mutate(slide5_data, medicaid = as.numeric(medicaid))
slide5_data <- mutate(slide5_data, otherHealthInsurancePrograms = as.numeric(otherHealthInsurancePrograms))
slide5_data <- mutate(slide5_data, otherThirdPartyPayers = as.numeric(otherThirdPartyPayers))

#graph
# ggplot(slide5_data, aes(Year, outOfPocket)) +
#    geom_point()

# p <- lapply(
#   colnames(ggdata)[2:9],
#   function(col) ggplot(ggdata, aes_string(x = 'Year', y = col)) +
#     geom_point() +
#     geom_smooth(method=lm , color="red", fill="#69b3a2", se=TRUE) +
#     theme_ipsum())
# 
# require(cowplot)
# plot_grid(
#   p[[1]], p[[2]], p[[3]], p[[4]], p[[5]], p[[6]], p[[7]], p[[8]],
#   ncol = 8,
#   labels = colnames(ggdata)[2:9])

# df %>% select(Year, total, outOfPocket, healthInsurance, privateHealthInsurance, medicare, medicaid, otherHealthInsurancePrograms, otherThirdPartyPayers) %>%
#   pivot_longer(., cols = c(total, outOfPocket, healthInsurance, privateHealthInsurance, medicare, medicaid, otherHealthInsurancePrograms, otherThirdPartyPayers), names_to = "Var", values_to = "Val")

# 
# ggplot(slide5_data, aes(Year, total)) +
#   geom_point()

# ggplot(slide5_data, aes(Year, total)) +
#   geom_point()

# slide5_data %>% tidyr::gather("id", "value", 1:9) %>% 
#   ggplot(., aes(slide5_data, value))+
#   geom_point()+
#   geom_smooth(method = "lm", se=FALSE, color="black")



# tidy_slide5 <- gather(slide5[1:9])
#                     key = "year",
#                     value = "USD",
#                     2:25) %>%
#    rename(State = "Region/state of residence") %>%
#    filter(!is.na(USD)) %>%
#    mutate(Year = as.numeric(year)) %>%
#    select(-(year))
 
# 
# 
# tidy_slide3 <- tidy_slide3 %>%
#   mutate(dollars = as.numeric(USD)) %>%
#   select(-(USD))
# 
# US <- tidy_slide3 %>%
#   filter(State == "United States")
# 
# ggplot(US, aes(Year, dollars)) +
#   geom_line()
# 
# regions <- tidy_slide3 %>%
#   filter(State == "New England" | State == "Mideast" | State == "Great Lakes" |
#            State == "Plains" | State == "Southeast" | State == "Southwest" | 
#            State == "Rocky Mountains" | State == "Far West")
# 
# ggplot(regions, aes(Year, dollars, color = State)) +
#   geom_line()
# 
# states <- tidy_slide3 %>%
#   filter(State == "New York" | State == "Illinois" | State == "Virginia")
# 
# ggplot(states, aes(Year, dollars, color = State)) +
#   geom_line()