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
    select(Date, Time, Global_active_power) %>%
    filter(dmy(Date) %in% dates) %>%
    mutate(DateTime = dmy(Date) + hms(Time))

## generate plot and save to image file
if (nrow(df.hpc) > 0) {
    with(df.hpc, {
        png(filename='./plot2.png', width=480, height=480, units='px')
        plot(DateTime, Global_active_power,
             type="l",
             xlab="",
             ylab="Global Active Power (kilowatts)")
        dev.off()
    })
}

## remove variables
rm(list = c("datafile","classes","dates","df.hpc"))