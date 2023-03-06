# Load the readr package
library(readr)

# Load datasets into R 
df2020 <- read_csv(gzfile("../../data/dataset2020.csv.gz"))
df2022 <- read_csv(gzfile("../../data/dataset2022.csv.gz"))

# Merge on id
cols1 = colnames(df2020)
cols2 = colnames(df2022)

cols = intersect(cols1, cols2)

df_merged <- rbind(df2020[, cols], df2022[, cols])

# Save merged data
write_csv(df_merged, "../../gen/data-preparation/temp/data_merged.csv")
