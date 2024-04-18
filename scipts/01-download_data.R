#### Preamble ####
# Purpose: Download and save dataset from Kaggle
# Author: Yiyi Yao
# Date: 10 April 2024
# Contact: ee.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(reticulate)

#### Download data ####

Sys.setenv(KAGGLE_CONFIG_DIR = "~/.kaggle")
system("https://www.kaggle.com/datasets/ruiqurm/lianjia/data/cloud/project/data/raw_data")


#### Save data ####
write.csv(data, "cloud/project/data/raw_data/house-price.csv")
         
