getwd()
# Deberia ser directorio del proyecto

# ===================
#   Setup datos
# ===================
data <- read.table("data.csv", header = TRUE, sep=",")
data$date <- as.Date(data$date, format = "%m/%d/%Y %H:%M")
data$class_week <- as.integer(strftime(data$date, format = "%V")) - 30
data$week_day <- as.integer(strftime(data$date, format = "%u"))
data$day_hour <- as.integer(strftime(data$date, format = "%H"))


# ===================
#   Setup graficos
# ===================
library(ggplot2)

# Por dia de la semana
pwd <- ggplot(data = data, 
            mapping =  aes(x = factor(week_day), fill = factor(happy),  label = "count"))

# Por semana del año
pw <- ggplot(data = data, 
              mapping =  aes(x = factor(class_week), fill = factor(happy),  label = "count"))

# ===================
#      Graficos
# ===================

# Felicidad por dia de la semana
pwd +  geom_bar(position = "fill", stat = "count") 

# Felicidad por semana del año
pw +  geom_bar(position = "fill", stat = "count") 



# ==================
#     Ejemplos
# ==================

#stack
p + geom_bar(position = "stack", stat = "count") 

#dodge
p + geom_bar(position = "dodge", stat = "count") 

#fill
p +  geom_bar(position = "fill", stat = "count") 