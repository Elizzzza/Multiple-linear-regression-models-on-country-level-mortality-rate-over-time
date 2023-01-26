# Apply multiple linear regression models to study how county-level mortality rates vary over time and are associated with gender and age
#### BIOST 515/518 Assignment 6
#### Instructor:  Amy Willis

## Background

The Centers for Disease Control and Prevention maintain a variety of online databases of public-health data through the WONDER database (“Wide-ranging ONline Data for Epidemiologic Research”), including data on births and deaths, sexually transmitted diseases, heatwaves and air pollution. More information on the database is available at https://wonder.cdc.gov/.

## Dataset
We will model mortality rates among 55+ year olds in counties in Washington state. A subset of the WONDER data is available in the file cdc-wonder-wa.csv. 
The variables in this dataset are as follows:
- ***county***: Name of the county in Washington
- ***gender***: “Male” or “Female”
 *For reasons unknown to me (Amy), the CDC WONDER database refers to biological sex data as gender, despite these concepts being distinct in ways that are important to acknowledge and validate (you can learn more at http://www.genderdiversity.org/). Somewhat surprisingly, different CDC Divisions treat sex and gender labels differently. For example, the Division of Adolescent and School Health distinguishes sex and gender identity, but WONDER does not.*
- ***age***: 10-year age group (55-64 years, 65-74 years, 75-84 years, 85+)
- ***year***: Year, ranging from 2010–2019
- ***deaths***: number of deaths (for that county, sex, age, and year)
- ***pop***: an estimate of the age- and sex-stratified population size in the county in the middle of the year.
 *For example, the CDC believed there to be 545 female 65-74 year-olds in Adams County in 2014.*

## Questions
Reminder: As with most statistical and data-analytic questions, there many possible excellent
responses to all of these questions. Stated differently, there is not a single answer that we
are “looking for” in this (or any) BIOST 515/518 homework. If you are unsure whether your
proposed models or interpretations are reasonable, we would love to talk with you about them
at office hours!

1. For this homework, we are interested in modeling how county-level mortality rates vary over time and
are associated with gender and age. Present a visualisation to help you understand your data in the
context of this scientific question.
2. Fit an appropriate regression model to investigate the association between county-level mortality rates
with gender, age, and time. Write out the fitted model and interpret all estimated coefficients. For
multi-level categorical covariates, please interpret a coefficient associated with just one level of the
categories – but please interpret one level for each multi-level categorical covariate.
3. Based on your model from (2), is there evidence that mortality rates are changing over time? Justify
your answer.
4. A colleague tells you that trends in mortality rates over time are typically different for different age
groups. With this information in mind, fit a new regression model to investigate the association between
county-level mortality rates with gender, age, and time. Do you believe the claim that your colleague
made? Provide a statistical justification for your answer.
5. You may have noticed that not all county-gender-year-age tabulation groups are present. For example,
there is no row in the data for Adams County, WA females aged 55-64 years in 2010. To protect
against the potential disclosure of personal health information, all publicly available data from the
CDC WONDER database suppresses counts that are fewer than a given threshold. Based on looking at
the data, what is this threshold? How many rows in the dataset have been suppressed because of low
counts?
6. What effect do you believe the suppression of observations may have on the estimates from our model
in part (2)? What about the model in part (4)? Justify your answers.
7. In this class, we have talked about the importance of observations being independent for obtaining
reasonable estimates and valid statistical inference. Comment on the reasonableness of this assumption
in your above analyses.
