# load 
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

# Estimate simple model
m1 <- lm(minimum_nights ~ covid + as.factor(neighbourhood_num) + as.factor(roomtype_num) + accommodates + price + instant_bookable, df_cleaned)
summary(m1)

# Multicollinearity (Matthijs)

# Running the simple model again with possible changes (Jonas)

# Save results
save(m1,file="../../gen/analysis/output/model_results.RData")