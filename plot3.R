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
         Global_active_power = as.numeric(Global_active_power),
         Sub_metering_1 = as.numeric(Sub_metering_1),
         Sub_metering_2 = as.numeric(Sub_metering_2),
         Sub_metering_3 = as.numeric(Sub_metering_3)
         ) %>% 
  ## Select only the relevant dates
  filter(Date == "2007-02-01" |
          Date == "2007-02-02")

## Open PNG device, create plot3.png in my working directory
png("plot3.png", 
    width=480, 
    height=480)

## making the plot
plot(## sepicify x variable
     x = household_power_subset$DateTime,
     ## sepicify y variable
     y = household_power_subset$Sub_metering_1,
     ## sepicify plot type (l = line)
     type = "l",
     ## change title y axis
     ylab = "Energy Submetering",
     ## remove title x axis
     xlab = "")

## add extra lines to the plot
lines(
     x = household_power_subset$DateTime,
     y = household_power_subset$Sub_metering_2, 
     type="l", 
     col="red")

lines(
     x = household_power_subset$DateTime,
     y = household_power_subset$Sub_metering_3, 
     type="l", 
     col="blue")

## add legend
legend(## specify location
     "topright", 
     c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
     ## specify line types
     lty=1, 
     ## specify line width
     lwd=2.5, 
     ## specify line colors
     col=c("black", "red", "blue"))

## Close PNG file device
dev.off()

