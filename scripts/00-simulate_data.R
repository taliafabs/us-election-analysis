#### Preamble ####
<<<<<<< HEAD
# Purpose: Simulates
# Author: Talia Fabregas
# Date: 16 April 2024
# Contact: talia.fabregas@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None
=======
# Purpose: Simulate a data set where the chance that a person's preferred 
# presidential candidate is Joe Biden depends on age, gender, race
# I will add more variables later
# Author: Talia Fabregas
# Date: 26 March 2024
# Contact: talia.fabregas@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
>>>>>>> ea16533d4cdbfbc3fb62c629bd455ede01453988


#### Workspace setup ####
# install.packages("arrow")
library(tidyverse)
library(janitor)
library(arrow)
<<<<<<< HEAD

#### Simulate data ####


=======

# set seed for reproducibility
set.seed(853)

# set the number of observations to 1000
num_obs <- 1000

us_states <- c(
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

candidates <- c("Joe Biden", "Donald Trump")

races <- c("white","black", "asian", "middle eastern", "native american",
          "hispanic", "pacific islander", "other", "chinese", "japanese", 
          "asian", "south asian")

genders_binary <- c("male", "female")




#### Simulate data ####
simulated_survey_data <- tibble(
  # preferred candidate
  preferred_candidate <- sample(candidates, size=num_obs, replace=TRUE),
  # age
  age = sample(18:99, size=num_obs, replace=TRUE),
  # gender
  gender = sample(genders_binary, size = num_obs, replace = TRUE, 
                  prob = c(0.5, 0.5)),
  # race
  race = sample(races, size = num_obs, replace = TRUE),
  # state
  state = sample(us_states, size = num_obs, replace=TRUE)
)

simulated_survey_data$race <- as.factor(simulated_survey_data$race)

#### Save data ####

# save as a parquet under data/simulated_data
write_parquet(simulated_survey_data, 
              "data/simulated_data/simulated_survey_data.parquet")

# save as a csv under data/simulated_data
write_csv(simulated_survey_data,
          "data/simulated_data/simulated_survey_data.csv")
>>>>>>> ea16533d4cdbfbc3fb62c629bd455ede01453988


