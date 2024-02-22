#####################################################################
# Original system
# We collect the coordinates from the red dot which moves inside a unit square
# We wish to monitor the coordinates from red dot, know this system and
# create a digital twin... called blue dot.

# Background: 
#   - the coordinates of red dot are collected every hour, every day
#   - We have initial data for 30 days total
#   - red dot moves within a unit square
#   - generally movements should be random, an event occurs when red dot
#         gets stuck at some corner of the square



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

# Initialise -------------------------------------------
# Let's assume we have 30 days worth of daily data
# of the coordinates of red dot

data<- data.frame(Day = rep(1:30, each = 24),
                  Hour = rep(1:24, times = 30),
                  x = NA,
                  y = NA)

count<- 1
# first 5 days it's uneventful 
for(day in 1:5){
  for(hour in 1:24){
    data$x[count]<- runif(1, min = 0, max=1)
    data$y[count]<- runif(1, min = 0, max=1)
    count<- count + 1
  }
}

count

# EVENT 1: --------------------------------------------
# On day 6, let's simulate it getting stuck near corner 0,0
# for an entire 3 days
for(day in 6:9){
  for(hour in 1:24){
    data$x[count]<- runif(1, min = 0, max=0.25)
    data$y[count]<- runif(1, min = 0, max=0.25)
    count<- count + 1
  }
}
count

# EVENT 2: --------------------------------------------
# Now it's back to business as usual and randomly
# can move around the unit square for the rest of the 
# duration of the monitoring cycle (30 days)

for(day in 10:30){
  for(hour in 1:24){
    data$x[count]<- runif(1, min = 0, max=1)
    data$y[count]<- runif(1, min = 0, max=1)
    count<- count + 1
  }
}

count # 721
nrow(data) # 720


# save data set
write.csv(data, file = file.path(dir$data, "OriginalData.csv") )




















