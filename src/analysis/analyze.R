# load 
library(readr)
read_csv("../../gen/data-preparation/output/data_no_outliers.csv")

# Inspecting means of minimum nights of stay before running regressions
df_cleaned_2020 <- df_cleaned %>% filter(grepl("2020", df_cleaned$last_scraped))
mean(df_cleaned_2020$minimum_nights)
df_cleaned_2022 <- df_cleaned %>% filter(grepl("2022", df_cleaned$last_scraped))
mean(df_cleaned_2022$minimum_nights)

# most basic model
m0 <- lm(minimum_nights ~ covid, df_cleaned)
summary(m0)
         
# Independence (Marijn)

# Homoskedasticity (Matthijs)

# Normality (Jonas)

# Linearity (Dianne)
# create a boxplot to check for linearity
boxplot(covid ~ minimum_nights, data = df_cleaned)

# Estimate simple model
m1 <- lm(minimum_nights ~ covid + as.factor(neighbourhood_num) + as.factor(roomtype_num) + accommodates + price + instant_bookable, df_cleaned)
summary(m1)
df_m1 <- tidy(m1)

# Multicollinearity (Matthijs)

# Running the simple model again with possible changes (Jonas)

# Save results
write_csv(df_m1,file="../../gen/analysis/output/model_results.csv")