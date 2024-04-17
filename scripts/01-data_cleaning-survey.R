#### Preamble ####
# Purpose: Download and clean the Cooperative Election Study 2022 Data from 
# Harvard Dataverse
# Author: Talia Fabregas
# Date: 10 April 2024
# Contact: talia.fabregas@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(janitor)
library(tidyverse)
library(arrow)

#### Download data ####
url <- "https://dataverse.harvard.edu/api/access/datafile/7359099"
survey_csv <- "data/raw_data/raw_survey_data.csv"
download.file(url, destfile = poststrat_csv, mode = "wb")
popvote2020 <- read_csv("/Users/talia/us-election-analysis/data/analysis_data/popvote_analysis_data.csv")


# Clean the survey data
raw_survey_data <- read_csv("data/raw_data/raw_survey_data.csv")

# Select possibly relevant variables
# pid3, pid7, inputstate, gender4, race, hispanic, educ, marstat, faminc_new religimp, religpew
reduced_survey_data <- raw_survey_data |>
    select(pid3, 
           pid7, 
           presvote16post, 
           presvote20post,
           inputstate,
           region,
           urbancity,
           birthyr,
           gender4,
           race,
           hispanic,
           educ)

# Filter out respondents who are not associated with the Democratic or Republic party,
# vote third party, or do not vote at all
# Filter to only include male and female genders
# Talk about the limitations of doing both of these things in data section
reduced_survey_data <- reduced_survey_data |>
  filter(presvote16post < 3 | presvote20post < 3 | pid3 < 3) |>
  filter(gender4 < 3) |>
  mutate(races = race)
  

# Create a vote_biden variable and rw code  other variables to match the 
# post-stratification data
reduced_survey_data <- reduced_survey_data |> 
  mutate(
    vote_biden = ifelse(((pid3 == 1 | pid7 == 1 | pid7 == 2 | pid7 == 3) & 
                           presvote20post !=2 & 
                           presvote16post !=2), 1 ,0),
    age = 2024 - birthyr,
    sex = ifelse(gender4 == 1, "male", "female"),
    race = case_when(
      races == 1 ~ "white",
      races == 2 ~ "black",
      races == 3 ~ "other",
      races == 4 ~ "asian",
      races == 5 ~ "native american",
      races == 6 ~ "mixed",
      races == 7 ~ "other"
    ),
    urban = case_when(
      urbancity == 1 ~ "urban",
      urbancity == 2 ~ "suburban",
      urbancity == 3 ~ "suburban",
      urbancity == 4 ~ "rural",
      urbancity == 5 ~ "other"
      
    ),
  educ = case_when(
    educ == 1 ~ "Did not graduate from high school",
    educ == 2 ~ "High school graduate",
    educ == 3 ~ "Some college, but no degree (yet)",
    educ == 4 ~ "2-year college degree",
    educ == 5 ~ "4-year college degree",
    educ == 6 ~ "Postgraduate degree"
  ),
  hispanic = ifelse(hispanic == 1, "hispanic", "not hispanic"),
  state = case_when(
    inputstate == 1 ~ "alabama",
    inputstate == 2 ~ "alaska", 
    inputstate == 4 ~ "arizona",
    inputstate == 5 ~ "arkansas",
    inputstate == 6 ~ "california",
    inputstate == 8 ~ "colorado",
    inputstate == 9 ~ "connecticut",
    inputstate == 10 ~ "delaware",
    inputstate == 11 ~ "district of columbia",
    inputstate == 12 ~ "florida",
    inputstate == 13 ~ "georgia",
    inputstate == 15 ~ "hawaii",
    inputstate == 16 ~ "idaho",
    inputstate == 17 ~ "illinois",
    inputstate == 18 ~ "indiana",
    inputstate == 19 ~ "iowa",
    inputstate == 20 ~ "kansas",
    inputstate == 21 ~ "kentucky",
    inputstate == 22 ~ "louisiana",
    inputstate == 23 ~ "maine",
    inputstate == 24 ~ "maryland",
    inputstate == 25 ~ "massachusetts",
    inputstate == 26 ~ "michigan",
    inputstate == 27 ~ "minnesota",
    inputstate == 28 ~ "mississippi",
    inputstate == 29 ~ "missouri",
    inputstate == 30 ~ "montana",
    inputstate == 31 ~ "nebraska",
    inputstate == 32 ~ "nevada",
    inputstate == 33 ~ "new hampshire",
    inputstate == 34 ~ "new jersey",
    inputstate == 35 ~ "new mexico",
    inputstate == 36 ~ "new york",
    inputstate == 37 ~ "north carolina",
    inputstate == 38 ~ "north dakota",
    inputstate == 39 ~ "ohio",
    inputstate == 40 ~ "oklahoma",
    inputstate == 41 ~ "oregon",
    inputstate == 42 ~ "pennsylvania",
    inputstate == 44 ~ "rhode island",
    inputstate == 45 ~ "south carolina",
    inputstate == 46 ~ "south dakota",
    inputstate == 47 ~ "tennessee",
    inputstate == 48 ~ "texas",
    inputstate == 49 ~ "utah",
    inputstate == 50 ~ "vermont",
    inputstate == 51 ~ "virginia",
    inputstate == 53 ~ "washington",
    inputstate == 54 ~ "west virginia",
    inputstate == 55 ~ "wisconsin",
    inputstate == 56 ~ "wyoming"
  )
  )

reduced_survey_data$race <- as.factor(reduced_survey_data$race)
reduced_survey_data$educ <- as.factor(reduced_survey_data$educ)
reduced_survey_data$urban <- as.factor(reduced_survey_data$urban)
reduced_survey_data$sex <- as.factor(reduced_survey_data$sex)
reduced_survey_data$state <- as.factor(reduced_survey_data$state)
reduced_survey_data$region <- as.factor(reduced_survey_data$region)
reduced_survey_data$hispanic <- as.factor(reduced_survey_data$hispanic)

# Join the survey and popular vote data
survey_popvote_data <- left_join(reduced_survey_data, popvote2020, by = "state")

survey_analysis_data <- survey_popvote_data |>
  select(vote_biden, 
         state, 
         biden_won, 
         biden_prop, 
         region, age, 
         sex, 
         race, 
         hispanic, 
         educ, 
         urban)

#### Save data ####
write_parquet(survey_analysis_data, "data/analysis_data/survey_analysis_data.parquet")

         
