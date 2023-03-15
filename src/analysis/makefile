OUTPUT = ../../gen/data-preparation/output
ANALYSIS = ../../gen/analysis/output

all: $(ANALYSIS)/model_results.csv 

$(ANALYSIS)/model_results.csv: $(OUTPUT)/data_no_outliers.csv analyze.R 
	R --vanilla < analyze.R