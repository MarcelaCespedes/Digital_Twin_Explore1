############################################################################
# Script to generate 20 days of data
# created after original system data is collected
# This is to simulate ongoing data generation process

# Marcela Cespedes
# Thursday 22 Feb 2024

rm(list = ls())

## sort out directories
wd<- getwd()

dir<- list()
dir$Rcode<- file.path(wd, "Rcode")
dir$data<- file.path(wd, "data")

# Load packages
source(file.path(dir$Rcode, "99_packages.R") )

# For the next 20 days, data is generated daily and stored
# Let's assume that first 7 days are normal, event free
# EVENT 1: red dot gets stuck in upper right quadrant for 5 days
# EVENT 2: system goes back to normal, then gets stuck lower right quadrant for 6 days 
# EVENT 3: then system resumes back to normal for the remained of 2 days

for(days in 1:20){
  for(hours in 1:24){
    data<- data.frame
  }
}