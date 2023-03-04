# Load datasets into R 
df2020 <- read.csv(gzfile("./gen/data-preparation/input/dataset2020.csv.gz"))
df2022 <- read.csv(gzfile("./gen/data-preparation/input/dataset2022.csv.gz"))

# Merge on id
df_merged <- rbind(df2020, df2022)

# Save merged data
save(df_merged,file="./gen/data-preparation/temp/data_merged.RData")