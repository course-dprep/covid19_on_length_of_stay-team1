OUTPUTP = ../../gen/paper/output

all: $(OUTPUTP)/Report.pdf

$(OUTPUTP)/Report.pdf: Report.Rmd
	R --vanilla -e "rmarkdown::render('Report.Rmd', output_file = '$(OUTPUTP)/Report.pdf')"