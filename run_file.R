install.packages("editrules")
install.packages("dplyr")
install.packages("WriteXLS")
install.packages("plyr")
install.packages("rvest")
install.packages("shiny")


## Now I am activating these packages which I have just installed above

library(plyr)
library(rvest)
library(WriteXLS)
library(shiny)


nba_stats <- read.csv("C:/Users/glevine/Dropbox/R_projects/bball_app/nba_full_dataset.csv")
sample_nba <- nba_stats[order(nba_stats$Player, nba_stats$year),]

