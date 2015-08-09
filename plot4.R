## load required packages
library(dplyr)
library(lubridate)

## read data file
datafile <- "./household_power_consumption.txt"
classes <- c(rep("character", 2), rep("numeric", 7))
df.hpc <- read.table(file=datafile, header=TRUE, sep=";",
                     colClasses=classes, na.strings="?", stringsAsFactors=FALSE)

## select variables to plot and filter data for specific dates
dates <- c(dmy("01/02/2007"), dmy("02/02/2007"))
df.hpc <- tbl_df(df.hpc) %>%
    filter(dmy(Date) %in% dates) %>%
    mutate(DateTime = dmy(Date) + hms(Time))

## generate plots and save to image file
if (nrow(df.hpc) > 0) {
    with(df.hpc, {
        png(filename='./plot4.png', width=480, height=480, units='px')
        
        ## generate a layout of 2 rows by 2 columns
        par(mfrow=c(2,2),mar=c(4,5,2,1))
        
        ## topleft region
        plot(DateTime, Global_active_power,
             xlab="",
             ylab="Global Active Power",
             type="l")
        
        ## topright region
        plot(DateTime, Voltage,
             xlab="datetime",
             ylab="Voltage",
             type="l")
        
        ## bottomleft region
        plot(DateTime, Sub_metering_1,
             type="l",
             xlab="",
             ylab="Energy sub metering",
             col="black")
        lines(DateTime, Sub_metering_2, col="red")
        lines(DateTime, Sub_metering_3, col="blue")
        legend("topright",
               lty="solid",
               col=c("black","red","blue"),
               bty="n",
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        
        ## bottomright region
        plot(DateTime, Global_reactive_power,
             xlab="datetime",
             ylab="Global_reactive_power",
             type="l")
        
        dev.off()
    })
}

## remove variables
rm(list = c("datafile","classes","dates","df.hpc"))