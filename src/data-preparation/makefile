DATA = ../../data
TEMP = ../../gen/data-preparation/temp
OUTPUT = ../../gen/data-preparation/output

all: $(DATA)/dataset2020.csv.gz $(DATA)/dataset2022.csv.gz $(OUTPUT)/data_no_outliers.csv

$(DATA)/dataset2020.csv.gz $(DATA)/dataset2022.csv.gz: download_data.R
		mkdir -p ../../data
		R --vanilla < download_data.R
    
$(TEMP)/data_merged.csv: merge_data.R $(DATA)/dataset2020.csv.gz $(DATA)/dataset2022.csv.gz
		R --vanilla < merge_data.R

$(TEMP)/data_cleaned.csv: clean_data.R $(TEMP)/data_merged.csv
		R --vanilla < clean_data.R
		
$(OUTPUT)/data_no_outliers.csv: remove_outliers.R $(TEMP)/data_cleaned.csv
		R --vanilla < remove_outliers.R


