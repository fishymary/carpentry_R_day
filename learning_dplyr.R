# Learning dplyr
# afternoon Day 2, March 23, 2019

# install and load the package
# install.packages('dplyr')
library(dplyr)
library(ggplot2)

# import data
gapminder <- read.csv("/Users/MaryAir/Desktop/r_carpentry/data/gapminder_data.csv")

head(gapminder)

# select function
# choosing specific columns
gap_yr_gdp <- gapminder %>% select(year,gdpPercap)
head(gap_yr_gdp)

# filter function
# choose specific rows
gap_1960s <- gapminder %>% filter(year >= 1960 & year < 1970)
nrow(gap_1960s)
head(gap_1960s)

# using multiple dplyr functions together
gap_yr_gdp_1960s <- gapminder %>% 
  select(year,gdpPercap) %>% 
  filter(year >= 1960 & year < 1970)
head(gap_yr_gdp_1960s)

# Challenge 1
# Write a single command (which can span multiple lines and includes pipes) that will produce a dataframe that has the African values for lifeExp, country and year, but not for other Continents. How many rows does your dataframe have and why?

gap_africa_only <- gapminder %>% 
  filter(continent == "Africa") %>% 
  select(lifeExp,country,year)
head(gap_africa_only)
tail(gap_africa_only)
nrow(gap_africa_only)
str(gap_africa_only)

# summarising data
gdp_by_continent <- gapminder %>% 
  group_by(continent,year) %>% 
  summarise(mean_gdp = mean(gdpPercap), sd_gdp = sd(gdpPercap))
gdp_by_continent

# mutate function
# add new columns that are functions of the other columns
gdp_pop <- gapminder %>% 
  mutate(gdp_billions = (gdpPercap*pop)/10^9)
head(gdp_pop)

# string with ggplot
gapminder %>% 
  mutate(gdp_billions = (gdpPercap*pop)/10^9) %>% 
  group_by(continent,year) %>% 
  summarise(mean_gdp_bill = mean(gdp_billions)) %>% 
  ggplot(aes(x=year,y=mean_gdp_bill,color=continent)) + geom_point()
