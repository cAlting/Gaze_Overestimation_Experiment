
# clean workspace
rm(list=ls())

# 1. Library Import -------------------------------------------------------

library(ggplot2)
library(tidyverse)
library(tidyquant)
library(corrplot)
library(geepack)
source("Scripts/99_import_csv.R")

# 2. Data Import --------------------------------------------------------

exp_files_path <- "../../Data/Data Experiment 2 (PsychoPy)/"

df_exp2_raw <- import_csv(exp_files_path)

# select relevant variables
df_exp2 <- df_exp2_raw %>% 
  filter(!is.na(visAngCorr)) %>%
  select(c("looker", 
           "visAngCorr", 
           "trials_exp.thisN", 
           "answer", 
           "RT", 
           "participant", 
           "subject_gender", 
           "subject_age")) %>%
  mutate(
    error = answer-visAngCorr,
    participant = as.factor(participant),
    looker = as.factor(looker),
    subject_gender = as.factor(subject_gender),
  ) %>%
  rename(c(
    "deg" = "visAngCorr",
    "trial" = "trials_exp.thisN",
    "sID" = "participant",
    "sAge" = "subject_age",
    "sSex" = "subject_gender")
  )

df_morph_mm <- read.csv("../../Data/Data Experiment 1 (Eye Morphology)/Eye_Measurements_avg_mm.csv")

df_merge <- merge(df_exp2, df_morph_mm, by.x = "looker", by.y = "looker_id")

df_clean <- df_merge %>%
  select(-c(X)) %>%
  rename(c(
    "lSex" = "looker_gender",
    "lID" = "looker"
  )) %>%
  mutate(
    lSex = as.factor(lSex),
    lID = as.factor(lID)
  )

view(df_clean)

# 3. Data Aggregation -----------------------------------------------------

# aggregate judgements (1 value per participant per gaze direction)
df_summ_per_subject <- df_clean %>%
  group_by(sID, deg) %>%
  summarise(M_gd = mean(answer)
  )

# aggregate judgements (1 value per Looker per gaze Direction)
df_summ_per_looker <- df_clean %>%
  group_by(lID, deg) %>%
  summarise(M_gd = mean(answer))

# aggregate judgements (1 value per Looker x Subject x GD combination)
df_summ <- df_clean %>%
  group_by(lID, sID, deg) %>%
  summarise(M_gd = mean(answer))

# aggregate judgements (over looker and observer)
df_summ_all <- df_clean %>%
  group_by(deg) %>%
  summarize(
    M_gd = mean(answer)
  )



# 4. Data Visualization ---------------------------------------------------

# raw data with lm line
ggplot(df_clean,
       aes(x = deg,
           y = answer))+
  geom_point()+
  geom_smooth(method="lm")


# PGD ~ GD per subject
ggplot(df_summ_per_subject,
       aes(x = deg,
           y = M_gd,
           group=sID,
           color=sID))+
  geom_point()+
  geom_line()+
  geom_function(fun = ~ .x, color="red", size=1)

# PDG ~ GD per Looker
ggplot(df_summ_per_looker,
       aes(x = deg,
           y = M_gd,
           group = lID,
           color = lID))+
  geom_point()+
  geom_line()+
  geom_function(fun =~ .x, color="red")+
  facet_wrap(~lID, nrow=4)

# PDG ~ GD per Looker (one plot)
ggplot(df_summ_per_looker,
       aes(x = deg,
           y = M_gd,
           group = lID,
           color = lID))+
  geom_point()+
  geom_line()+
  geom_function(fun =~ .x, color="red")

# PDG ~ GD per Looker and participant
ggplot(df_summ,
       aes(x = deg,
           y = M_gd,
           group=interaction(lID, sID),
           color=sID)) +
  geom_point()+
  geom_line()+
  geom_function(fun=~.x, color="red")+
  facet_wrap(~lID)


# TEST: Verteilung der Urteile nach tatsächlichem Target
ggplot(df_clean %>% filter(deg==13.3),
       aes(x=answer))+
  geom_density()+
  geom_vline(xintercept=13.3, col="red")


a <- df_clean %>%
  group_by(trial, deg) %>%
  summarize(
    M_er = mean(error),
    M_an = mean(answer),
    n = n()
  )

ggplot(a,
       aes(x=trial,
           y=M_an,
           group=deg,
           color=deg))+
  geom_line()+
  geom_ma(aes(y=M_an), size=5, ma_fun = SMA, n=50, color="blue")+
  facet_wrap(~deg, scales="free")


# TEST: RTs in Abhängigkeit von Trial

b <- df_clean %>%
  group_by(trials_exp.thisN, visAngCorr, looker, participant) %>%
  summarize(
    M_er = mean(error),
    M_an = mean(answer),
    M_RT = mean(RT),
    n = n()
  )
b

ggplot(b,
       aes(x=trials_exp.thisN,
           y=M_RT,
           group=as.factor(visAngCorr),
           color=as.factor(visAngCorr)))+
  geom_line()+
  geom_ma(aes(y=M_RT), size=5, ma_fun = SMA, n=50, color="blue")+
  facet_wrap(~visAngCorr, scales="free")


ggplot(b[b["M_RT"]<40,],
       aes(x=M_RT,
           group=participant,
           color=participant))+
  geom_histogram(bins=50)+
  facet_wrap(~looker)

ggplot(b,
       aes(x=M_er,
           group=participant,
           color=participant))+
  geom_histogram(bins=50)+
  facet_wrap(~looker)

# 5. OE/UE bestimmen ------------------------------------------------------

# OLS Slopes
slopes <- df_clean %>% 
  group_by(lID, sID) %>% 
  summarize(
    b0 = coef(lm(answer ~ deg))[1], 
    b1 = coef(lm(answer ~ deg))[2])


# GEE Slopes (hint: they're the same ;))
slopes_m = tibble(
  b0 = double(),
  b1 = double(),
  lID = double()
)

for(l in unique(df_clean$looker_id_seq)){
  tmp_df_sub <- df_clean %>%
    filter(looker_id_seq==l) %>%
    arrange(sID)
  
  slopes_m[l, "lID"] <- l
  slopes_m[l, "b0"] <- coef(geeglm(answer~deg, data=tmp_df_sub, id=sID, corstr = "exchangeable"))[1]
  slopes_m[l, "b1"] <- coef(geeglm(answer~deg, data=tmp_df_sub, id=sID, corstr = "exchangeable"))[2]
  
}


# b1 / slopes (lm Werte)
ggplot(slopes,
       aes(x=looker,
           y=b1,
           group=as.factor(participant),
           color=as.factor(participant)))+
  geom_point()+
  geom_line()+
  ylim(0,7)

# b1 / slopes (GEE Werte)
ggplot(slopes_m,
       aes(x=lID,
           y=b1))+
  geom_point()+
  geom_line()+
  ylim(0,7)



# b0 / Intercepts / CEs (lm)
ggplot(slopes,
       aes(x=looker,
           y=b0,
           group=as.factor(participant),
           color=as.factor(participant)))+
  geom_point()+
  geom_line()

# b0 / Intercepts / CEs (GEE)
ggplot(slopes_m,
       aes(x=lID,
           y=b0))+
  geom_point()+
  geom_line()


# Hypothesen überprüfen (Einfluss bestimmter Parameter auf OE/UE)
# df für Regression erstellen (z-Standardisierung der Prädiktoren)
df_lm <- merge(slopes, df_clean, by.x="lID", by.y = "lID") %>%
  select(-sID.y) %>%
  rename(c("sID" = "sID.x")) %>%
  mutate(
    whr.z = scale(whr_mm)[,1],
    ssr.z = scale(ssr)[,1],
    hei.z = scale(hei_mm)[,1],
    ssi.z = scale(ssi_mm)[,1],
    b1.z = scale(b1)[,1],
    ril.z = scale(ril)[,1],
    hc.z = scale(hac)[,1]
  )

# Korrelationsmatrix mit Werten > 0.3
cor_mat <- df_lm %>%
  select(whr.z, ssr.z, hei.z, ssi.z, ril.z, hc.z) %>%
  cor() 
cor_mat[cor_mat<0.3] <- 0
cor_mat

# Korrelationsplot
df_lm %>%
  select(whr.z, ssr.z, hei.z, ssi.z, ril.z, hc.z) %>%
  cor() %>%
  corrplot(method="ellipse")

m1 <- lm(b1~ssr*hei_mm, data=df_lm)
m1.z <- lm(b1~ssr.z*hei.z*ril.z*whr.z*hc.z, data = df_lm)

summary(m1)
summary(m1.z)
summary(m2.z)

plot(m1)
plot(m1.z)

car::vif(m1)
car::vif(m1.z)


# Robuste SE gegen Heteroskedastizität
library(lmtest)
library(sandwich)

variance = lm(abs(m1.z$residuals) ~ m1.z$fitted.values)$fitted.values^2

# calculating the weights
weights = 1 / variance

# weighted regression model
weighted_model = lm(b1~ssr.z*hei.z*ril.z*whr.z*hc.z, data = df_lm)
summary(weighted_model)


# 7. elastic net und LOOCV --------------------------------

library(glmnet)
library(caret)

dfcv <- merge(slopes_m, df_clean, by.x="lID", by.y = "lID") %>%
  select(-sID.y) %>%
  rename(c("sID" = "sID.x")) %>%
  mutate(
    whr.z = scale(whr_mm),
    ssr.z = scale(ssr),
    hei.z = scale(hei_mm),
    ssi.z = scale(ssi_mm),
    b1.z = scale(b1),
    ril.z = scale(ril),
    hc.z = scale(hac)
  )

# 99. Symbolic Regression ------------------------------------------------

library(gramEvol)

x <- df_summ_per_subject %>%
  filter(participant == 1) %>%
  select(visAngCorr)
x <- x$visAngCorr

y <- df_summ_per_subject %>%
  filter(participant == 1) %>%
  select(M_gd)
y <- y$M_gd

ruleDef <- list(expr = grule(op(expr, expr), func(expr), var),
                func = grule(sin, cos),
                op = grule('+', '-', '*'),
                var = grule(x))

grammarDef <- CreateGrammar(ruleDef)
grammarDef


SymRegFitFunc <- function(expr) {
  result <- eval(expr)
  if (any(is.nan(result)))
    return(Inf)
  return (sum((y - result)^2))
}


ge <- GrammaticalEvolution(grammarDef, 
                           SymRegFitFunc, 
                           terminationCost = 0.001, 
                           iterations = 10000, 
                           max.depth = 5,
                           monitorFunc = print)

ge
plot(y)
points(eval(ge$best$expressions), col = "red", type = "l")