#####################################################################
# Original system
# We collect the coordinates from the red dot which moves inside a unit square
# We wish to monitor the coordinates from red dot, know this system and
# create a digital twin... called Rlue Bot.

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


set.seed(88888888)

# Initialise -------------------------------------------
# Let's assume we have 30 days worth of daily data
# of the coordinates of red dot

data<- data.frame(Day = rep(1:30, each = 24),
                  Hour = rep(1:24, times = 30),
                  x = NA,
                  y = NA)

count<- 1

# first 5 days it's uneventful - randomly moves about the unit square
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
# for an entire 10 days
for(day in 6:15){
  for(hour in 1:24){
    data$x[count]<- runif(1, min = 0, max=0.2)
    data$y[count]<- runif(1, min = 0, max=0.2)
    count<- count + 1
  }
}
count

# EVENT 2: --------------------------------------------
# Now it's back to business as usual and randomly
# can move around the unit square for 5 days

for(day in 16:20){
  for(hour in 1:24){
    data$x[count]<- runif(1, min = 0, max=1)
    data$y[count]<- runif(1, min = 0, max=1)
    count<- count + 1
  }
}
count


# EVENT 3: --------------------------------------------
# On day 21 it gets stuck at the top left quadrant (0,1) for 
# 7 days

for(day in 21:27){
  for(hour in 1:24){
    data$x[count]<- runif(1, min = 0, max=0.2)
    data$y[count]<- runif(1, min = 0.8, max=1)
    count<- count + 1
  }
}
count

# EVENT 4: --------------------------------------------
# Then goes back to normal till the end of 30 days

for(day in 28:30){
  for(hour in 1:24){
    data$x[count]<- runif(1, min = 0, max=1)
    data$y[count]<- runif(1, min = 1, max=1)
    count<- count + 1
  }
}
count


# save data set
write.csv(data, file = file.path(dir$data, "OriginalData.csv") )




######################################
######################################
##
## Create animation of Red Dot over all historical data

# Good example for gganimate
# https://github.com/thomasp85/gganimate

# this fixed my inability to see it in the viewer
# https://github.com/thomasp85/gganimate/issues/335

data$ind<- seq(1:nrow(data)) # create sequential indicator variable

plot.Red.Dot<- ggplot(data, aes(x=x, y=y)) +
  geom_point(size = 5, 
             colour = "red") +
  theme_bw() +
  geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), linewidth = 2)+
  geom_segment(aes(x = 0, xend = 0, y = 0, yend = 1), linewidth = 2)+
  geom_segment(aes(x = 0, xend = 1, y = 1, yend = 1), linewidth = 2)+
  geom_segment(aes(x = 1, xend = 1, y = 0, yend = 1), linewidth = 2)+
  xlab("x-coordinate") +
  ylab("y-coordinate") +
  
  
  # animate
  # Here comes the gganimate code
  transition_states(
    ind,
    transition_length = 10,
    state_length = 10
  ) +
  enter_fade() + 
  exit_shrink() +
  ease_aes('sine-in-out') +
  #labs(title = "Day: {frame_time}" ) 
  ggtitle("Movement: {next_state} out of 720 = 30 days of movement")

# this takes ~9 seconds to render

# reduced frames per second (fps) down to 5 to make this move slower and easier to see
animate(plot.Red.Dot, duration = 12, fps = 5, width = 200, height = 200, renderer = gifski_renderer())

anim_save(filename = file.path("RedDot_historial.gif"),
          animation = plot.Red.Dot)












