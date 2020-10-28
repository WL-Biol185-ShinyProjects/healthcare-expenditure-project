data <- read_csv("AgeGender1/Table1TotalPersonalHealthCare.csv")

# setting proper column names and removing unnecessary rows
names(data) <- lapply(data[3, ], as.character)
data <- data[-1:-3,]
data <- data[1:8]

# gathering data to ensure tidy form, converting data types of year from string to numeric
tidyTable <- gather(data[1:8],
                    key = "year",
                    value = "USD",
                    2:8) %>%
  rename(ageGroup = "Age group") %>%
  filter(!is.na(USD)) %>%
  mutate(Year = as.numeric(year))

# removing all commas in data table
tidyTable$USD <- gsub(",", "", tidyTable$USD, fixed = TRUE)

# converts data type from string to numeric for USD column
tidyTable <- tidyTable %>%
  mutate(USD = as.numeric(USD)) %>%
  select(-(year))

total <- data[-7:-25,]

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
  rename(USD = dollars) %>%
  filter(ageGroup != "Total")

#### stop here for age totals
## code below would be for males/females age group

male_female <- data[-1:-8,]

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
  filter(ageGroup == "Total" | ageGroup == "Males" | ageGroup == "Females") %>%
  select(-(group)) %>%
  rename(group = ageGroup)

age_total <- gender %>%
  filter(!ageGroup == "Total") %>%
  filter(!ageGroup == "Males") %>%
  filter(!ageGroup == "Females")

age_females <- age_total %>%
  filter(!group == "total") %>%
  filter(!group == "male") %>%
  filter(!ageGroup == "19-64") %>%
  filter(!ageGroup == "65+")

