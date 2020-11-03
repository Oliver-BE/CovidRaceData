library(tidyverse)
library(readxl)
library(mosaic)

################################################################################
# First, we read in the COVID race data frame (which is by US state) and clean #
# it up as well as add a column that gives us the population by state:         #
################################################################################
# Read in and clean COVID data by race
covid_race_data_raw <- readr::read_csv("Race-Data-Entry-CRDT.csv")

# Keep most recent totals by state and remove non-states
covid_race_data_raw <- covid_race_data_raw %>%
  filter(Date == 20201007,
         State != "AS",
         State != "MP",
         State != "VI",
         State != "PR",
         State != "GU") %>%
  select(-Date)

#  Add a column to provide names for state abbreviations
state_names_df <- cbind.data.frame(state.abb, state.name) %>%
  rename(State = state.abb,
         State_Name = state.name)

# Add in Washington DC
state_names_df <- rbind(state_names_df, c("DC", "District of Columbia")) %>%
  arrange(State)

# Add state names to covid_race_data_raw
covid_race_data_raw <- inner_join(covid_race_data_raw, state_names_df, by = "State")

# Read in US population by state and add to covid_race_data_raw
pop_df <- read_excel("nst-est2019-01.xlsx",
                     range = "A9:M60") %>%
  arrange(West)

pop_df <- cbind.data.frame(pop_df[1], pop_df[13])
colnames(pop_df) <- c("State_Name", "Population")
pop_df <- pop_df %>%
  mutate(State_Name = sub('.', '', State_Name))

covid_race_data_raw <- inner_join(covid_race_data_raw, pop_df, by = "State_Name")

# add this data to our package
usethis::use_data(covid_race_data_raw, overwrite = TRUE)

# replace NAs with 0s
covid_race_data_raw[is.na(covid_race_data_raw)] <- 0

################################################################################
# Create a separate dataframe to keep track of US totals from  above dataframe #
################################################################################
# Build data frame to keep track of aggregate totals from covid_race_df
covid_race_df_total <- as.data.frame(colSums(Filter(is.numeric, covid_race_df[, -1])))

covid_race_df_total <- covid_race_df_total %>%
  mutate(column_names = row.names(covid_race_df_total))

colnames(covid_race_df_total) <- c("total_values", "column_names")

covid_race_df_total <- covid_race_df_total %>%
  pivot_wider(names_from = "column_names",
              values_from = "total_values" )

################################################################################
# Now, we get use data that gives us percent of the US population by race      #
# /ethnicity (from                                                             #
# https://www.census.gov/quickfacts/fact/table/US/PST045219#PST045219) to      #
# calculate an estimate for population by race/ethnicity in the US:            #
################################################################################
# Get population percent by ethnicity / race
# Below percents from the 2019 U.S. Census Bureau Estimates:
# https://en.wikipedia.org/wiki/Race_and_ethnicity_in_the_United_States

race_ethnicity_percents <- c(0.612, 0.153, 0.134, 0.059, 0.027, 0.013, 0.002)

total_us_population <- sum(pop_df$Population)
pop_by_race <- total_us_population * race_ethnicity_percents
pop_race_df <- cbind.data.frame(pop_by_race, pop_by_race / 100000,
                                c("White", "Hispanic", "Black", "Asian",
                                  "Multiracial", "AIAN", "NHPI")
)
colnames(pop_race_df) <- c("Population", "Population_In_100K", "Demographic")
pop_race_df <- pivot_wider(pop_race_df,
                           names_from = "Demographic",
                           values_from = c("Population_In_100K", "Population"))

################################################################################
# We can now calculate cases and deaths by race/ethnicity per 100,000 people   #
# using the above population dataframe and join it to `covid_race_df_total`:   #
################################################################################

covid_race_df_total <- cbind(covid_race_df_total, pop_race_df)

covid_race_df_total <- covid_race_df_total %>%
  mutate(Cases_Per_100K_White        = Cases_White / Population_In_100K_White,
         Cases_Per_100K_Black        = Cases_Black / Population_In_100K_Black,
         Cases_Per_100K_AIAN         = Cases_AIAN / Population_In_100K_AIAN,
         Cases_Per_100K_NHPI         = Cases_NHPI / Population_In_100K_NHPI,
         Cases_Per_100K_Multiracial  = Cases_Multiracial / Population_In_100K_Multiracial,
         Cases_Per_100K_Hispanic     = Cases_Ethnicity_Hispanic / Population_In_100K_Hispanic,
         Cases_Per_100K_Asian        = Cases_Asian / Population_In_100K_Asian,

         Deaths_Per_100K_White       = Deaths_White / Population_In_100K_White,
         Deaths_Per_100K_Black       = Deaths_Black / Population_In_100K_Black,
         Deaths_Per_100K_AIAN        = Deaths_AIAN / Population_In_100K_AIAN,
         Deaths_Per_100K_NHPI        = Deaths_NHPI / Population_In_100K_NHPI,
         Deaths_Per_100K_Multiracial = Deaths_Multiracial / Population_In_100K_Multiracial,
         Deaths_Per_100K_Hispanic    = Deaths_Ethnicity_Hispanic / Population_In_100K_Hispanic,
         Deaths_Per_100K_Asian       = Deaths_Asian / Population_In_100K_Asian)

# Make data longer
# Make cases data longer
cases_subset <- covid_race_df_total[1:13] %>%
  pivot_longer(cols = everything(), names_to = "Race",
               values_to = "Cases_Total") %>%
  mutate(Race = gsub(".*_", "", Race)) %>%
  filter(Race != "Total",
         Race != "Unknown",
         Race != "NonHispanic",
         Race != "Other",
         Race != "LatinX")

# Make deaths data longer
deaths_subset <- covid_race_df_total[14:26] %>%
  pivot_longer(cols = everything(), names_to = "Race",
               values_to = "Deaths_Total") %>%
  mutate(Race = gsub(".*_", "", Race)) %>%
  filter(Race != "Total",
         Race != "Unknown",
         Race != "NonHispanic",
         Race != "Other",
         Race != "LatinX")

# Make population data longer
total_population_subset <- cbind(covid_race_df_total[27], covid_race_df_total[35:41]) %>%
  pivot_longer(cols = everything(), names_to = "Race",
               values_to = "Population_Total") %>%
  mutate(Race = gsub(".*_", "", Race)) %>%
  filter(Race != "Population")

# Make population per 100K data longer
population_100K_subset <- covid_race_df_total[28:34] %>%
  pivot_longer(cols = everything(), names_to = "Race",
               values_to = "Population_In_100K") %>%
  mutate(Race = gsub(".*_", "", Race))

# Make cases per 100K data longer
cases_100K_subset <- covid_race_df_total[42:48] %>%
  pivot_longer(cols = everything(), names_to = "Race",
               values_to = "Cases_Per_100K") %>%
  mutate(Race = gsub(".*_", "", Race))

# Make deaths per 100K data longer
deaths_100K_subset <- covid_race_df_total[49:55] %>%
  pivot_longer(cols = everything(), names_to = "Race",
               values_to = "Deaths_Per_100K") %>%
  mutate(Race = gsub(".*_", "", Race))

aggregated_covid_race_df <- full_join(cases_subset, deaths_subset, by = "Race") %>%
  full_join(total_population_subset, by = "Race") %>%
  full_join(population_100K_subset, by = "Race") %>%
  full_join(cases_100K_subset, by = "Race") %>%
  full_join(deaths_100K_subset, by = "Race") %>%
  arrange(Race)

# add in percent of people, percent of cases, and percent of deaths for each race/ethnicity
df_to_add <- cbind.data.frame(race_ethnicity_percents,
                              c("White", "Hispanic", "Black", "Asian",
                                "Multiracial", "AIAN", "NHPI")
)
colnames(df_to_add) <- c("Population_Percent", "Race")

total_cases <- sum(aggregated_covid_race_df$Cases_Total)
total_deaths <- sum(aggregated_covid_race_df$Deaths_Total)

aggregated_covid_race_df <- inner_join(aggregated_covid_race_df, df_to_add, by = "Race") %>%
  mutate(Cases_Percent = Cases_Total / total_cases,
         Deaths_Percent = Deaths_Total / total_deaths)

# add this data to our package
usethis::use_data(aggregated_covid_race_df, overwrite = TRUE)

