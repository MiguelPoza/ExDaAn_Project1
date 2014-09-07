##read data using data.table, subset them and free memory
library(data.table)
datos_pre <- fread("./household_power_consumption.txt")
datos <- subset(datos_pre, datos_pre$Date == "1/2/2007" | 
                     datos_pre$Date == "2/2/2007")
rm(datos_pre)

#prepare  data
datos$Date <- as.Date(datos$Date, format="%d/%m/%Y")
datos$Global_active_power <- as.numeric(datos$Global_active_power)

# draw the png plot
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(datos$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col= "red", 
     ylim = c(0, 1200))
dev.off()
