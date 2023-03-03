library(tidyverse)

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
