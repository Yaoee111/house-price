#### Preamble ####
# Purpose: Simulate data about house price
# Author: Yiyi Yao
# Date: 10 April 2024
# Contact: ee.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(readr)

#### Simulate data ####
# Set seed for reproducibility
set.seed(123)

# Number of samples
n_samples <- 1000

# Simulate 'square' (area)
simulated_square <- rnorm(n_samples, mean = 100, sd = 30)
simulated_square[simulated_square < 20] <- 20  # Ensuring no extremely small houses

# Simulate 'district' (assuming 5 districts)
simulated_district <- sample(1:5, n_samples, replace = TRUE)

# Adjust 'price per square meter' based on district (this is a simple adjustment, could be more complex)
price_adjustment <- c(1000, 500, 0, -500, -1000)  # Different adjustment per district
base_price_per_sqm <- 8000
simulated_price_per_sqm <- rnorm(n_samples, mean = base_price_per_sqm, sd = 2000) + 
  price_adjustment[simulated_district]

# Calculate 'totalPrice' from 'square' and 'price per square meter'
simulated_totalPrice <- simulated_square * simulated_price_per_sqm

# Create a data frame
simulated_data <- data.frame(
  district = simulated_district,
  square = simulated_square,
  price_per_sqm = simulated_price_per_sqm,
  totalPrice = simulated_totalPrice
)

# View the first few rows of the simulated data
head(simulated_data)

