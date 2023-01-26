# load package and dataset 
library(knitr)
library(tidyverse)
library(rigr)
wonder <- read_csv("cdc-wonder-wa.csv")

# Q1
# Visualisation of how county-level mortality rates vary over time and 
# associated with gender and age

# Change type of gender and age to factor variables
wonder <- wonder %>%
        mutate(gender = as.factor(gender)) %>% 
        mutate(age = as.factor(age)) 
# Scatterplot of number of deaths vs. population size by gender and age group
wonder %>% 
        ggplot(aes(x = log(pop), y = log(deaths)))+
        geom_point() +
        facet_wrap(c("gender","age"), scales="free", nrow=2) +
        labs (y = "Log Number of deaths", x = "Log Population size") +
        xlim (1, 15) +
        ylim(1, 8) +
        theme_bw() 
# Scatterplot of number of deaths vs. year ranging from 2010-2019 by age groups
wonder %>% 
        ggplot(aes(x = as.factor(year), y = deaths, col=age), alpha = 0.5) +
        geom_point() +
        labs (y = "Number of deaths", x = "Year") +
        theme_bw() 
# Gender and age-stratified mortality rates over time for Washington State counties. Loess-smoothed
# mortality rates over all counties are shown.
wonder %>%
        mutate(rate = deaths/pop) %>%
        mutate(category = paste(age, gender, sep = ", ")) %>%
        group_by(county, gender, age) %>%
        ggplot(aes(x = year, y = rate)) +
        geom_smooth(span=1) +
        ylab("Empirical mortality rate\n(deaths per year)") +
        scale_x_continuous(breaks = c(2010, 2012, 2014, 2016, 2018, 2020)) +
        theme_bw() +
        xlab("") +
        theme(strip.text = element_text(size = 7)) +
        theme(axis.text.x=element_text(angle=45, hjust=1),
              legend.position="none") +
        facet_wrap(~category, scales="free", nrow=2, dir="v") +
        NULL
# Q2
# Here's a Poisson regression model for wonder dataset using rigr:regress
# mortality rate as response and time, gender, age group as predictors
mod1 <- regress("rate", 
                deaths ~ age + gender + as.numeric(year), 
                data = wonder, 
                offset = log(pop))
mod1
# Alternative way to fit Poisson regression model for wonder dataset using glm
# mortality rate as response and time, gender, age group as predictors
mod2 <- glm(deaths ~ year + gender + age,
            family = poisson(link = "log"),
            data = wonder,
            offset = log(pop))  
mod2 %>% summary %>% coef %>% round(3)

# Q3
# Here's the coefficient of Poisson model for wonder dataset using rigr:regress
mod1 %>% coef %>% round(3)
# Alternative way: coefficients of Poisson model for wonder dataset using glm
mod2 %>% summary %>% coef %>% round(3) 
mod2 %>% 
        confint(parm = "year") %>% 
        exp %>%  signif(3)

# Q4 
# Here's the coefficient of Poisson model for wonder dataset using rigr:regress
# mortality rate as response, time, gender as predictors, and age group as effect modifier
mod3 <- regress("rate", 
                deaths ~ gender + as.numeric(year)*age, 
                data = wonder, 
                offset = log(pop))
mod3
# Alternative way to fit Poisson regression model for wonder dataset using glm
# mortality rate as response, time, gender as predictors, age group as effect modifier
mod4 <- glm(deaths ~ gender + age*year,
            family = poisson(link = "log"),
            data = wonder,
            offset = log(pop))  
mod4 %>% summary %>% coef %>% round(3)
# Run ANOVA test
anova(mod2, mod4, test = "LRT")

# Q5
# Sort wonder dataset by deaths in ascending order
wonder %>% arrange(deaths)
# Looking at the structure of wonder dataset
str(wonder)

# Q6
# Filter for all rows with 10 death counts
wonder_1 <- wonder %>% 
        mutate(county=as.factor(county)) %>% 
        filter(deaths == 10)
wonder_1

