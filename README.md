# 2024 US Election Analysis

## Overview

This repo provides the code associated with the 2024 US Election Analysis project. It was created by Talia Fabregas and its purpose is to produce a report that discusses the a logistic regression model that was built and multi-level regression with post-stratification (MRP) that was performed to predict the 2024 U.S. presidential election popular vote and electoral college results. The survey and post-stratification data that I used is not mine to share, but I have outlined how I gathered it below:

- The survey dataset that I used is the 2022 CES Common Content Dataset. It is available for download via URL from Harvard Dataverse. https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/PR4L8P
- The post-stratification dataset that I used is a subset of the American Community Survey (ACS) 2022, provied by IPUMS. https://usa.ipums.org/usa/

## File Structure

The repo is structured as:

- `data` contains the simulated data.
-   `model` contains the logistic regression model that I used to predict preferred 2024 U.S. presidential candidate. 
-   `other` contains sketches and a file that documents my LLM (ChatGPT 3.5) usage.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, the PDF of the paper, and a datasheet. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

ChatGPT 3.5 was used to debug and modify aspects of the code, including survey and post-stratification data cleaning, data visualizations, and tables. My interactions with ChatGPT 3.5 over the course of this project can be found in `other/llm/usage.txt`
