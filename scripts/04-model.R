#### Preamble ####
# Purpose: Use logistic regression to fit a model where binary support for President
# Joe Biden (D) vs Donald Trump (R) is explained by state, whether Biden won the state
# in 2020, gender, age, race, hispanic, and education
# Author: Talia Fabregas
# Date: 16 April 2024
# Contact: talia.fabregas@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 01-data_cleaning-survey.R
# Any other information needed? Logistic regression can only do binary
# classification

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
# survey_analysis_data <- read_parquet("data/analysis_data/survey_analysis_data.parquet")
# 
# # Subset it to 10,000 observations
# # might want to move some of this code to the survey data cleaning script

survey_analysis_subset <- read_parquet("data/analysis_data/survey_analysis_subset.parquet")


# set seed for reproducibility
set.seed(116)

### Model data ####

# This was fit using only a subset of the survey data because my computer cannot
# handle a dataset with 50,000 observations and it took far too long to fit
# Use the default priiors 
us_election_model <- stan_glm(
  formula = vote_biden ~ state + biden_won + sex + age_bracket + race + hispanic + educ + urban,
  data = survey_analysis_subset,
  family = binomial(link = "logit"),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 116
)



#### Save model ####
saveRDS(
  us_election_model,
  file = "models/us_election_model.rds"
)


