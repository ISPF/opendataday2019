##############################
# RECUPERATION D'UNE RESSOURCE
##############################

dt <- DataGouv_GetResource(11)

dt$Date <- as.POSIXct(dt$Mois)
dt$Annee <- year(dt$Date)
dt$Mois <- month(dt$Date)

#############################
# GRAPHIQUES
#############################

ggplot(dt)+
  geom_line(aes(x=Date, y=`Nombre de touristes`))+
  geom_line(aes(x=Date, y=`Nombre de touristes CVS`), colour = "blue")+
  theme_gray() +
  labs(subtitle="Evolution du nombre de touristes mensuels en Polynésie française")

ggplot(dt)+
  geom_line(aes(x=Date, y=`Nombre de touristes cumul annuel`))+
  theme_gray() +
  labs(subtitle="Evolution du nombre de touristes en cumul annuel en Polynésie française")

#############################
#REGRESSION LINEAIRE
#############################

dt <- dt[Annee>=2010]
dt$indice <- as.numeric(rownames(dt))

ggplot(dt, aes(x=Date, y=`Nombre de touristes cumul annuel`))+
  geom_line()+
  geom_smooth(method=lm)+
  labs(subtitle="Evolution du nombre de touristes en cumul annuel en Polynésie française")

model <- lm(`Nombre de touristes cumul annuel`~indice, dt)
sprintf("%1.2f%%", 100*(model$fitted.values[12]/model$fitted.values[1]-1))