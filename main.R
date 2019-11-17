getwd()
# Deberia ser directorio del proyecto

data <- read.table("data.csv", header = TRUE, sep=",")
data$date <- as.Date(data$date, format = "%m/%d/%Y %H:%M")
data$class_week <- as.integer(strftime(data$date, format = "%V")) - 30
data$week_day <- as.integer(strftime(data$date, format = "%u"))
data$day_hour <- as.integer(strftime(data$date, format = "%H"))


#ggplot2
library(ggplot2)

#grafica

ggplot(data = data, 
       mapping =  aes(x = factor(week_day))) + 
  geom_bar() + 
  coord_flip()

#fill con gear
p <- ggplot(data = data, 
            mapping =  aes(x = factor(week_day), fill = factor(happy),  label = "count"))

#stack
p + geom_bar(position = "stack", stat = "count") 

#dodge
p + geom_bar(position = "dodge", stat = "count") 

#fill
p +  geom_bar(position = "fill", stat = "count") 