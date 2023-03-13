# Notes: 
# - If run on unix system, use rm instead of del command in clean  
# - Careful with spaces! If use \ to split to multiple lines, cannot have a space after \ 

# OVERALL BUILD RULES
all: data_cleaned results
data_cleaned: ../../gen/data-preparation/output/data_no_outliers.csv
results: ../..gen/analysis/output/model_results.csv
.PHONY: clean

# INDIVIDUAL RECIPES

# Run analysis  
../../gen/analysis/output/model_results.csv: gen/data-preparation/output/data_no_outliers.csv \
						src/analysis/analyze.R
	Rscript src/analysis/analyze.R
	
# Remove outliers
../../gen/data-preparation/output/data_no_outliers.csv: gen/data-preparation/temp/data_cleaned.csv \
						src/data-preparation/remove_outliers.R 
	Rscript src/data-preparation/remove_outliers.R 

# Clean data
../../gen/data-preparation/temp/data_cleaned.csv: gen/data-preparation/temp/data_merged.csv \
						src/data-preparation/clean_data.R 
	Rscript src/data-preparation/clean_data.R 
	
# Merge data
../../gen/data-preparation/temp/data_merged.csv: data/dataset2020.csv.gz \
						data/dataset2022.csv.gz \
						src/data-preparation/merge_data.R
	Rscript	src/data-preparation/merge_data.R

# Download data
../../data/dataset2020.csv.gz ../../data/dataset2022.csv.gz: src/data-preparation/download_data.R 
	Rscript src/data-preparation/download_data.R 

# Clean-up: Deletes temporary files
# Note: Using R to delete files keeps platform-independence. 
# 	    --vanilla option prevents from storing .RData output
clean: 
	Rscript --vanilla src/clean-up.R
	
