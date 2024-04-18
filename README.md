# 2024 US Election Analysis

## Overview

This repo provides the code associated with the 2024 US Election Analysis project. It was created by Talia Fabregas and its aim is to produce a report that discusses the a logistic regression model that was built and multi-level regression with post-stratification (MRP) that was performed to predict the 2024 U.S. presidential election popular vote and electoral college results. The survey and post-stratification data that I used is not mine to share, but I have outlined how I gathered it below:

- The survey dataset that I used is the 2022 CES Common Content Dataset. It is available for download via URL from Harvard Dataverse. https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/PR4L8P
- The post-stratification dataset that I used is a subset of the American Community Survey (ACS) 2022, provied by IPUMS. https://usa.ipums.org/usa/

In addition to survey and post-stratification data, I used datasets containing information about national popular vote results in the 2020 U.S. presidential election and the number of electoral college votes allotted to each state for part of my analysis. Once again, these datasets are not mine to share, so I have outlined how I obtained them below.

- The 2020 U.S. election national popular vote results dataset that I used is the 2020 National Popular Vote Tracker csv from Cook Political Report. It can be found using the following link: https://www.cookpolitical.com/2020-national-popular-vote-tracker
- The electoral college dataset that I used was produced by ChatGPT.  I copied the distribution of electoral votes from the National Archives, pasted it into ChatGPT, and asked ChatGPT to write a CSV file. Like all my LLM usage, this interaction with ChatGPT is documented in `other/llm/usage.txt`. The distribution of electoral votes can be found using the following link: https://www.archives.gov/electoral-college/allocation

## File Structure

The repo is structured as:

- `data` contains the simulated data.
-   `model` contains the logistic regression model that I used to predict preferred 2024 U.S. presidential candidate. 
-   `other` contains sketches and a file that documents my LLM (ChatGPT 3.5) usage.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, the PDF of the paper, and a datasheet. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

ChatGPT 3.5 was used to debug and modify aspects of the code, including survey and post-stratification data cleaning, data visualizations, and tables. Additionally, I used ChatGPT 3.5 to produce `data/analysis_data/electoral_colleges.csv`. My interactions with ChatGPT 3.5 over the course of this project can be found in `other/llm/usage.txt`
