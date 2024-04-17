#### Preamble ####
# Purpose: Clean the 2020 Election Popular Vote Data from Cook Political Report
# Author: Talia Fabregas
# Date: 14 April 2024
# Contact: talia.fabregas@mail.utoronto.ca
# License: MIT
# Pre-requisites: Download and save the 2020 national popular vote tracker csv
# from Cook Political Report
# Any other information needed? No


#### Workspace setup ####
library(tidyverse)
library(janitor)
library(dplyr)

#### Load data ####
raw_popvote_data <- read_csv("data/raw_data/popvote2020.csv")

reduced_popvote_data1 <- raw_popvote_data |>
  filter(!is.na(called))

reduced_popvote_data1 <- reduced_popvote_data1 |>
  mutate(biden_won = ifelse((called=="D"), 1, 0)) |>
  mutate(dem_percent = as.numeric(gsub("%", "", dem_percent))) |>
  mutate(biden_prop = dem_percent / 100) |>
  mutate(biden_v_trump_prop = (dem_votes)/(dem_votes + rep_votes)) |>
  mutate(state = tolower(state))

cleaned_popvote_data <- reduced_popvote_data1 |>
  select(
    state,
    biden_won,
    dem_votes,
    rep_votes,
    other_votes,
    dem_percent,
    biden_prop,
    biden_v_trump_prop
  )

write_csv(cleaned_popvote_data, "data/analysis_data/popvote_analysis_data.csv")


