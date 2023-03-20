all: analysis paper

data-preparation:
	make -C src/data-preparation

analysis: data-preparation
	make -C src/analysis
	
paper: data-preparation analysis
	make -C src/paper
	
clean:
	find . -type f -name "*.pdf" -delete
	find . -type f -name "*.csv" -delete
	find . -type f -name "*.csv.gz" -delete
	find . -type f -name "*.html" -delete

