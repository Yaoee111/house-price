#### Preamble ####
# Purpose: Models base on cleaned data
# Author: Yiyi Yao
# Date: 10 March 2024
# Contact: ee.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-data_cleaning.R


#### Workspace setup ####
library(readr)
library(dplyr)
library(ggplot2)
library(caret)
library(beepr)

#### Read data ####

# Read the cleaned dataset
data <- read_csv("/cloud/project/data/raw_data/cleaned_house_price.csv")

# Split the data into training and testing sets
set.seed(123)  # for reproducibility
indexes <- createDataPartition(data$totalPrice, p=0.8, list=FALSE)
train_data <- data[indexes, ]
test_data <- data[-indexes, ]

# Fit a linear model
model <- lm(totalPrice ~ ., data = train_data)



bayesian_model <-
  stan_glm(
    formula = totalPrice ~ square + floor + buildingType,
    data = data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5),
    prior_intercept = normal(location = 0, scale = 2.5),
    prior_aux = exponential(rate = 1),
    seed = 853
  )

beep()


#### Save model ####
saveRDS(model, file = "/cloud/project/model/linear_model.rds")
saveRDS(bayesian_model, file = "/cloud/project/model/bayesian_model.rds")
