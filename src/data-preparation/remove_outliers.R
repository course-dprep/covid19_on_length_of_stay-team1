# Load cleaned data 
library(readr)
library(ggplot2)
df_cleaned <- read_csv("../../gen/data-preparation/temp/data_cleaned.csv")

# Remove outliers for all relevant columns
col_list <- c('minimum_nights', 'price') # create a list of column names

# loop over the column list
for (col_name in col_list) {
  
  # detect outliers of the current column
  z_scores <- scale(df_cleaned[[col_name]])
  outliers <- abs(z_scores) > 3
  df_outliers <- df_cleaned[outliers,]
  
  # remove outliers of the current column
  df_cleaned <- df_cleaned[!outliers,]
  
  # histogram of the current column values after removal of outliers
  plot <- ggplot(df_cleaned, aes(x = .data[[col_name]])) + 
    geom_histogram(binwidth = 1, fill = "steelblue", color = "black") + 
    ggtitle(paste("Histogram of", col_name)) + 
    xlab("Value") + 
    ylab("Frequency")
  
  # print the plot
  print(plot)
  
}

# make sure outliers are removed for both 2020 and 2022
listings_both_years_2 <- duplicated(df_cleaned$listing_url) | duplicated(df_cleaned$listing_url, fromLast = TRUE)
df_cleaned <- subset(df_cleaned, listings_both_years_2)

df_cleaned$year_scraped = ''
df_cleaned[grepl('2020', df_cleaned$last_scraped),]$year_scraped <- '2020'
df_cleaned[grepl('2022', df_cleaned$last_scraped),]$year_scraped <- '2022'
df_cleaned$year_scraped <- as.numeric(df_cleaned$year_scraped)

write_csv(df_cleaned,file="../../gen/data-preparation/output/data_no_outliers.csv")