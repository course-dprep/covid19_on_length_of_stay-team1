# COVID-19 Impact on length of stay Airbnb in Amsterdam

*What is the impact of COVID-19 on the minimum days of stay in Airbnb rooms in Amsterdam?*

## Motivation
The COVID-19 pandemic has had a significant impact on the travel and tourism industry, with many countries implementing travel restrictions and lockdown measures to control the spread of the virus. Amsterdam, as a popular tourist destination, has been affected by these measures, with a sharp decline in the number of visitors to the city. This has had a ripple effect on the hospitality industry, including the rental market for Airbnb rooms.

The research question *"What is the impact of COVID-19 on the minimum days of stay in Airbnb rooms in Amsterdam?"* is important to investigate as it addresses a gap in our understanding of how the pandemic has affected the short-term rental market in the city. The minimum days of stay is an important metric for understanding the rental market, as it reflects both supply and demand for short-term accommodation. By examining how the minimum days of stay have changed during the pandemic, we can gain insight into how the rental market has adapted to the new reality of travel restrictions and social distancing measures.
Besides, there is a contradictory literature towards the affects of COVID-19 on the minimum nights per stay. A recent article in the New York Times has presented data suggesting that minimum night requirements for Airbnb stays in New York City were significantly higher during the COVID-19 pandemic compared to after the pandemic. However, Kourtit et al., have put forward a different perspective, suggesting that minimum night requirements actually decreased during the pandemic as hosts reduced these requirements to encourage more bookings. As such, there is a need to conduct further research to ascertain the true effect of COVID-19 on minimum night requirements. To address this research gap, an investigation will be conducted on an European city, as existing studies have primarily focused on the United States. We choose Amsterdam as an example of an European city, since we all are Dutch inhabitants.

## Method and Results
#### **Method**
To address our research question, we decided to run a linear regression on the variables of interest. The dependent variable in our research is the minimum nights of stay and our independent variable is the presence of COVID-19, which gets assigned either the value 0 or 1. We have collected data from 2020 and from 2022: all the data from 2020 is assigned to the value 1, and all the data from 2022 is assigned to the value 0. We decided to not only include the minimum nights of stay and the presence of COVID-19, but also added some control variables to our analysis, to see if there are other effects that might play a role. Since these control variables are differing in metric and non-metric variables, we have chosen linear regression over an ANOVA-analysis.

#### **Results**
After we runned the linear regression, we decided to check the assumptions for a linear regression, to see if we could draw meaningful conclusions about our data. Following from our results the assumptions were unfortunately not met. This makes it hard to draw decent conclusions about the linear regression. To get a better look at the all the created plots and runned tests to check the assumptions, we recommend to take a look at our final presentation.
Further research could look into the data and try to meet the assumptions to eventually draw some meaningful conclusions. Another way is to conduct an ANOVA-analysis, leaving some of the control variables out and see if these lead to meaningful conclusions about the data.

## Repository Overview
```
├── README.md
├── makefile
├── .gitignore
├── install_packages.R
├── data
├── gen
│   ├── analysis
│   ├── data-preparation
│   └── paper
└── src
    ├── analysis
    ├── data-preparation
    └── paper
```

## Dependencies
Please follow the installation guides on https://tilburgsciencehub.com
- R 
  - [Installation Guide](https://tilburgsciencehub.com/building-blocks/configure-your-computer/statistics-and-computation/r/)
- Make
  - [Installation Guide](https://tilburgsciencehub.com/building-blocks/configure-your-computer/automation-and-workflows/make/)
- Quarto
  - [Installation Guide](https://quarto.org/docs/get-started/)

To install all necessary packages used in R, run the R script `install_packages.R`, which is added to our repository. Otherwise, install the following packages:
```
install.packages("readr")
install.packages("tidyverse")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("broom")
install.packages("ggpubr")
install.packages("lmtest")
install.packages("quarto")
```
## Running Instructions
#### **Running The Code By Make**
To run the code, follow these instructions:
1. Fork this repository
2. Open your command line/terminal and run the following code:
```
git clone https://github.com/{your username}/covid19_on_length_of_stay-team1.git
```
3. Set your working directory to `covid19_on_length_of_stay-team1` and run the following command:
```
make
```
4. When make has successfully run all the code, it will generate a HTML with the presentation of our analysis. 
5. To clean the data of all raw and unnecessary data files created during the pipeline, run the following code in the command line/terminal: 
```
make clean
```

#### **Alternative Route**
An alternative route to run the code would be:
1. ../src/data-preparation -> download_data.R
2. ../src/data-preparation -> merge_data.R
3. ../src/data-preparation -> clean_data.R
4. ../src/data-preparation -> remove_outliers.R
5. ../src/analysis -> analyze.R
6. ../src/paper -> Presentation.qmd

## Resources
- Kolomatsky, M. (2021, 15 augustus). AirBnb and the Pandemic. The New York Times. https://www.nytimes.com/2021/07/15/realestate/what-happened-to-airbnb-during-the-pandemic.html
- Kourtit, K., Nijkamp, P., Östh, J., & Türk, U. (2022). Airbnb and COVID-19: SPACE-TIME vulnerability effects in six world-cities. Tourism Management, 93, 104569. https://doi.org/10.1016/j.tourman.2022.104569

## About
This respository was made by [Jonas Klein](https://github.com/KleinJonasUVT), [Matthijs van Gils](https://github.com/MatthijsvanGils), [Marijn Bransen](https://github.com/marijnbransen1998) and [Dianne Burgess](https://github.com/DianneBurgess) and was commissioned by [Hannes Datta](https://github.com/hannesdatta), proffesor at Tilburg University as part of the course 'Data Preparation and Workflow Management'.

