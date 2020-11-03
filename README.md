
<!-- README.md is generated from README.Rmd. Please edit that file -->

# CovidRaceData

<!-- badges: start -->

![R-CMD-check](https://github.com/Oliver-BE/CovidRaceData/workflows/R-CMD-check/badge.svg)
<!-- badges: end -->

The `CovidRaceData` package contains two data sets on the COVID-19
pandemic in the US by race/ethnicity. More specifically, it has data for
the number of COVID-19 cases and deaths by race/ethnicity for each
state. The raw data set (which is titled `covid_race_data_raw` in this
package) was obtained from [The COVID Tracking
Project](https://covidtracking.com/race/about#download-the-data) and the
`aggregated_covid_race_df` contains information on the percent of
cases/deaths by race/ethnicity vs. the percent of the population that
each race/ethnicity compose in the US.

## Installation

You can install the released version of CovidRaceData from
[CRAN](https://CRAN.R-project.org) with:

``` r
# install.packages("remotes")
remotes::install_github("Oliver-BE/CovidRaceData")
```

## Example usage

This is a basic example which shows you how to solve a common problem:

``` r
library(CovidRaceData)
## basic example code
```
