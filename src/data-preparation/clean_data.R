# Load merged data 
library(readr)
read_csv("../../gen/data-preparation/temp/data_merged.csv")

# Load the necessary packages 
library(tidyverse)
library(dplyr)
library(ggplot2)

# Keep only the important variables for our analysis
df_cleaned <- df_merged %>% select(id, listing_url, last_scraped, host_since, 
                                   host_acceptance_rate, neighbourhood_cleansed, 
                                   room_type, accommodates, price, minimum_nights, 
                                   availability_30, instant_bookable) 

# Arrange based on minimum nights of stay
df_cleaned <- df_cleaned %>% arrange(minimum_nights)

# Keep only listings that are listed in both 2020 and 2022
listings_both_years <- duplicated(df_cleaned$listing_url) | duplicated(df_cleaned$listing_url, fromLast = TRUE)
df_cleaned <- subset(df_cleaned, listings_both_years)

# Change variable types to be able to use them for analysis and subsetting
df_cleaned$price <- gsub("\\$", "", df_cleaned$price)
df_cleaned$price <- gsub(",", "", df_cleaned$price)
df_cleaned$host_acceptance_rate <- gsub("\\%", "", df_cleaned$host_acceptance_rate)

df_cleaned$host_acceptance_rate <- ifelse(is.na(df_cleaned$host_acceptance_rate), NA, as.numeric(df_cleaned$host_acceptance_rate))
df_cleaned$accommodates <- as.numeric(df_cleaned$accommodates)
df_cleaned$price <- as.numeric(df_cleaned$price)
df_cleaned$minimum_nights <- as.numeric(df_cleaned$minimum_nights)
df_cleaned$availability_30 <- as.numeric(df_cleaned$availability_30)

# Save cleaned data
write_csv(df_cleaned,file="../../gen/data-preparation/output/data_cleaned.csv")
