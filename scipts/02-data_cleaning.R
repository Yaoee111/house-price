#### Preamble ####
# Purpose: Clean the raw data 
# Author: Yiyi Yao
# Date: 10 March 2024
# Contact: ee.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R

#### Workspace setup ####
library(readr)
library(dplyr)
library(stringr)
library(tidyr)

#### Clean data ####

# Read the dataset
data <- read_csv("/cloud/project/data/raw_data/house-price.csv")

# Function to extract numbers from the "floor" column
clean_floor <- function(x) {
  as.numeric(str_extract(x, "\\d+"))
}

# Clean the "floor" column by retaining only numbers
data <- data %>%
  mutate(floor = clean_floor(floor))

# Remove rows with non-numeric data in "buildingType" and "constructionTime"
data <- data %>%
  filter(!str_detect(buildingType, "\\D"), !str_detect(constructionTime, "\\D"))

# Convert "buildingType" and "constructionTime" to numeric
data <- data %>%
  mutate(
    buildingType = as.numeric(as.character(buildingType)),
    constructionTime = as.numeric(as.character(constructionTime))
  )

# Remove rows with any NA values
data <- drop_na(data)

# Removing duplicate rows
data <- distinct(data)

# Randomly sample 300 rows from the cleaned data
set.seed(123)  # For reproducibility
data <- sample_n(data, size = 300)

# View the cleaned data
print(head(data))


#### Save data ####
write_csv(data, "/cloud/project/data/raw_data/cleaned_house_price.csv")
