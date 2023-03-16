# Load the necessary packages 
library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)

# Load merged data 
df_merged <- read_csv("../../gen/data-preparation/temp/data_merged.csv")

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

# Add dummy variable covid-19
df_cleaned$covid <- ifelse(grepl("2020", df_cleaned$last_scraped), TRUE, FALSE)

# Make categorical variables ready for factorization
table(df_cleaned$neighbourhood_cleansed)
df_cleaned$neighbourhood_num <- as.numeric(factor(df_cleaned$neighbourhood_cleansed, levels=c("Bijlmer-Centrum", "Bos en Lommer", 
                                                                                              "Centrum-Oost", "De Aker - Nieuw Sloten",
                                                                                              "De Pijp - Rivierenbuurt", "Geuzenveld - Slotermeer", 
                                                                                              "Noord-Oost", "Oostelijk Havengebied - Indische Buurt",
                                                                                              "Oud-Noord", "Slotervaart", "Westerpark", "Bijlmer-Oost",
                                                                                              "Buitenveldert - Zuidas", "Centrum-West", "De Baarsjes - Oud-West",
                                                                                              "Gaasperdam - Driemond", "IJburg - Zeeburgereiland",
                                                                                              "Noord-West", "Osdorp", "Oud-Oost", "Watergraafsmeer", "Zuid")))

table(df_cleaned$room_type)
df_cleaned$roomtype_num <- as.numeric(factor(df_cleaned$room_type, levels=c("Hotel room", "Entire home/apt", 
                                                                            "Private room", "Shared room")))

# Save cleaned data
write_csv(df_cleaned,file="../../gen/data-preparation/temp/data_cleaned.csv")
