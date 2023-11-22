#Install Package
devtools::install_github("RamiKrispin/coronavirus")
library(coronavirus)
devtools::install_github("RamiKrispin/coronavirus")
update_dataset()
View(coronavirus)
str(coronavirus)

library(shiny)
library(tidyverse)
library(shinydashboard)
library(rvest)
library(DT)
library(plotly)
