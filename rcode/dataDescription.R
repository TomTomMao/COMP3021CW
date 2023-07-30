library(ggplot2)
library(dplyr)
library(ggmosaic)
# this file is for showing how the data looks like
#load data
airbnb <- getwd() %>% 
  paste("/data/airbnb.csv", sep="") %>% 
  read.csv()

# discribe data
airbnb$person_capacity <- factor(airbnb$person_capacity)
airbnb %>%
  ggplot() +
  geom_mosaic(aes(x = product(room_type, host_is_superhost), fill=person_capacity)) +
  coord_flip()
