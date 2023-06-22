

# 1. Berechnungen der Leistenabstände bzw. des Subjekt-Objektiv-Ab --------

size_from_vis_ang <- function(d, a){
  cf <- pi/180
  s <- 2*d*tan(a/2)*cf
  return(s)
}


vis_ang_from_size <- function(d, s){
  cf <- pi/180
  a <- 2*atan((s/2)/d)/cf
  return(a)
}


# Grad Sehwinkel, die markiert werden sollen
deg <- seq(1.1,13.3, 1.1)
deg <- c(8,12)

# Abstand Objektiv - VP
d <- 280
d <- 122

# Umrechnungsfaktor rad --> deg
cf <- pi/180

# Objektivumfang (Filtergewindedurchmesser kann nicht genommen werden, da Leiste nich hier stößt!)
u_obj <- 245 # 105mm
u_obj <- 325 # 200-500mm
r <- u_obj/(2*pi)

# cm-Werte, die markiert werden müssen.
# Beachte: Der Radius des Objektives wird abgezogen, sodass 1° Sehwinkel am Stoßpunkt zwischen
# Objektiv und Leiste liegt
round(tan(deg*cf)*d,2)-r
round(tan(deg*cf)*d,2)


# Abstand Objektiv-VP berechnen, wenn die Leiste das Objektiv bei 1° Sehwinkel stoßen soll
(d_obj_vp <- round(0.1*r/tan(1*cf),2))

# Abstand Objektiv-VP: 223.39m
d_obj_vp <- 280

# Markierungen, die auf Leiste bei d_obj_vp (Abstand VP-Objektiv) und u_obj (Umfang Objektiv) gesetzt werden müssen
round(tan(deg*cf)*d_obj_vp,2)-round(r*0.1,2)



size_from_vis_ang <- function(d, a){
  s <- 2*d*tan(a/2)
  return(s)
}

size_from_vis_ang(200, 2.8)






# Berechnungen aus Papern -------------------------------------------------

library(russmisc)

d_gibson <- 200
d_cline <- 122

s_gibson <- 9

a_gibson <- 2.8

visangle(s_gibson, d_gibson)
stimsize(a_gibson, d_gibson)
stimsize(a_gibson, 13.5)

# Gibson und Pick
visangle(0.64, 200) # 


# Tabelle Cline
stimsize(8, 122) # 17.06cm
stimsize(12, 122) # 25.65cm
visangle(1.55, 122) # 0.73°
stimsize(0.75, 13.55) # 18mm

visangle(0.56, 122) # 0.262°
visangle(8.36, 122) # 3.92°

# Objektiv / Abstand
u_obj <- 22.8
r_obj <- u_obj/(2*pi)
d_leiste <- 210
d_eff <- 189
#stosspkt <- round(visangle(r_obj,d_eff),2) # Stoßpunkt Leiste - Objektiv liegt bei 1.1° Sehwinkel (anstatt 1.0°)
stosspkt <- visangle(r_obj,d_eff)

ticks_deg <- seq(0,60, stosspkt/2)
ticks_cm <- stimsize(ticks_deg, 189)
ticks_cm
diff_cm <- round(diff(ticks_cm),2)
line_num <- seq(2,110)

line_df <- data.frame(diffs = diff_cm, row.names=line_num)
line_df

# bisher gezeichnet: Linie 30

# Berechnung der maximalen Breite und Höhe des Auges ----------------------

library(sf)

# Laden der benötigten Funktionen
source("Masterarbeit/Code/Max_Perpendicular_Lines.R")

# # Laden des DFs
df.1 <- read.csv("C:\\Users\\calti\\Desktop\\XY_F02_Ref.csv", header=T)

## construct an sf polygon from points:
polygon = st_polygon(list(as.matrix(rbind(df.1, df.1[1,]))))

# get longest line within shape
chord = max_chord(polygon)

# plot shape and longest line
plot(polygon)
points(chord, col="red",cex=2)
lines(chord,col="green",lwd=2)

# get longest perpendicular line to chord
pchord = find_max_chord(polygon, chord)

# add this line to plot
plot(pchord,add=TRUE)


# Möglicher Workflow:

# WHR: Maximale Breite/Maximale Höhe
#   - Einzeichnen des maximalen Augenöffnung --> Koordinaten exportieren
#   - Einlesen der Koordinaten --> Funktion drüber laufen lassen

# SSI: width of exposed eyeball/diameter of iris
#   - Einzeichnen der Iris und Pupille --> Exportieren der Koordinaten
#   - Einlesen der Koordinaten --> Funktion drüber laufen lassen


