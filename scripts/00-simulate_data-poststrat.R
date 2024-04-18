#### Preamble ####
# Purpose: Simulate a census data set containing the following variables: state, 
# age, race, hispanic, sex, highest level of education completed, whether the respondent lives in
# an urban, rural, or suburban area
# Author: Talia Fabregas
# Date: 16 April 2024
# Contact: talia.fabregas@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(janitor)
library(arrow)

#### Simulate data ####

sim_size <- 500000

presidential_candidates <- c("Joe Biden", "Donald Trump")

states <- c(
  "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", 
  "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", 
  "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine",
  "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", 
  "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", 
  "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio",
  "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", 
  "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", 
  "Washington", "West Virginia", "Wisconsin", "Wyoming"
)

sexes <- c("male", "female")

races <- c("white","black", "asian", "middle eastern", "native american",
           "pacific islander", "other", "chinese", "japanese", 
           "asian", "south asian")

is_hispanic <- c("hispanic", "not hispanic")

education_levels <- c(
  "Did not graduate from high school", 
  "High school graduate", 
  "Some college, but no degree (yet)", 
  "2-year college degree", 
  "4-year college degree", 
  "Postgraduate degree"
)

area <- c("urban", "suburban", "rural")

states <- tolower(states)

simulated_poststrat_data <- tibble(

  # state
  state = sample(states, size=sim_size, replace=TRUE),
  # age
  age = sample(18:100, size=sim_size, replace=TRUE),
  # sex
  sex = sample(sexes, size=sim_size, replace=TRUE),
  # race
  race = sample(races, size=sim_size, replace=TRUE),
  # hispanic
  hispanic = sample(is_hispanic, size=sim_size, replace=TRUE),
  # highest level of education
  highest_education = sample(education_levels, size=sim_size, replace=TRUE),
  urban = sample(area, size=sim_size, replace=TRUE)
)

simulated_poststrat_data$race <- as.factor(simulated_poststrat_data$race)
simulated_poststrat_data$highest_education <- as.factor(simulated_poststrat_data$highest_education)



#### Save Data ####
# save a parquet under data/simulated_data
write_parquet(simulated_poststrat_data, 
              "data/simulated_data/simulated_poststrat_data.parquet")



