# load packages
library(readr)
library(dplyr)
library(broom)
library(ggplot2)
library(ggpubr)
library(lmtest)
df_cleaned <- read_csv("../../gen/data-preparation/output/data_no_outliers.csv")

# Inspecting means of minimum nights of stay before running regressions
df_cleaned_2020 <- df_cleaned %>% filter(grepl("2020", df_cleaned$last_scraped))
mean(df_cleaned_2020$minimum_nights)
df_cleaned_2022 <- df_cleaned %>% filter(grepl("2022", df_cleaned$last_scraped))
mean(df_cleaned_2022$minimum_nights)

# most basic model
m0 <- lm(minimum_nights ~ covid, df_cleaned)
summary(m0)

# Estimate simple model
m1 <- lm(minimum_nights ~ covid + as.factor(neighbourhood_num) + as.factor(roomtype_num) + accommodates + price + instant_bookable, df_cleaned)
summary(m1)
df_m1 <- tidy(m1)
         
# Independence 
# create a scatterplot of the residuals against the predicted values from the linear regression model 'm1'
plot(m1$fitted.values, m1$residuals, 
     xlab = "Fitted Values", ylab = "Residuals", 
     main = "Residuals vs. Fitted Values Plot",
     ylim = c(-50, 60))
# add a horizontal line at y = 0 to the plot to help visualize the residuals that are close to zero
abline(h = 0, lty = 2, col = 'red')

# Add predicted values to the data frame
df_cleaned$predicted <- predict(m1)

# Create a scatterplot of predicted vs actual values
ggplot(df_cleaned, aes(x = predicted, y = minimum_nights)) +
  geom_point() + # adds points to the plot
  geom_abline(intercept = 0, slope = 1, color = "red") + # adds a diagonal line to the plot to visualize where predicted = actual
  xlab("Predicted Values") + # adds a label for the x-axis
  ylab("Actual Values") + # adds a label for the y-axis
  ggtitle("Predicted vs Actual Values Plot") # adds a title to the plot

# perform Durbin-Watson test
dwtest(m1)

# We can conclude that there is no independence of the residuals.
# The null hypothesis states that the errors are not auto-correlated with themselves (they are independent).
# With the Durbin-Watson test we achieved a p-value < 0 which means that we would reject the null hypothesis.
 
# Homoskedasticity
# use the same code as in the independence assumption:
plot(m1$fitted.values, m1$residuals, 
     xlab = "Fitted Values", ylab = "Residuals", 
     main = "Residuals vs. Fitted Values Plot",
     ylim = c(-50, 60))
abline(h = 0, lty = 2, col = 'red')
df_cleaned$predicted <- predict(m1)
ggplot(df_cleaned, aes(x = predicted, y = minimum_nights)) +
  geom_point() + # adds points to the plot
  geom_abline(intercept = 0, slope = 1, color = "red") + # adds a diagonal line to the plot to visualize where predicted = actual
  xlab("Predicted Values") + # adds a label for the x-axis
  ylab("Actual Values") + # adds a label for the y-axis
  ggtitle("Predicted vs Actual Values Plot") # adds a title to the plot
## the spread of residuals is not consistent across all values of the predictor variables
## the homoscedasticity assumption is therefore not met
# to provide more evidence that this assumption is not met we use the Breusch-Pagan test
bptest(m1)
## the p-value of this test is < 0.05 which means that the homoscedasticity assumption is not met

# Normality of residuals 
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

# Linearity
# take a part of the same code of the independence assumption
# create a scatterplot of the residuals against the predicted values from the linear regression model 'm1'
plot(m1$fitted.values, m1$residuals, 
     xlab = "Fitted Values", ylab = "Residuals", 
     main = "Residuals vs. Fitted Values Plot",
     ylim = c(-50, 60))
# add a horizontal line at y = 0 to the plot to help visualize the residuals that are close to zero
abline(h = 0, lty = 2, col = 'red')

## looking at the scatterplot we can conclude that there is no linearity
## The scatter of points around the horizontal line at y=0 are not random
## this means that the residuals are not distributed evenly around the fitted values

# Estimate simple model
m1 <- lm(minimum_nights ~ covid + as.factor(neighbourhood_num) + as.factor(roomtype_num) + accommodates + price + instant_bookable, df_cleaned)
summary(m1)
df_m1 <- tidy(m1)

# Multicollinearity
# VIF test 
detach("package:dplyr", unload=TRUE)
library(car)
m1 <- lm(minimum_nights ~ covid + as.factor(neighbourhood_num) + as.factor(roomtype_num) + accommodates + price + instant_bookable, df_cleaned)
vif(m1)

# correlation matrix
cor(df_cleaned[c("covid", "neighbourhood_num", "roomtype_num", "accommodates", "price", "instant_bookable")])

# eigenvalues and condition number 
eigen(cor(df_cleaned[c("covid", "neighbourhood_num", "roomtype_num", "accommodates", "price", "instant_bookable")]))$values
kappa(model.matrix(m1))

## Looking at the VIF values we can conclude that there is no significant multicollinearity among the predictor variables
## All the VIF values are around 1 where generally VIF values between 5 and 10 indicate significant multicollinearity

# Running the simple model again with possible changes (Jonas)

# Save results
write_csv(df_m1,file="../../gen/analysis/output/model_results.csv")
