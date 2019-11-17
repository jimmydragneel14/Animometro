getwd()
# Deberia ser directorio del proyecto

# ===================
#   Setup datos
# ===================
data <- read.table("data.csv", header = TRUE, sep=",")
data$date_parsed <- as.Date(data$date, format = "%m/%d/%Y %R")
data$class_week <- as.integer(strftime(data$date_parsed, format = "%V")) - 30
data$week_day <- as.integer(strftime(data$date_parsed, format = "%u"))
data$hour <- as.integer(format(strptime(data$date, "%m/%d/%Y %R"), "%H"))
data$day_hour <- format(strptime(data$date, "%m/%d/%Y %R"), "%u@%H")


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

# Por hora del dia
ph <- ggplot(data = data, 
             mapping =  aes(x = factor(hour), fill = factor(happy, labels = c("Felicidad", "Tristeza")),  label = "count"))

# Por hora del dia y dia de la semana
pwh <- ggplot(data = data, 
             mapping =  aes(x = factor(day_hour), fill = factor(happy, labels = c("Felicidad", "Tristeza")),  label = "count"))

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

# Felicidad por hora
pwh + scale_y_continuous(labels = scales::percent) +
  geom_bar(position = "fill", stat = "count") + 
  labs (
    title = "Ánimo a través del dia",
    fill = "",
    x = "Hora (24h), UTC -6",
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