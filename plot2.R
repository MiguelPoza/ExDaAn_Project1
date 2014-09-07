##read data using data.table, subset them and free memory
library(data.table)
datos_pre <- fread("./household_power_consumption.txt")
datos <- subset(datos_pre, datos_pre$Date == "1/2/2007" | 
                     datos_pre$Date == "2/2/2007")
rm(datos_pre)

#prepare  data
DateTime <- paste (datos$Date, datos$Time,  sep=" ")
DateTime <- strptime (DateTime, format="%d/%m/%Y %H:%M:%S")
datos$Global_active_power <- as.numeric(datos$Global_active_power)

## if English is not the local language system, to get the correct xlabel
Sys.setlocale(locale="English_United States.1252")

# draw the png plot
png(file = "plot2.png", width = 480, height = 480, units = "px")
plot ( DateTime, datos$Global_active_power, type = "l", xlab="", 
       ylab="Global Active Power (kilowatts)")
dev.off()
