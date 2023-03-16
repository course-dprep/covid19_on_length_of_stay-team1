# load 
library(readr)
library(dplyr)
library(broom)
library(ggplot2)
library(ggpubr)
df_cleaned <- read_csv("../../gen/data-preparation/output/data_no_outliers.csv")

# Inspecting means of minimum nights of stay before running regressions
df_cleaned %>% group_by(year_scraped) %>% summarize(mean=mean(minimum_nights))

# most basic model
m0 <- lm(minimum_nights ~ covid, df_cleaned)
summary(m0)

# Estimate simple model
m1 <- lm(minimum_nights ~ covid + as.factor(neighbourhood_num) + as.factor(roomtype_num) + accommodates + price + instant_bookable, df_cleaned)
summary(m1)

df_m1 <- tidy(m1)
         
# Independence (Marijn)

# Homoskedasticity (Matthijs)

# Normality of residuals (Jonas)
residuals <- resid(m1)
residuals_df <- data.frame(residuals = residuals)

## Create random subsample of 1000 observations, so we are able to run a Shapiro-Wilk normality test (5000 is the maximum sample size)
set.seed(123)
my_subsample <- residuals_df[sample(nrow(residuals_df), 5000), ]
shapiro.test(my_subsample)

## Test for normality of residuals with a histogram
ggplot(residuals_df, aes(x = residuals)) + 
  geom_histogram(binwidth = 0.5, color = "black", fill = "white") + 
  xlab("Residuals") + ylab("Frequency") +
  ggtitle("Histogram of Residuals")

hist(residuals_df$residuals, breaks = 100)

## Test for normality of residuals with a density plot
ggdensity(residuals_df$residuals, 
          main = "Density plot of residuals",
          xlab = "residuals")

## Test for normality with a Q-Q plot
qqnorm(residuals)
qqline(residuals)

## Overall, we can conclude there is non-normality for the residuals of our regression. 
## Up until a certain value, there is normality of residuals, but high outliers cause it to be non-normal
## Since it are only the high extremes that are not normal, we take no measures against non-normality of our residuals.

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