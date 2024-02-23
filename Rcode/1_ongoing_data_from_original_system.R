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

set.seed(999999)
# For the next 20 days, data is generated daily and stored
# EVENT 1: Let's assume that first 7 days are normal, event free
# EVENT 2: red dot gets stuck in upper right quadrant for 5 days
# EVENT 3: system goes back to normal for 3 days, 
# EVENT 4: then gets stuck lower right quadrant for 2 days 
# EVENT 5: then system resumes back to normal for the remained of 2 days

# Data is collated daily into csv file

# EVENT 1: normal for 7 days ------------------------------------------------
for(days in 1:7){
  
  data<- data.frame(Day = rep(days, times = 24),
                    Hour = 1:24,
                    x=NA,
                    y=NA)
  
  for(hours in 1:24){
    data$x[hours]<- runif(1, min = 0, max=1)
    data$y[hours]<- runif(1, min = 0, max=1)
    
  }
  
  file.name<- paste("day_", days,"_data.csv", sep = "")
  write.csv(data, file = file.path(dir$data, file.name))
}

# EVENT 2: stuck upper right quad 5 days -----------------------------------
for(days in 8:12){
  
  data<- data.frame(Day = rep(days, times = 24),
                    Hour = 1:24,
                    x=NA,
                    y=NA)
  
  for(hours in 1:24){
    data$x[hours]<- runif(1, min = 0.75, max=1)
    data$y[hours]<- runif(1, min = 0.75, max=1)
    
  }
  
  file.name<- paste("day_", days,"_data.csv", sep = "")
  write.csv(data, file = file.path(dir$data, file.name))
}

# EVENT 3: back to normal 3 days -------------------------------------------
for(days in 13:15){
  
  data<- data.frame(Day = rep(days, times = 24),
                    Hour = 1:24,
                    x=NA,
                    y=NA)
  
  for(hours in 1:24){
    data$x[hours]<- runif(1, min = 0, max=1)
    data$y[hours]<- runif(1, min = 0, max=1)
    
  }
  
  file.name<- paste("day_", days,"_data.csv", sep = "")
  write.csv(data, file = file.path(dir$data, file.name))
}

# EVENT 4: stuck lower right waud 2 days -----------------------------------
for(days in 16:17){
  
  data<- data.frame(Day = rep(days, times = 24),
                    Hour = 1:24,
                    x=NA,
                    y=NA)
  
  for(hours in 1:24){
    data$x[hours]<- runif(1, min = 0, max=0.2)
    data$y[hours]<- runif(1, min = 0, max=0.2)
    
  }
  
  file.name<- paste("day_", days,"_data.csv", sep = "")
  write.csv(data, file = file.path(dir$data, file.name))
}

## EVENT 5: back to normal 2 days -------------------------------------------
for(days in 18:20){
  
  data<- data.frame(Day = rep(days, times = 24),
                    Hour = 1:24,
                    x=NA,
                    y=NA)
  
  for(hours in 1:24){
    data$x[hours]<- runif(1, min = 0, max=1)
    data$y[hours]<- runif(1, min = 0, max=1)
    
  }
  
  file.name<- paste("day_", days,"_data.csv", sep = "")
  write.csv(data, file = file.path(dir$data, file.name))
}


##