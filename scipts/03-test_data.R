#### Preamble ####
# Purpose: Test cleaned data
# Author: Yiyi Yao
# Date: 10 March 2024
# Contact: ee.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-data_cleaning.R


#### Workspace setup ####
library(readr)
library(dplyr)
library(assertthat)

#### Test data ####

# Read the dataset
data <- read_csv("/cloud/project/data/raw_data/cleaned_house_price.csv")


# Basic information about the dataset
print(summary(data))
print(str(data))

# Sanity Checks

# Check for missing values in the entire dataset
if(any(is.na(data))){
  stop("There are missing values in the dataset.")
}

# Check that "floor", "buildingType", and "constructionTime" contain only numeric values
assert_that(all(sapply(data$floor, is.numeric)), 
            msg = "Non-numeric values found in 'floor'")
assert_that(all(sapply(data$buildingType, is.numeric)),
            msg = "Non-numeric values found in 'buildingType'")
assert_that(all(sapply(data$constructionTime, is.numeric)),
            msg = "Non-numeric values found in 'constructionTime'")

# Additional checks for logical data consistency
# Example: ensuring that all floors are positive numbers
if(any(data$floor <= 0)) {
  stop("There are invalid (non-positive) values in the 'floor' column.")
}

# Verify no duplicates
if(nrow(data) != nrow(distinct(data))) {
  stop("There are duplicate rows in the dataset.")
}

# Function to return current year
current_year <- function() {
  as.numeric(format(Sys.Date(), "%Y"))
}

# Print a success message if all checks pass
cat("All tests passed successfully. Data is clean and ready for use.\n")
