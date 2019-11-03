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
  ## Change the Date variable to class Date, Global_active_power variable to numeric and
  ## we also create a new variable combining date and time (using the Lubridate package)
  mutate(Date = as.Date(Date, format="%d/%m/%Y"),
         DateTime = ymd_hms(paste(Date, Time)),
         Global_active_power = as.numeric(Global_active_power)
         ) %>% 
  ## Select only the relevant dates
  filter(Date == "2007-02-01" |
          Date == "2007-02-02")

## Open PNG device, create plot2.png in my working directory
png("plot2.png", 
    width=480, 
    height=480)

## making the plot
plot(## sepicify x variable
     x = household_power_subset$DateTime,
     ## sepicify y variable
     y = household_power_subset$Global_active_power,
     ## sepicify plot type (l = line)
     type = "l",
     ## add title
     main = "Global Active Power vs Time",
     ## change title y axis
     ylab = "Global Active Power (kilowatts)",
     ## remove title x axis
     xlab = "")

## Close PNG file device
dev.off()

