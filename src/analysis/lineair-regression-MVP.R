# Load the necessary packages
library(tidyverse)
library(stats)
library(dplyr)
library(ggplot2)

# Loading in the data for December 2020:
url <- 'https://github.com/course-dprep/SickAirbnbPricesAcrossNetherlands/raw/main/Data/listings-12.20.csv.gz'
filename <- 'listings-12.20.csv.gz'
download.file(url, destfile = filename)
listings12.20_df <- read_csv(gzfile(filename))


url <- 'http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2022-12-05/data/listings.csv.gz'
filename <- 'listings-12.22.csv.gz'
download.file(url, destfile = filename)
listings12.22_df <- read_csv(gzfile(filename))
listings12.22_df$source <- NULL

# merge the two data frames using rbind
merged_df <- rbind(listings12.20_df, listings12.22_df)

# filter to keep only airbnb's in Amsterdam
df_amsterdam <- merged_df[grepl("(?i)amsterdam", merged_df$host_location, ignore.case = TRUE),]

df_cleaned <- select(df_amsterdam, 
                     id, last_scraped, host_since, host_location, host_acceptance_rate, 
                     neighbourhood_cleansed, room_type, accommodates)


# Keep only the important variables for our analysis
df_cleaned <- merged_df %>% select(id, listing_url, last_scraped, host_since, 
                                   host_location, host_acceptance_rate, host_is_superhost,
                                   neighbourhood_cleansed, room_type, 
                                   accommodates, price, minimum_nights, 
                                   availability_30, instant_bookable)

# Change variable types to be able to use them for analysis and subsetting
df_cleaned$price <- gsub("\\$", "", df_cleaned$price)
df_cleaned$price <- gsub(",", "", df_cleaned$price)
df_cleaned$host_acceptance_rate <- gsub("\\%", "", df_cleaned$host_acceptance_rate)

df_cleaned$host_acceptance_rate <- ifelse(is.na(df_cleaned$host_acceptance_rate), NA, as.numeric(df_cleaned$host_acceptance_rate))
df_cleaned$accommodates <- as.numeric(df_cleaned$accommodates)
df_cleaned$price <- as.numeric(df_cleaned$price)
df_cleaned$minimum_nights <- as.numeric(df_cleaned$minimum_nights)
df_cleaned$availability_30 <- as.numeric(df_cleaned$availability_30)

# check out the variables
## numeric values
summary(df_cleaned$host_acceptance_rate)
summary(df_cleaned$price)
summary(df_cleaned$accommodates)
summary(df_cleaned$minimum_nights)
summary(df_cleaned$availability_30)

## character values
table(df_cleaned$host_location)
table(df_cleaned$host_is_superhost)
table(df_cleaned$neighbourhood_cleansed)
table(df_cleaned$room_type)
table(df_cleaned$instant_bookable)

# Make sure the airbnb is located in Amsterdam
df_cleaned <- df_cleaned %>%
  filter(grepl("Amsterdam", host_location) | grepl("amsterdam", host_location)) %>%
  filter(host_location != "Amsterdam, New York, United States", 
         host_location != "Athens, Amsterdam & Brussels",
         host_location != "Nieuw Amsterdam, Drenthe, Netherlands")

# detect and remove outliers of price
z_scores_price <- scale(df_cleaned$price)
outliers_price <- abs(z_scores_price) > 3
df_outliers_price <- df_cleaned[outliers_price,]
df_cleaned <- df_cleaned[!outliers_price,]

# histogram of price values after removal of outliers
ggplot(df_cleaned, aes(x = price)) + 
  geom_histogram(binwidth = 1, fill = "steelblue", color = "black") + 
  ggtitle("Histogram of Price") + 
  xlab("Value") + 
  ylab("Frequency")

# detect and remove outliers of minimum nights of stay
z_scores_minimum <- scale(df_cleaned$minimum_nights)
outliers_minimum <- abs(z_scores_minimum) > 3
df_outliers_minimum <- df_cleaned[outliers_minimum,]
df_cleaned <- df_cleaned[!outliers_minimum,]

# histogram of minimum nights of stay after removal of outliers
ggplot(df_cleaned, aes(x = minimum_nights)) + 
  geom_histogram(binwidth = 1, fill = "steelblue", color = "black") + 
  ggtitle("Histogram of Minimum nights") + 
  xlab("Minimum nights") + 
  ylab("Frequency")

# Inspect data, create dummy variable for presence of Covid19:


# Build the linear regression model
model <- lm(minimum_nights ~ host_is_superhost + neighbourhood_cleansed + room_type + accommodates + price + availability_30 + instant_bookable, df_cleaned)

# Display information about the model
summary(model)



