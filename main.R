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
            mapping =  aes(x = factor(week_day, labels = c("L", "K", "M", "J", "V", "S")),
                           fill = factor(happy, labels = c("Felicidad", "Tristeza")),  label = "count"))

# Por semana del año
pw <- ggplot(data = data, 
              mapping =  aes(x = factor(class_week), fill = factor(happy, labels = c("Felicidad", "Tristeza")),  label = "count"))

# ===================
#      Graficos
# ===================

# Felicidad por dia de la semana
pwd + scale_y_continuous(labels = scales::percent) +
  geom_bar(position = "fill", stat = "count") + 
  labs (
    title = "Ánimo a través de la semana",
    fill = "",
    x = "Día de la semana",
    y = "Ánimo",
    subtitle = "Felicidad & Tristeza"
  )

# Felicidad por semana del año
pw + scale_y_continuous(labels = scales::percent) +
  geom_bar(position = "fill", stat = "count") + 
  labs (
    title = "Ánimo a través de las semanas del semestre",
    fill = "",
    x = "# de semana",
    y = "Ánimo",
    subtitle = "Felicidad & Tristeza"
  )



# ==================
#     Ejemplos
# ==================

#stack
p + geom_bar(position = "stack", stat = "count") 

#dodge
p + geom_bar(position = "dodge", stat = "count") 

#fill
p +  geom_bar(position = "fill", stat = "count") 