#####################################################
# Initialise creation of Blue Dot
# Using only historical data collected from Red Dot, 
# we'll define parameters and establish behaviour pattern for this new digital
# twin entity: Blue Dot

# Background: 
#   - We have 30 days of hourly data collected on the coordinates of Red Dot
#   - Based on it's domain and pattern of behaviour Blue Dot will mimic Red Dot



# Marcela Cespedes
# Thursday 16 May 2024


rm(list = ls())

## sort out directories
wd<- getwd()
dir<- list()
dir$Rcode<- file.path(wd, "Rcode")
dir$data<- file.path(wd, "data")

# Load packages
source(file.path(dir$Rcode, "99_packages.R") )


set.seed(88888888)

orig.data<- read.csv(file = file.path(dir$data, "OriginalData.csv") ) %>%
  rename(time.point = X)
  
########################################
# Define x and y-axis range for Blue Dot
axis.range<- orig.data %>%
  summarise(min.x = min(x),
            max.x = max(x),
            min.y = min(y),
            max.y = max(y))

axis.range

# NOTE: that Blue Dot will not move EXACTLY in a unit square, but instead it's domain
#       will be an approximation of a unit square
#         min.x     max.x        min.y max.y
#1 0.0002955618 0.9981463 0.0004227703     1

# Quick peek at all coordinates
#ggplot(orig.data, aes(x=x, y=y)) +
#  geom_point()
# It's clear that there were clusters in the top and bottom right corners at some point.


##############################################################
# Let's observe the trajectory of x and y coordinates side-by-side

orig.data.long<- melt(orig.data,
                      id.vars = c("time.point", "Day", "Hour")) %>%
  rename(axis = variable,
         coord = value)

days.vec<- 1:max(orig.data$Day)*24

txt.dat<- data.frame(time.point = c(days.vec + 1, days.vec + 1),
                     coord = 1.05,
                     text = c(as.character(1:30),as.character(1:30)),
                     axis = c(rep("x", 30), rep("y", 30)))

p.coords<- ggplot(orig.data.long, aes(x = time.point, 
                           y = coord, 
                           colour = axis)) +
  geom_point(alpha = 0.3,
             size = 1) +
  geom_line(alpha = 0.2,
            linewidth = 1) +
  xlab("Time point (hours)")+
  ylab("x-y coordinates")+
  geom_vline(xintercept = days.vec,
             alpha = 0.5,
             colour = "gray") +
  ggtitle("Historical coordinates of Red Dot over 30 days") +
  facet_wrap(.~ axis) +
  theme(legend.position = "none",
        text = element_text(size = 16),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black")) +

  geom_text(data = txt.dat,
            aes(label = text),
            colour = "gray")


x11()
p.coords

# It's clear that there are clusters of movement/ x-y coordinates over several days 
ggsave(p.coords, filename = paste(dir$data, "RD_Historical_coord_patterns.png"),
       width = 30,
       height = 20,
       units = "cm")

##########################################################
##########################################################
# identify clusters over several days for each coordinate
# get summaries over group of days just by visually going off plot above

# x coordinates -----------------------------
cluster.x1<- orig.data %>%
  filter(Day < 5) %>%
  summarise(mean.x = mean(x),
            sd.x = sd(x),
            min = min(x),
            max = max(x),
            cluster = "1",
            day.min = 0,
            day.max = 5)

#x11()
#hist(filter(orig.data, Day < 5)$x) # this looks like highly noisy Uniform distribution

cluster.x2<- orig.data %>%
  filter(5 <Day & Day < 15) %>%
  summarise(mean.x = mean(x),
            sd.x = sd(x),
            min = min(x),
            max = max(x),
            cluster = "2",
            day.min = 5,
            day.max = 15)

cluster.x3<- orig.data %>%
  filter(15 <Day & Day < 20) %>%
  summarise(mean.x = mean(x),
            sd.x = sd(x),
            min = min(x),
            max = max(x),
            cluster = "3",
            day.min = 15,
            day.max = 20)

cluster.x4<- orig.data %>%
  filter(20 <Day & Day < 27) %>%
  summarise(mean.x = mean(x),
            sd.x = sd(x),
            min = min(x),
            max = max(x),
            cluster = "4",
            day.min = 20,
            day.max = 27)

cluster.x5<- orig.data %>%
  filter(27 <Day) %>%
  summarise(mean.x = mean(x),
            sd.x = sd(x),
            min = min(x),
            max = max(x),
            cluster = "5",
            day.min = 27,
            day.max = 30)

x.clusters<-rbind(cluster.x1,
                  cluster.x2,
                  cluster.x3,
                  cluster.x4,
                  cluster.x5)


# y coordinates -----------------------------
cluster.y1<- orig.data %>%
  filter(Day < 5) %>%
  summarise(mean.y = mean(y),
            sd.y = sd(y),
            min = min(y),
            max = max(y),
            cluster = "1",
            day.min = 0,
            day.max = 5)

#x11()
#hist(filter(orig.data, Day < 5)$y) # this looks like highly noisy Uniform distribution

cluster.y2<- orig.data %>%
  filter(5 <Day & Day < 15) %>%
  summarise(mean.y = mean(y),
            sd.y = sd(y),
            min = min(y),
            max = max(y),
            cluster = "2",
            day.min = 5,
            day.max = 15)

cluster.y3<- orig.data %>%
  filter(15 <Day & Day < 20) %>%
  summarise(mean.y = mean(y),
            sd.y = sd(y),
            min = min(y),
            max = max(y),
            cluster = "3",
            day.min = 15,
            day.max = 20)

cluster.y4<- orig.data %>%
  filter(20 <Day & Day < 27) %>%
  summarise(mean.y = mean(y),
            sd.y = sd(y),
            min = min(y),
            max = max(y),
            cluster = "4",
            day.min = 20,
            day.max = 27)

cluster.y5<- orig.data %>%
  filter(27 <Day) %>%
  summarise(mean.y = mean(y),
            sd.y = sd(y),
            min = min(y),
            max = max(y),
            cluster = "5",
            day.min = 27,
            day.max = 30)

y.clusters<-rbind(cluster.y1,
                  cluster.y2,
                  cluster.y3,
                  cluster.y4,
                  cluster.y5)



############################################################################
############################################################################
##
## Generate hourly data for 30 days based on summaries above


blue.data<- data.frame(Day = rep(1:30, each = 24),
                  Hour = rep(1:24, times = 30),
                  x = NA,
                  y = NA)

count<- 1

# Simulate first 5 days: as per coordinate summaries for cluster 1
for(day in 1:5){
  for(hour in 1:24){
    blue.data$x[count]<- runif(1, 
                          min = x.clusters$min[1], 
                          max=x.clusters$max[1])
    
    blue.data$y[count]<- runif(1, 
                          min = y.clusters$min[1], 
                          max= y.clusters$max[1])
    count<- count + 1
  }
}

count

# simulate cluster 2: days 5 to 15
for(day in 6:15){
  for(hour in 1:24){
    blue.data$x[count]<- runif(1, 
                          min = x.clusters$min[2], 
                          max=x.clusters$max[2])
    
    blue.data$y[count]<- runif(1, 
                          min = y.clusters$min[2], 
                          max= y.clusters$max[2])
    count<- count + 1
  }
}

count


for(day in 16:20){
  for(hour in 1:24){
    blue.data$x[count]<- runif(1, 
                          min = x.clusters$min[3], 
                          max=x.clusters$max[3])
    
    blue.data$y[count]<- runif(1, 
                          min = y.clusters$min[3], 
                          max= y.clusters$max[3])
    count<- count + 1
  }
}

count



for(day in 21:27){
  for(hour in 1:24){
    blue.data$x[count]<- runif(1, 
                          min = x.clusters$min[4], 
                          max=x.clusters$max[4])
    
    blue.data$y[count]<- runif(1, 
                          min = y.clusters$min[4], 
                          max= y.clusters$max[4])
    count<- count + 1
  }
}

count



for(day in 28:30){
  for(hour in 1:24){
    blue.data$x[count]<- runif(1, 
                          min = x.clusters$min[5], 
                          max=x.clusters$max[5])
    
    blue.data$y[count]<- runif(1, 
                          min = y.clusters$min[5], 
                          max= y.clusters$max[5])
    count<- count + 1
  }
}

count

# save data set
write.csv(blue.data, file = file.path(dir$data, "BlueDotData.csv") )












######################################
######################################
##
## Create animation of Blue Dot over based on Red Dot data

# Good example for gganimate
# https://github.com/thomasp85/gganimate

# this fixed my inability to see it in the viewer
# https://github.com/thomasp85/gganimate/issues/335

blue.data$ind<- seq(1:nrow(blue.data)) # create sequential indicator variable


summary(blue.data)

plot.Blue.Dot<- ggplot(blue.data, aes(x=x, y=y)) +
  geom_point(size = 5, 
             colour = "blue") +
  theme_bw() +
  geom_segment(aes(x = min(blue.data$x), 
                   xend = max(blue.data$x), 
                   y = min(blue.data$y), 
                   yend = min(blue.data$y)), linewidth = 2)+
  geom_segment(aes(x = min(blue.data$x), 
                   xend = min(blue.data$x), 
                   y = min(blue.data$y), 
                   yend = max(blue.data$y)), linewidth = 2)+
  geom_segment(aes(x = min(blue.data$x),
                   xend = max(blue.data$x), 
                   y = max(blue.data$y), 
                   yend = max(blue.data$y)), linewidth = 2)+
  geom_segment(aes(x = max(blue.data$x), 
                   xend = max(blue.data$x), 
                   y = min(blue.data$y), 
                   yend = max(blue.data$y)), linewidth = 2)+
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
animate(plot.Blue.Dot, duration = 12, fps = 5, width = 220, height = 200, renderer = gifski_renderer())

anim_save(filename = file.path("BlueDot_initialised.gif"),
          animation = plot.Blue.Dot)
