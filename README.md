# Covid-19 Impact on length of stay Airbnb in Amsterdam

*What is the impact of COVID-19 on the minimum days of stay in Airbnb rooms in Amsterdam?*


## Motivation
The COVID-19 pandemic has had a significant impact on the travel and tourism industry, with many countries implementing travel restrictions and lockdown measures to control the spread of the virus. Amsterdam, as a popular tourist destination, has been affected by these measures, with a sharp decline in the number of visitors to the city. This has had a ripple effect on the hospitality industry, including the rental market for Airbnb rooms.

The research question *"What is the impact of Covid-19 on the minimum days of stay in Airbnb rooms in Amsterdam?"* is important to investigate as it addresses a gap in our understanding of how the pandemic has affected the short-term rental market in the city. The minimum days of stay is an important metric for understanding the rental market, as it reflects both supply and demand for short-term accommodation. By examining how the minimum days of stay have changed during the pandemic, we can gain insight into how the rental market has adapted to the new reality of travel restrictions and social distancing measures.
Besides, there is a contradictory literature towards the affects of COVID-19 on the minimum nights per stay.A recent article in the New York Times has presented data suggesting that minimum night requirements for Airbnb stays in New York City were significantly higher during the COVID-19 pandemic compared to after the pandemic. However, Kourtit et al., have put forward a different perspective, suggesting that minimum night requirements actually decreased during the pandemic as hosts reduced these requirements to encourage more bookings. As such, there is a need to conduct further research to ascertain the true effect of COVID-19 on minimum night requirements. To address this research gap, an investigation will be conducted on an European city, as existing studies have primarily focused on the United States.We choose Amsterdam as an example of an European city since we all are Dutch inhabitants.

## Method and results

First, introduce and motivate your chosen method, and explain how it contributes to solving the research question/business problem.

Second, summarize your results concisely. Make use of subheaders where appropriate.


## Repository overview

Provide an overview of the directory structure and files, for example:

```
├── README.md
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

## Running Instructions
### Running The Code By Make
To run the code, follow these instructions:
1. Fork this repository
2. Open your command line/terminal and run the following code:
```
git clone https://github.com/{your username}/covid19_on_length_of_stay-team1.git
```
3. Set your working directory to 'covid19_on_length_of_stay-team1' and run the following command:
```
make
```
4. When make has succesfully run all the code, it will generate a ... 
5. To clean the data of all raw and unnecessary data files created during the pipeline, run the following code in the command line / terminal: 
```
make clean
```

### Alternative Route
An alternative route to run the code would be:
1. ../src/data-preparation -> download_data.R
2. ../src/data-preparation -> merge_data.R
3. ../src/data-preparation -> remove_outliers.R
4. ../src/data-preparation -> clean_data.R
5. ../src/analysis -> analyze.R


## More resources
- Kolomatsky, M. (2021, 15 augustus). AirBnb and the Pandemic. The New York Times. https://www.nytimes.com/2021/07/15/realestate/what-happened-to-airbnb-during-the-pandemic.html
- Kourtit, K., Nijkamp, P., Östh, J., & Türk, U. (2022). Airbnb and COVID-19: SPACE-TIME vulnerability effects in six world-cities. Tourism Management, 93, 104569. https://doi.org/10.1016/j.tourman.2022.104569


## About
This respository was made by Jonas Klein, Matthijs van Gils, Marijn Bransen and Dianne Burgess and was commissioned by Hannes Datta, proffesor at Tilburg University.

