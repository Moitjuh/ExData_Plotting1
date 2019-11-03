library(pacman)
p_load(dplyr,lubridate)

## Load the file
household_power <- read.table("household_power_consumption.txt", 
                              header=TRUE, 
                              sep=";", 
                              stringsAsFactors=FALSE, 
                              dec=".", 
                              na.strings="?")

household_power_subset <- household_power %>% 
  ## Change the Date variable to class Date and Global_active_power variable to numeric
  mutate(Date = as.Date(Date, format="%d/%m/%Y"),
         Global_active_power = as.numeric(Global_active_power)) %>% 
  ## Select only the relevant dates
  filter(Date == "2007-02-01" |
          Date == "2007-02-02")

## Open PNG device, create plot1.png in my working directory
png("plot1.png", 
    width=480, 
    height=480)


hist(## vector of values to plot
     household_power_subset$Global_active_power, 
     ## set colors of the bars
     col="red", 
     ## add title
     main="Global Active Power", 
     ## change title x axis
     xlab="Global Active Power (kilowatts)")

## Close PNG file device
dev.off()

