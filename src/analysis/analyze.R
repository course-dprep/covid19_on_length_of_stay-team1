install.packages("haven")
install.packages("dplyr")
install.packages("car")
install.packages("ggplot2")
library(haven)
library(dplyr)
library (car)
library(ggplot2)
library(readr)


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
m0 <- lm(minimum_nights ~ covid, df_cleaned)
plot(m0, which = 1)

# Normality (Jonas)

# Linearity (Dianne)

# Estimate simple model
m1 <- lm(minimum_nights ~ covid + as.factor(neighbourhood_num) + as.factor(roomtype_num) + accommodates + price + instant_bookable, df_cleaned)
summary(m1)

# Multicollinearity (Matthijs)

  # VIF test 
library(car)
m1 <- lm(minimum_nights ~ covid + as.factor(neighbourhood_num) + as.factor(roomtype_num) + accommodates + price + instant_bookable, df_cleaned)
vif(m1)

  # correlation matrix
cor(df_cleaned[c("covid", "neighbourhood_num", "roomtype_num", "accommodates", "price", "instant_bookable")])

  # eigenvalues and condition number 
eigen(cor(df_cleaned[c("covid", "neighbourhood_num", "roomtype_num", "accommodates", "price", "instant_bookable")]))$values
kappa(model.matrix(m1))


# Running the simple model again with possible changes (Jonas)

# Save results
save(m1,file="../../gen/analysis/output/model_results.RData")