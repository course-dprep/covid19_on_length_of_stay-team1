all: ../../Report.pdf

../../Report.pdf: Report.Rmd
	R --vanilla -e "rmarkdown::render('Report.Rmd', output_file = '../../Report.pdf')"