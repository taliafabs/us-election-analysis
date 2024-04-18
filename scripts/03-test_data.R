#### Preamble ####
# Purpose: Tests that the data cleaning and that the survey and post-stratification data sets
# are what I expect them to be
# Author: Talia Fabregas
# Date: 16 April 2024
# Contact: talia.fabregas@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 01-data_cleaning-survey and 01-data_cleaning-poststrat
# Any other information needed? No


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)
library(janitor)

#### Test data ####
survey <- read_parquet("data/analysis_data/survey_analysis_data.parquet")
poststrat <- read_parquet("data/analysis_data/poststrat_analysis_data.parquet")

# Test that the vote_biden variable is binary
if(all(survey$vote_biden == 1 |survey$vote_biden==0)){
  "The voted_biden values in the survey data set are all 1 or 0"
} else{
  "At least one of the voted_biden values in the survey data is not 1 or 0. Problem!"
}

# Test that the variable state has the same levels in the survey and poststrat data sets
if(identical(sort(unique(survey$state)), sort(unique(poststrat$state)))) {
  "The survey and poststrat data sets have the same levels for the state variable"
} else {
  "The survey and poststrat data sets do not have the same levels for the state variable"
}

# Test that the variable biden_won is binary in both the survey and poststrat data sets
if(all(survey$biden_won == 1 |survey$biden_won==0)){
  "The survey biden_won values are all 1 or 0"
} else{
  "At least one of the biden_won values in the survey dataset is not 1 or 0"
}

if(all(poststrat$biden_won == 1 |poststrat$biden_won==0)){
  "The poststrat biden_won values are all 1 or 0"
} else{
  "At least one of the biden_won values in the poststrat dataset is not 1 or 0"
}


# Test that the variable sex has the same levels in the survey and poststrat data sets
if((unique(survey$sex)) == (unique(poststrat$sex))){
  "The survey and poststrat data sets have the same levels for the sex variable"
} else{
  "The survey and poststrat data sets do not have the same levels for the sex variable"
}

# Test that the variable age_bracket has the same levels in the survey and poststrat data sets
if((unique(survey$age_bracket)) == (unique(poststrat$age_bracket))){
  "The survey and poststrat data sets have the same levels for the age_bracket variable"
} else{
  "The survey and poststrat data sets do not have the same levels for the age_bracket variable"
}

# Test that the variable educ has the same levels in the survey and poststrat data sets
if((unique(survey$educ)) == (unique(poststrat$educ))){
  "The survey and poststrat data sets have the same levels for the educ variable"
} else{
  "The survey and poststrat data sets do not have the same levels for the educ variable"
}

# Test that the variable urban has the same levels in the survey and poststrat data sets
if((unique(survey$urban)) == (unique(poststrat$urban))){
  "The survey and poststrat data sets have the same levels for the urban variable"
} else{
  "The survey and poststrat data sets do not have the same levels for the urban variable"
}

# Test that all survey and census respondents are at least 18 years old
if(all(survey$age >= 18)){
  "All survey responents are age 18 or older"
} else{
  "At least one survey respondent is younger than 18 years old"
}

if(all(poststrat$age >= 18)){
  "All census responents are age 18 or older"
} else{
  "At least one census respondent is younger than 18 years old"
}
