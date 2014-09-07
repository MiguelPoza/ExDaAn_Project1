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
datos$Global_reactive_power <- as.numeric(datos$Global_reactive_power)
datos$Voltage <- as.numeric(datos$Voltage)
datos$Global_intensity <- as.numeric(datos$Global_intensity)
datos$Sub_metering_1 <- as.numeric(datos$Sub_metering_1)
datos$Sub_metering_2 <- as.numeric(datos$Sub_metering_2)
datos$Sub_metering_3 <- as.numeric(datos$Sub_metering_3)

## if English is not the local language system, to get the correct xlabel
Sys.setlocale(locale="English_United States.1252")

# draw the png plot
png(file = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2,2))

plot ( DateTime, datos$Global_active_power, type = "l", xlab="", 
       ylab="Global Active Power")

plot ( DateTime, datos$Voltage, type = "l", xlab="datetime", 
       ylab="Voltage")


with(datos, plot(DateTime, Sub_metering_1, type="l", xlab="",
                 ylab= "Energy sub metering"))
with(datos, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(datos, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", lty ="solid", col = c("black", "blue", "red"), bty = "n",  
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


plot ( DateTime, datos$Global_reactive_power, type = "l", xlab="datetime", 
       ylab="Global_reactive_power")

dev.off()
