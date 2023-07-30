library(ggplot2)
library(dplyr)

# get location names
FILE_NAMES <- (paste(getwd(),"/data", sep="") %>%
  list.files())
FILE_NAMES
OUTPUT_PATH <- (paste(getwd(), "/data/airbnb.csv", sep=""))
OUTPUT_PATH
# helper function for return file name
getFileInfo <- function (fileName) {
  location <- strsplit(fileName, split="_")[[1]][1]
  time <- strsplit(fileName, split="_")[[1]][2] %>% 
    strsplit(split=".csv")
  c(location,time[[1]])
}

getFileLocation <- function (fileName) {
  getFileInfo(fileName)[1]
}

getFileTime <- function (fileName) {
  getFileInfo(fileName)[2]
}

# Return a data from the filenames with the location column and the time column. 
# The value in the location column is the character before "_" of the fileName, 
# The time column is the character between "_" and ".csv"
getFileData <- function (fileName) {
  location <- getFileLocation(fileName)
  time <- getFileTime(fileName)
  filePath <- paste(getwd(), fileName, sep = "/data/")
  thisData <- read.csv(filePath)
  thisData$location = location
  thisData$time = time
  thisData
}

# get the first dataframe
data <- getFileData(FILE_NAMES[2])
data
# Merge all file into one single data frame
for (fileName in FILE_NAMES[3:length(FILE_NAMES)]) {
  thisData <- getFileData((fileName))
  data <- rbind(data, thisData)
}

# count null value
colSums(is.na(data))

# save merged data into airbnb.csv
write.csv(data, OUTPUT_PATH)
