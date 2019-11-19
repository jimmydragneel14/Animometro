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
ph + scale_y_continuous(labels = scales::percent) +
  geom_bar(position = "fill", stat = "count") + 
  labs (
    title = "Ánimo a través del dia",
    fill = "",
    x = "Hora (24h), UTC -6",
    y = "Ánimo",
    subtitle = "Felicidad & Tristeza"
  )

# Felicidad por hora del dia
pwh + scale_y_continuous(labels = scales::percent) +
  geom_bar(position = "fill", stat = "count") + 
  labs (
    title = "Ánimo a través del dia",
    fill = "",
    x = "Hora (24h), UTC -6",
    y = "Ánimo",
    subtitle = "Felicidad & Tristeza"
  )

# Regresion lineal
#====================

ggplot(data, aes(x = data$week_day, y =data$happy)) + geom_point() + geom_smooth(method="lm") + 
  ggtitle("Regresion lineal por dia de la semana") +
  labs(x  =  'Dia de la semana', y  =  'Nivel de felicidad') 

ggplot(data, aes(x =data$date_parsed, y = data$happy)) + geom_point() + geom_smooth(method="lm") +
  ggtitle("Regresion lineal por fecha") +
  labs(x  =  'Fecha', y  =  'Nivel de felicidad')

ggplot(data, aes(x =data$class_week, y= data$happy)) + geom_point() + geom_smooth(method="lm") +
  ggtitle("Regresion lineal por semanas del semestre") +
  labs(x  =  'Semanas del semestre', y  =  'Nivel de felicidad')

ggplot(data, aes(x =data$hour,y= data$happy)) + geom_point() + geom_smooth(method="lm") +
  ggtitle("Regresion lineal por hora del dia") +
  labs(x  =  'Hora del dia', y  =  'Nivel de felicidad')

#Otras graficas de regresion lineal con datos "summary" y "predict"
#====================================================================

plot(data$date_parsed,data$happy,xlab = "Date",ylab = "Level of Happiness") 
abline(lm(data$happy ~ data$date_parsed))
summary(lm(data$happy ~ data$date_parsed))
predict(lm(data$happy ~ data$date_parsed))

plot(data$class_week, data$happy,xlab ="Class week",ylab = "Level of Happiness")
abline(lm(data$happy ~ data$class_week))
summary(lm(data$happy ~ data$class_week))
predict(lm(data$happy ~ data$class_week))

plot(data$week_day, data$happy,xlab = "Week Day" ,ylab = "Level of Happiness")
abline(lm(data$happy ~ data$week_day))
summary(lm(data$happy ~ data$week_day))
predict(lm(data$happy ~ data$week_day))

plot(data$hour, data$happy,xlab = "Hour", ylab = "Level of Happiness")
abline(lm(data$happy ~ data$hour))
summary(lm(data$happy ~ data$hour))
predict(lm(data$happy ~ data$hour))

#     Ejemplos
# ==================

#stack
p + geom_bar(position = "stack", stat = "count") 

#dodge
p + geom_bar(position = "dodge", stat = "count") 

#fill
p +  geom_bar(position = "fill", stat = "count") 