#### Preamble ####
# Purpose: Download and clean the American Communities Survey Post Stratification Data
# Author: Talia Fabregas
# Date: 9 April 2024
# Contact: talia.fabregas@mail.utoronto.ca
# License: MIT
# Pre-requisites: Download and save the American Communities Survey Data from 
# IPUMS and the 2020 National Popular Vote Tracker from Cook Political Report
# Any other information needed: No

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(arrow)
library(haven)

#### Clean data ####

# Read in the raw post stratification data
raw_poststrat_data <- read_dta("data/raw_data/usa_00005.dta")
raw_poststrat_data <- labelled::to_factor(raw_poststrat_data)

popvote2020 <- read_csv("/Users/talia/us-election-analysis/data/analysis_data/popvote_analysis_data.csv")

# Select relevant variables
reduced_poststrat_data1 <- raw_poststrat_data |> 
  filter(stateicp != "state not identified")

reduced_poststrat_data1 <- raw_poststrat_data |>
  select(
    stateicp,
    region,
    birthyr,
    sex,
    race,
    hispan,
    educ,
    metro
  )

# Mutate the levels so that it can match the survey data 
reduced_poststrat_data2 <- reduced_poststrat_data1 |>
  mutate(
    race = case_when(race == "white" ~ "white",
                     race == "black/african american" ~ "black",
                     race == "chinese" ~ "asian",
                     race == "japanese" ~ "asian",
                     race == "other asian or pacific islander" ~ "asian",
                     race == "american indian or alaska native" ~ "native american",
                     race == "two major races" ~ "mixed",
                     race == "three or more major races" ~ "mixed",
                     race == "other race, nec" ~ "other"
    ),
    urban = case_when(
      metro == "in metropolitan area: in central/principal city" ~ "urban",
      metro == "in metropolitan area: not in central/principal city " ~ "suburban",
      metro == "in metropolitan area: central/principal city status indeterminable (mixed)" ~ "suburban",
      metro == "metropolitan status indeterminable (mixed)" ~ "other",
      metro == "not in metropolitan area" ~ "rural"
    ),
    educ = case_when(
      educ %in% c("nursery school to grade 4", "grade 5, 6, 7, or 8", "grade 9", "grade 10", "grade 11") ~ "Did not graduate from high school",
      educ == "grade 12" ~ "High school graduate",
      educ == "1 year of college"  ~ "Some college, but no degree (yet)",
      educ %in% c("2 years of college", "3 years of college") ~ "2-year college degree",
      educ == "4 years of college" ~ "4-year college degree",
      educ == "5+ years of college" ~ "Postgraduate degree"
    ),
    state = stateicp,
    age = 2024 - birthyr, 
    hispanic = case_when(hispan == "not hispanic" ~ "not hispanic",
                         hispan == "mexican" ~ "hispanic",
                         hispan == "puerto rican" ~ "hispanic",
                         hispan == "cuban" ~ "hispanic",
                         hispan == "other" ~ "hispanic",
                         hispan == "not reported" ~ NA)
  )

# Convert variables into factors
reduced_poststrat_data2$race <- as.factor(reduced_poststrat_data2$race)
reduced_poststrat_data2$educ <- as.factor(reduced_poststrat_data2$educ)
reduced_poststrat_data2$urban <- as.factor(reduced_poststrat_data2$urban)
reduced_poststrat_data2$sex <- as.factor(reduced_poststrat_data2$sex)
reduced_poststrat_data2$state <- as.factor(reduced_poststrat_data2$state)
reduced_poststrat_data2$region <- as.factor(reduced_poststrat_data2$region)
reduced_poststrat_data2$hispanic <- as.factor(reduced_poststrat_data2$hispanic)

# Remove all NA's
reduced_poststrat_data2 <- reduced_poststrat_data2 |>
  filter(!is.na(state) & !is.na(region) & !is.na(age) & !is.na(sex) & !is.na(race)
         & !is.na(hispan) & !is.na(educ) & !is.na(urban))

# Left-join the reduced post-stratification data with the popular vote data
# This will allow the proportion of votes that Biden won in the state to be considered
# when building the model
poststrat_popvote_data <- left_join(reduced_poststrat_data2, popvote2020, by = "state")

poststrat_analysis_data <- poststrat_popvote_data |>
  select(state, biden_won, biden_prop, region, age, sex, race, hispan, educ, urban)

# Write post stratification data parquet into data/analysis_data
# Add it to gitignore to prevent it from being shared on github
write_parquet(poststrat_analysis_data, "data/analysis_data/poststrat_analysis_data.parquet")


                                                                                                      




