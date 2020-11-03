#' COVID-19 Data By Race and Ethnicity
#'
#' This package contains data sets on the COVID-19 pandemic in the US by race and ethnicity (as of 10/07/2020).
#' @docType package
#' @name CovidRaceData
#' @aliases CovidRaceData CovidRaceData-package
NULL

#' "COVID Race Data Raw"
#'
#' The (cleaned) raw data set from The COVID Tracking Project. It contains the
#' number of COVID-19 cases and deaths by race/ethnicity by US state (as well
#' as each state's population).
#'
#' @format A data frame with 51 rows and 29 variables:
#' \describe{
#'   \item{State}{The abbreviation of the US state}
#'   \item{Cases_Total}{Total number of cases in the state}
#'   \item{Cases_White}{Number of cases affecting white people}
#'   \item{Cases_Black}{Number of cases affecting black people}
#'   \item{Cases_LatinX}{Number of cases affecting LatinX people}
#'   \item{Cases_Asian}{Number of cases affecting Asian people}
#'   \item{Cases_AIAN}{Number of cases affecting American Indian or Alaska Native people}
#'   \item{Cases_NHPI}{Number of cases affecting Native Hawaiian and Pacific Islander people}
#'   \item{Cases_Multiracial}{Number of cases affecting multiracial people}
#'   \item{Cases_Other}{Number of cases affecting people that don't fall into any of the above 7 categories}
#'   \item{Cases_Unknown}{Number of cases affecting people of an unknown race}
#'   \item{Cases_Ethnicity_Hispanic}{Number of cases affecting Hispanic people}
#'   \item{Cases_Ethnicity_NonHispanic}{Number of cases affecting NonHispanic people}
#'   \item{Cases_Ethnicity_Unknown}{Number of cases affecting people of an unknown ethnicity}
#'   \item{Deaths_Total}{Total number of deaths in the state}
#'   \item{Deaths_White}{Number of deaths affecting white people}
#'   \item{Deaths_Black}{Number of deaths affecting black people}
#'   \item{Deaths_LatinX}{Number of deaths affecting LatinX people}
#'   \item{Deaths_Asian}{Number of deaths affecting Asian people}
#'   \item{Deaths_AIAN}{Number of deaths affecting American Indian or Alaska Native people}
#'   \item{Deaths_NHPI}{Number of deaths affecting Native Hawaiian and Pacific Islander people}
#'   \item{Deaths_Multiracial}{Number of deaths affecting multiracial people}
#'   \item{Deaths_Other}{Number of deaths affecting people that don't fall into any of the above 7 categories}
#'   \item{Deaths_Unknown}{Number of deaths affecting people of an unknown race}
#'   \item{Deaths_Ethnicity_Hispanic}{Number of deaths affecting Hispanic people}
#'   \item{Deaths_Ethnicity_NonHispanic}{Number of deaths affecting NonHispanic people}
#'   \item{Deaths_Ethnicity_Unknown}{Number of deaths affecting people of an unknown ethnicity}
#'   \item{State_Name}{The name of the US state}
#'   \item{Population}{2019 population of the US state}
#' }
#' @source \url{https://covidtracking.com/race/about#download-the-data}
"covid_race_data_raw"

#' "Aggregated COVID Race Data"
#'
#' A data set containing the number of cases, deaths, and population (in raw
#' numbers as well as by percentage) by race or ethnicity in the US.
#'
#' @format A data frame with 7 rows and 10 variables:
#' \describe{
#'   \item{Race}{Race (or ethnicity in case of Hispanic)}
#'   \item{Cases_Total}{Total number of COVID-19 cases by race or ethnicity}
#'   \item{Deaths_Total}{Total number of COVID-19 deaths by race or ethnicity}
#'   \item{Population_Total}{Total US population by race or ethnicity}
#'   \item{Cases_Per_100K}{Total cases (per 100,000 people) by race or ethnicity}
#'   \item{Deaths_Per_100K}{Total deaths (per 100,000 people) by race or ethnicity}
#'   \item{Population_In_100K}{Total US population (in 100,00's of people) by race or ethnicity}
#'   \item{Cases_Percent}{Percent of COVID-19 cases by race or ethnicity}
#'   \item{Deaths_Percent}{Percent of COVID-19 deaths by race or ethnicity}
#'   \item{Population_Percent}{Percent of US population by race or ethnicity}
#' }
#' @source \url{https://covidtracking.com/race/about#download-the-data}
"aggregated_covid_race_df"
