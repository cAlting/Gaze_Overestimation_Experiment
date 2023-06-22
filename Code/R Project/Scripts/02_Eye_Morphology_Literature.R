
####
# This script imports and aggregates publicly available data on human eye 
# morphology provided by Danel et al. (2023).
# Data found in Tab. 1 Danel et al. (2020) will be manually imported


# 1. Library import -------------------------------------------------------

library(dplyr)
library(kableExtra)
library(flextable)
library(ftExtra)

# 2. Data import (Danel et al. 2023) --------------------------------------

# Data can be found in S1 and S2 under:
# https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0284079#sec013

ext_csv_path <- "../../../Data/External Data/"

ext_csv_files <-  list.files(ext_csv_path, pattern="csv")

for(i in seq(1:length(ext_csv_files))){
  file_path <- paste(ext_csv_path, ext_csv_files[i], sep="/")
  if(i == 1){
    df <- read.csv(file_path, stringsAsFactors = T)
    df <- df %>%
      select(Photo_id,SSI,RIL,WHR,Photo_Sex)
  }else{
    tmp <- read.csv(file_path, stringsAsFactors = T)
    tmp <- tmp %>%
      select(Photo_id,SSI,RIL,WHR,Photo_Sex)
    
    df <- rbind(df, tmp)
  }
}

# recode Photo_Sex column (during import F gets converted to bool/FALSE)
df$Photo_Sex <- ifelse(df$Photo_Sex==FALSE, "f", "m")

# number of unique subjects
length(unique(df$Photo_id))

# number of rows in df
nrow(df)

# there are 30 rows per photo. We only want to keep unique rows 
# (= 1 row per photo)
df_unique <- df %>%
  distinct()

# check number of unique subjects/photo ids
length(unique(df_unique$Photo_id))



# 2.1. Data Summary (Danel et al. 2023) -----------------------------------

# calculate values found in Danel et al. (2023) with the 2020 data
df_danel_2023 <- df_unique %>%
  group_by(Photo_Sex) %>%
  summarise(
    SSI_M = mean(SSI),
    SSI_Md = median(SSI),
    SSI_Min = min(SSI),
    SSI_Max = max(SSI),
    SSI_SD = sd(SSI),
    SSI_Normality = NA,
    WHR_M = mean(WHR),
    WHR_Md = median(WHR),
    WHR_Min = min(WHR),
    WHR_Max = max(WHR),
    WHR_SD = sd(WHR),
    WHR_Normality = NA,
    RIL_M = mean(RIL),
    RIL_Md = median(RIL),
    RIL_Min = min(RIL),
    RIL_Max = max(RIL),
    RIL_SD = sd(RIL),
    RIL_Normality = NA
  )


# to make further processing easier, rename column containing subject gender
colnames(df_danel_2023)[1] <- "looker_gender"

# add missing SSR values from data found in Danel et al. (2020)
# since the 2023 sample is the same as the 2020 sample, we can just add the data
# found in Tab. 1 in Danel et al. (2020)
df_danel_2023 <- df_danel_2023 %>%
  mutate(
    SSI_Normality = c(paste("W =", 
                          paste(round(shapiro.test(df_unique[df_unique$Photo_Sex=="f",]$SSI)$statistic[[1]], 3), ",", sep=""), 
                          "p =", round(shapiro.test(df_unique[df_unique$Photo_Sex=="f",]$SSI)$p.value, 3)), 
                          paste("W =", 
                          paste(round(shapiro.test(df_unique[df_unique$Photo_Sex=="m",]$SSI)$statistic[[1]], 3), ",", sep=""), 
                          "p =", round(shapiro.test(df_unique[df_unique$Photo_Sex=="m",]$SSI)$p.value, 3), 
                          sep=" ")),
    WHR_Normality = c(paste("W =", 
                           paste(round(shapiro.test(df_unique[df_unique$Photo_Sex=="f",]$WHR)$statistic[[1]], 3), ",", sep=""), 
                           "p =", round(shapiro.test(df_unique[df_unique$Photo_Sex=="f",]$WHR)$p.value, 3)), 
                           paste("W =", 
                           paste(round(shapiro.test(df_unique[df_unique$Photo_Sex=="m",]$WHR)$statistic[[1]], 3), ",", sep=""), 
                           "p =", round(shapiro.test(df_unique[df_unique$Photo_Sex=="m",]$WHR)$p.value, 3), 
                           sep=" ")),
    RIL_Normality = c(paste("W =", 
                          paste(round(shapiro.test(df_unique[df_unique$Photo_Sex=="f",]$RIL)$statistic[[1]], 3), " ", sep=""), 
                          "p =", round(shapiro.test(df_unique[df_unique$Photo_Sex=="f",]$RIL)$p.value, 3)), 
                          paste("W =", 
                          paste(round(shapiro.test(df_unique[df_unique$Photo_Sex=="m",]$RIL)$statistic[[1]], 3), ",", sep=""), 
                          "p =", round(shapiro.test(df_unique[df_unique$Photo_Sex=="m",]$RIL)$p.value, 3), 
                          sep=" ")),
    SSR_M = c(42.36, 43.52),
    SSR_Md = c(41.71, 42.92),
    SSR_Min = c(29.59, 30.80),
    SSR_Max = c(60.80, 54.57),
    SSR_SD = c(6.92, 5.642),
    SSR_Normality = c("W = 0.978, p = 0.47", "W = 0.974, p = 0.33")
  )
df_danel_2023

# 3. Data import (Danel et al., 2020) -------------------------------------
# 
# df_danel_2020 <- tibble(
#   looker_gender = c("f", "m"),
#   SSI_M = c(1.85, 1.91),
#   SSI_Md = c(1.84, 1.91),
#   SSI_SD = c(0.095, 0.1),
#   WHR_M = c(2.65, 2.85),
#   WHR_Md = c(2.64, 2.80),
#   WHR_SD = c(0.258, 0.315),
#   RIL_M = c(37.78, 33.85),
#   RIL_Md = c(38.88, 34.74),
#   RIL_SD = c(7.30, 9.017),
#   SSR_M = c(42.36, 43.52),
#   SSR_Md = c(41.71, 42.92),
#   SSR_SD = c(6.92, 5.642)
# )
# 
# df_danel_2020 <- tibble(
#   looker_gender = c("f", "m"),
#   SSI_M = c(1.85, 1.91),
#   SSI_Md = c(1.84, 1.91),
#   SSI_Min = c(1.67, 1.68),
#   SSI_Max = c(2.1, 2.13),
#   SSI_SD = c(0.095, 0.1),
#   SSI_Normality = c("W = 0.9859, p = 0.81", "W = 0.9863, p = 0.83"),
#   WHR_M = c(2.65, 2.85),
#   WHR_Md = c(2.64, 2.80),
#   WHR_Min = c(2.19, 2.18),
#   WHR_Max = c(3.18, 3.83),
#   WHR_SD = c(0.258, 0.315),
#   WHR_Normality = c("W = 0.9744, p = 0.35", "W = 0.9662, p = 0.16"),
#   RIL_M = c(37.78, 33.85),
#   RIL_Md = c(38.88, 34.74),
#   RIL_Min = c(16.86, 16.62),
#   RIL_Max = c(54.23, 52.37),
#   RIL_SD = c(7.30, 9.017),
#   RIL_Normality = c("W = 0.9725, p = 0.29", "W = 0.9747, p = 0.36"),
#   SSR_M = c(42.36, 43.52),
#   SSR_Md = c(41.71, 42.92),
#   SSR_Min = c(29.59, 30.80),
#   SSR_Max = c(60.80, 54.57),
#   SSR_SD = c(6.92, 5.642),
#   SSR_Normality = c("W = 0.9781, p = 0.47", "W = 0.9738, p = 0.33")
# )
# 
# 
# df_danel_2020



# 4. Authors data ---------------------------------------------------------

# without min/max/normality info
# df_author <- df_avg %>%
#   group_by(looker_gender) %>%
#   summarise(
#     SSI_M = mean(ssi_alt_mm),
#     SSI_Md = median(ssi_alt_mm),
#     SSI_SD = sd(ssi_alt_mm),
#     WHR_M = mean(whr_mm),
#     WHR_Md = median(whr_mm),
#     WHD_SD = sd(whr_mm),
#     RIL_M = mean(ril),
#     RIL_Md = median(ril),
#     RIL_SD = sd(ril),
#     SSR_M = mean(ssr),
#     SSR_Md = median(ssr),
#     SSR_SD = sd(ssr)
#   )

# with min/max/normality info
df_author <- df_avg %>%
  group_by(looker_gender) %>%
  summarise(
    SSI_M = mean(ssi_mm),
    SSI_Md = median(ssi_mm),
    SSI_Min = min(ssi_mm),
    SSI_Max = max(ssi_mm),
    SSI_SD = sd(ssi_mm),
    SSI_Normality = NA,
    WHR_M = mean(whr_mm),
    WHR_Md = median(whr_mm),
    WHR_Min = min(whr_mm),
    WHR_Max = max(whr_mm),
    WHR_SD = sd(whr_mm),
    WHR_Normality = NA,
    RIL_M = mean(ril),
    RIL_Md = median(ril),
    RIL_Min = min(ril),
    RIL_Max = max(ril),
    RIL_SD = sd(ril),
    RIL_Normality = NA,
    SSR_M = mean(ssr),
    SSR_Md = median(ssr),
    SSR_Min = min(ssr),
    SSR_Max = max(ssr),
    SSR_SD = sd(ssr),
    SSR_Normality = NA,
    HEI_M = mean(hei_mm),
    HEI_Md = median(hei_mm),
    HEI_Min = min(hei_mm),
    HEI_Max = max(hei_mm),
    HEI_SD = sd(hei_mm),
    HEI_Normality = NA,
    HC_M = mean(hac),
    HC_Md = median(hac),
    HC_Min = min(hac),
    HC_Max = max(hac),
    HC_SD = sd(hac),
    HC_Normality = NA
  )


df_author <- df_author %>%
  mutate(
    SSI_Normality = c(paste("W =", 
                          paste(format(round(shapiro.test(df_avg[df_avg$looker_gender=="f",]$ssi_mm)$statistic[[1]], 3), nsmall=3), ",", sep=""), 
                          "p =", round(shapiro.test(df_avg[df_avg$looker_gender=="f",]$ssi_mm)$p.value, 3)), 
                          paste("W =", 
                          paste(format(round(shapiro.test(df_avg[df_avg$looker_gender=="m",]$ssi_mm)$statistic[[1]], 3), nsmall=3),",", sep=""), 
                          "p =", round(shapiro.test(df_avg[df_avg$looker_gender=="m",]$ssi_mm)$p.value, 3), 
                          sep=" ")),
    WHR_Normality = c(paste("W =", 
                          paste(format(round(shapiro.test(df_avg[df_avg$looker_gender=="f",]$whr_mm)$statistic[[1]], 3), nsmall=3), ",", sep=""), 
                          "p =", round(shapiro.test(df_avg[df_avg$looker_gender=="f",]$whr_mm)$p.value, 3)), 
                          paste("W =", 
                          paste(format(round(shapiro.test(df_avg[df_avg$looker_gender=="m",]$whr_mm)$statistic[[1]], 3), nsmall=3), ",", sep=""), 
                          "p =", round(shapiro.test(df_avg[df_avg$looker_gender=="m",]$whr_mm)$p.value, 3), 
                          sep=" ")),
    RIL_Normality = c(paste("W =", 
                          paste(format(round(shapiro.test(df_avg[df_avg$looker_gender=="f",]$ril)$statistic[[1]], 3), nsmall=3),",", sep=""), 
                          "p =", round(shapiro.test(df_avg[df_avg$looker_gender=="f",]$ril)$p.value, 3)), 
                          paste("W =", 
                          paste(format(round(shapiro.test(df_avg[df_avg$looker_gender=="m",]$ril)$statistic[[1]], 3), nsmall=3),",", sep=""), 
                          "p =", round(shapiro.test(df_avg[df_avg$looker_gender=="m",]$ril)$p.value, 3), 
                          sep=" ")),
    SSR_Normality = c(paste("W =", 
                          paste(format(round(shapiro.test(df_avg[df_avg$looker_gender=="f",]$ssr)$statistic[[1]], 3), nsmall=3),",", sep=""), 
                          "p =", round(shapiro.test(df_avg[df_avg$looker_gender=="f",]$ssr)$p.value, 3)), 
                          paste("W =", 
                          paste(format(round(shapiro.test(df_avg[df_avg$looker_gender=="m",]$ssr)$statistic[[1]], 3), nsmall=3), ",", sep=""), 
                          "p =", round(shapiro.test(df_avg[df_avg$looker_gender=="m",]$ssr)$p.value, 3), 
                          sep=" ")),
    HEI_Normality = c(paste("W =", 
                            paste(format(round(shapiro.test(df_avg[df_avg$looker_gender=="f",]$hei_mm)$statistic[[1]], 3), nsmall=3),",", sep=""), 
                            "p =", round(shapiro.test(df_avg[df_avg$looker_gender=="f",]$hei_mm)$p.value, 3)), 
                      paste("W =", 
                            paste(format(round(shapiro.test(df_avg[df_avg$looker_gender=="m",]$hei_mm)$statistic[[1]], 3), nsmall=3), ",", sep=""), 
                            "p =", round(shapiro.test(df_avg[df_avg$looker_gender=="m",]$hei_mm)$p.value, 3), 
                            sep=" ")),
    HC_Normality = c(paste("W =", 
                            paste(format(round(shapiro.test(df_avg[df_avg$looker_gender=="f",]$hac)$statistic[[1]], 3), nsmall=3),",", sep=""), 
                            "p =", round(shapiro.test(df_avg[df_avg$looker_gender=="f",]$hac)$p.value, 3)), 
                      paste("W =", 
                            paste(format(round(shapiro.test(df_avg[df_avg$looker_gender=="m",]$hac)$statistic[[1]], 3), nsmall=3), ",", sep=""), 
                            "p =", round(shapiro.test(df_avg[df_avg$looker_gender=="m",]$hac)$p.value, 3), 
                            sep=" ")))



view(data.frame(df_author))

# add study authors
df_danel_2023$study <- "Danel et al., 2023"
df_danel_2023

df_author$study <- "Eigene Stichprobe"
df_author



# 4. Perea Garcías Data ---------------------------------------------------

ext_xlsx_path <- "../../../Data/External Data/"
ext_xlsx_files <-  list.files(ext_csv_path, pattern="xlsx")

df_perea <- readxl::read_xlsx(paste(ext_xlsx_path, ext_xlsx_files, sep="/"))
df_perea2 <- read.csv("C:\\Users\\calti\\Documents\\Masterarbeit\\Data\\External Data\\Perea_Garcia_2022.csv")


# clean up data frame
# select Looker Gender, HC and RIL only
# filter NA values
# rename columns
df_perea_filt <- df_perea %>%
  filter(`Chimpanzee/Bonobo`==3) %>%
  select(`Male/Female`, HC_average, RIL_average) %>%
  rename("looker_gender" = `Male/Female`,
         "HC" = HC_average,
         "RIL" = RIL_average) %>%
  filter(!is.na(HC))

df_perea2_filt <- df_perea2 %>%
  filter(Species == "Homo sapiens") %>%
  select(HC) %>%  
  mutate_all(as.numeric) %>%
  filter(!is.na(HC))
df_perea2_filt

# recode gender xol
df_perea_filt$looker_gender <- ifelse(df_perea_filt$looker_gender=="2.0", "f", "m")

df_perea_filt

# with min/max/normality info
df_perea_sum <- df_perea_filt %>%
  group_by(looker_gender) %>%
  summarise(
    RIL_M = mean(RIL),
    RIL_Md = median(RIL),
    RIL_Min = min(RIL),
    RIL_Max = max(RIL),
    RIL_SD = sd(RIL),
    RIL_Normality = NA,
    HC_M = mean(HC),
    HC_Md = median(HC),
    HC_Min = min(HC),
    HC_Max = max(HC),
    HC_SD = sd(HC),
    HC_Normality = NA
  )


df_perea_sum

df_perea_sum <- df_perea_sum %>%
  mutate(
    RIL_Normality = c(paste("W =", 
                            paste(format(round(shapiro.test(df_perea_filt[df_perea_filt$looker_gender=="f",]$RIL)$statistic[[1]], 3), nsmall=3), ",", sep=""), 
                            "p =", round(shapiro.test(df_perea_filt[df_perea_filt$looker_gender=="f",]$RIL)$p.value, 3)), 
                      paste("W =", 
                            paste(format(round(shapiro.test(df_perea_filt[df_perea_filt$looker_gender=="m",]$RIL)$statistic[[1]], 3), nsmall=3),",", sep=""), 
                            "p =", round(shapiro.test(df_perea_filt[df_perea_filt$looker_gender=="m",]$RIL)$p.value, 3), 
                            sep=" ")),
    HC_Normality = c(paste("W =", 
                            paste(format(round(shapiro.test(df_perea_filt[df_perea_filt$looker_gender=="f",]$HC)$statistic[[1]], 3), nsmall=3), ",", sep=""), 
                            "p =", round(shapiro.test(df_perea_filt[df_perea_filt$looker_gender=="f",]$HC)$p.value, 3)), 
                      paste("W =", 
                            paste(format(round(shapiro.test(df_perea_filt[df_perea_filt$looker_gender=="m",]$HC)$statistic[[1]], 3), nsmall=3),",", sep=""), 
                            "p =", round(shapiro.test(df_perea_filt[df_perea_filt$looker_gender=="m",]$HC)$p.value, 3), 
                            sep=" ")))

df_perea_sum

df_perea2_sum <- df_perea2_filt %>%
  summarize(
    HC_M = mean(HC),
    HC_Md = median(HC),
    HC_Min = min(HC),
    HC_Max = max(HC),
    HC_SD = sd(HC),
    HC_Normality = NA
  )
df_perea2_sum <- df_perea2_sum %>%
  mutate(
    HC_Normality = paste("W =", 
                           paste(format(round(shapiro.test(df_perea2_filt$HC)$statistic[[1]], 3), nsmall=3), ",", sep=""), 
                           "p =", round(shapiro.test(df_perea2_filt$HC)$p.value, 3)))


df_perea2_sum

# 5. Combined Data --------------------------------------------------------

# combine own sample statistics and danel et al.'s data
# (df_comp <- rbind(df_author, df_danel_2020))
# 
# df_comp2 <- df_comp %>%
#   pivot_longer(!contains(c("looker_gender", "study"), ignore.case=FALSE),
#                names_to = c("Parameter", ".value"),
#                names_sep = "\\_")
# df_comp2
# 
# 
# df_comp3 <- df_comp2 %>%
#   pivot_longer(c("M", "Md", "SD"),
#                names_to = c("Measures"),
#                values_to = c("Values"))
# df_comp3


#-------------------------

# pivot own data to long format (one column with parameter names)
df_auth1 <- df_author %>%
  select(-study) %>%
  pivot_longer(!contains(c("looker_gender"), ignore.case=FALSE),
               names_to = c("Parameter", ".value"),
               names_sep = "\\_")
df_auth1

# pivot Danel data to long format (one column with parameter names)
df_danel1 <- df_danel_2023 %>%
  select(-study) %>%
  pivot_longer(!contains(c("looker_gender"), ignore.case=FALSE),
               names_to = c("Parameter", ".value"),
               names_sep = "\\_")  
df_danel1

df_perea1 <- df_perea_sum %>%
  pivot_longer(!contains(c("looker_gender"), ignore.case=FALSE),
               names_to = c("Parameter", ".value"),
               names_sep = "\\_")

df_perea1          

df_perea2 <- df_perea2_sum %>%
  pivot_longer(contains("HC"),
               names_to = c("Parameter", ".value"),
               names_sep = "\\_")

df_perea2

# create separate df for male and female data (own and Danel study)
df_auth_m <- df_auth1 %>%
  filter(looker_gender=="m") %>%
  select(-looker_gender)
df_auth_f <- df_auth1 %>%
    filter(looker_gender=="f") %>%
    select(M, Md, SD)

df_danel_m <- df_danel1 %>%
    filter(looker_gender=="m") %>%
    select(M, Md, SD)
df_danel_f <- df_danel1 %>%
    filter(looker_gender=="f") %>%
    select(M, Md, SD)


# get number of male and female observers
df_avg %>%
  group_by(looker_gender) %>%
  summarise(
    n = n()
  )

# create kable table 
kbl(cbind(df_auth_m, df_auth_f, df_danel_m, df_danel_f), format="html", 
    digits=2, 
    escape=F,
    font_size = 11) %>%
  add_header_above(c(" " = 1, "Männer ($n=14$)" = 3, "Frauen ($n=26$)" = 3, "Männer ($n=50%)" = 3, "Frauen ($n=50$)" = 3)) %>%
  add_header_above(c(" "=1, "Eigene Studie ($n=40$)" = 6, "Danel et al., 2020 ($n=100$)" = 6), align="l") %>%
  
  kable_classic(full_width = T, html_font = "Times New Roman")
  


df_auth_mm <- df_auth1 %>%
    filter(looker_gender=="m") %>%
    select(-looker_gender)
df_auth_ff <- df_auth1 %>%
    filter(looker_gender=="f") %>%
    select(M, Md, SD)

df_danel_mm <- df_danel1 %>%
    filter(looker_gender=="m") %>%
    select(-looker_gender)
df_danel_ff <- df_danel1 %>%
    filter(looker_gender=="f") %>%
    select(M, Md, SD)


kbl(rbind(cbind(df_auth_mm, df_auth_ff), cbind(df_danel_mm, df_danel_ff)), 
    format="html", 
    digits=2, 
    escape=F,
    font_size = 11,
    col.names = c(" ", "M", "Md", "SD", "M", "Md", "SD"),
    caption = "Tab. 1 Deskriptive Statistiken für Messungen der Photos",
    table.attr = "style='width:60%;'") %>%
  add_header_above(c(" " = 1, "Männer ($n=14$)" = 3, "Frauen ($n=26$)" = 3)) %>%
  pack_rows("Eigene Daten", 1, 4) %>%
  pack_rows("Danel et al. (2023)", 5, 8) %>%
  kable_classic(html_font = "Times New Roman") %>%
  footnote("$M$ Mittelwert, $Md$ Median, $SD$ Standardabweichung", general_title = "")

  


# df with normality and range data
df_auth_mm <- df_auth1 %>%
  filter(looker_gender=="m") %>%
  select(-looker_gender)
df_auth_ff <- df_auth1 %>%
  filter(looker_gender=="f") %>%
  select(M, Md, Min, Max, SD, Normality)

df_danel_mm <- df_danel1 %>%
  filter(looker_gender=="m") %>%
  select(-looker_gender)
df_danel_ff <- df_danel1 %>%
  filter(looker_gender=="f") %>%
  select(M, Md, Min, Max, SD, Normality)

df_perea_mm <- df_perea1 %>%
  filter(looker_gender=="m") %>%
  select(-looker_gender)
df_perea_ff <- df_perea1 %>%
  filter(looker_gender=="f") %>%
  select(M, Md, Min, Max, SD, Normality)

df_perea2_mm <- df_perea2
df_perea2_ff <- df_perea2 %>%
  select(M, Md, Min, Max, SD, Normality)
df_perea2_ff$M=""
df_perea2_ff$Md=""
df_perea2_ff$Min=""
df_perea2_ff$Max=""
df_perea2_ff$SD=""
df_perea2_ff$Normality=""
df_perea2_ff

kbl(rbind(cbind(df_auth_mm, df_auth_ff), cbind(df_danel_mm, df_danel_ff)), 
    format="html", 
    digits=2, 
    escape=F,
    font_size = 8,
    col.names = c(" ", "M", "Md", "Min", "Max", "SD", "Normality", "M", "Md", "Min", "Max", "SD", "Normality"),
    caption = "Tab. 1 Deskriptive Statistiken für Messungen der Photos",
    table.attr = "style='width:90%;'") %>%
  add_header_above(c(" " = 1, "Männer ($n=14$)" = 6, "Frauen ($n=26$)" = 6)) %>%
  pack_rows("Eigene Daten", 1, 5) %>%
  pack_rows("Danel et al. (2023)", 6, 9) %>%
  kable_classic(html_font = "Times New Roman") %>%
  footnote("$M$ Mittelwert, $Md$ Median, $Min/Max$ minimaler/maximaler Wert, $SD$ Standardabweichung, $Normality$ Ergebnis des Shapiro-Wilk-Testes auf Normalverteilung", 
           general_title = "",
           threeparttable = T,
           fixed_small_size=T)

# alternative footnote
dt_footnote <- rbind(cbind(df_auth_mm, df_auth_ff), 
                     cbind(df_danel_mm, df_danel_ff), 
                     cbind(df_perea_mm, df_perea_ff))
dt_footnote

dt_footnote[5,1] <- "HEI$^*$"
dt_footnote[6,1] <- "HC$^{*}$"

dt_footnote[dt_footnote=="HEI"] <- "HEI$^*$"
dt_footnote[dt_footnote=="HC"] <- "HC$^{*}$"

kbl(dt_footnote, 
    format="html", 
    digits=2, 
    escape=F,
    font_size = 8,
    col.names = c(" ", "M", "Md", "Min", "Max", "SD", "Normality", "M", "Md", "Min", "Max", "SD", "Normality"),
    caption = "<b>Tab. 1 Deskriptive Statistiken für Messungen der Photos</b>
    <br>Für die Vergleichsstudien werden jeweils nur die Parameter angegeben, die aufgrund der von den Autoren zur Verfügung gestellten
    Daten bestimmt werden konnten.",
    table.attr = "style='width:90%;'") %>%
  add_header_above(c(" " = 1, "Männer ($n=14$)" = 6, "Frauen ($n=26$)" = 6)) %>%
  pack_rows("Eigene Daten", 1, 6) %>%
  pack_rows("Danel et al. (2023)", 7, 10) %>%
  pack_rows("Perea García et al. (2019)", 11, 12) %>%
  kable_classic(html_font = "Times New Roman") %>%
  footnote("<i>M</i> Mittelwert,  <i>Md</i> Median,  <i>Min/Max</i> minimaler/maximaler Wert, <i>SD</i> Standardabweichung, 
            <i>Normality</i> Ergebnis des Shapiro-Wilk-Testes auf Normalverteilung,", 
           general_title = "",
           threeparttable = T,
           fixed_small_size=T,
           escape=F)

## alternative footnote 2
# alternative footnote
dt_footnote <- rbind(cbind(df_auth_mm, df_auth_ff), 
                     cbind(df_danel_mm, df_danel_ff), 
                     cbind(df_perea_mm, df_perea_ff),
                     cbind(df_perea2_mm, df_perea2_ff))

dt_footnote[13,1] <- "HC$^{*}$"
dt_footnote


dt_footnote[dt_footnote=="HEI"] <- "HEI$^*$"
dt_footnote[dt_footnote=="HC"] <- "HC$^{*}$"

kbl(dt_footnote, 
    format="html", 
    digits=2, 
    escape=F,
    font_size = 12,
    col.names = c(" ", "M", "Md", "Min", "Max", "SD", "Normality", "M", "Md", "Min", "Max", "SD", "Normality"),
    caption = "<b>Tab. 1 Deskriptive Statistiken für Messungen der Photos</b>
    <br>Für die Vergleichsstudien werden jeweils nur die Parameter angegeben, die aufgrund der von den Autoren zur Verfügung gestellten
    Daten bestimmt werden konnten.",
    table.attr = "style='width:90%;'") %>%
  add_header_above(c(" " = 1, "Männer" = 6, "Frauen" = 6)) %>%
  pack_rows("Eigene Daten\n$n=40$", 1, 6) %>%
  pack_rows("Danel et al. (2023)\n$n=100$", 7, 10) %>%
  pack_rows("Perea García et al. (2019)\n$n=47$", 11, 12) %>%
  pack_rows("Perea García et al. (2022)\n$n=20$", 13, 13) %>%
  kable_classic(html_font = "Times New Roman") %>%
  kableExtra::footnote("<i>M</i> Mittelwert,  <i>Md</i> Median,  <i>Min/Max</i> minimaler/maximaler Wert, <i>SD</i> Standardabweichung, 
            <i>Normality</i> Ergebnis des Shapiro-Wilk-Testes auf Normalverteilung,
           <br>$^{*}$ Aufgrund fehlender Angaben bezüglich des Genders der ausgewerteten Personen wurden die
           deskriptiven Statistiken des HC-Wertes für den gesamten Datensatz ohne Aufteilung nach Gender
           bestimmt und sowohl unter Männer als auch Frauen dargestellt.",
           general_title = "",
           threeparttable = T,
           fixed_small_size=T,
           escape=F)



# 99 Flextable ------------------------------------------------------------

colnames(dt_footnote) <- seq(1, 13)
dt_footnote

dt_footnote %>%
  as_flextable() %>%
  set_header_labels(`1` = "",
                    `2` = "M",
                    `3` = "Md",
                    `4` = "Min",
                    `5` = "Max",
                    `6` = "SD",
                    `7` = "Normality",
                    `8` = "M",
                    `9` = "Md",
                    `10` = "Min",
                    `11` = "Max",
                    `12` = "SD",
                    `13` = "Normality")

ft <- flextable(dt_footnote,
                cwidth=5) %>%
  set_header_labels(`1` = "",
                    `2` = "M",
                    `3` = "Md",
                    `4` = "Min",
                    `5` = "Max",
                    `6` = "SD",
                    `7` = "Normality",
                    `8` = "M",
                    `9` = "Md",
                    `10` = "Min",
                    `11` = "Max",
                    `12` = "SD",
                    `13` = "Normality") %>%
  add_header_row(values=c(" ", "Männer", "Frauen"),
                 colwidths = c(1, 6, 6)) %>%
  theme_apa() %>%
  width(j=7, width=70) %>%
  width(j=13, width=70)

ft <- align(ft, i = 1, part = "header", align = "center")
ft




dt_footnote2 <- dt_footnote
colnames(dt_footnote2) <- seq(1,13)

library(officer)
sect_properties <- prop_section(
  page_size = page_size(
    orient = "landscape",
    width = 8.3, height = 11.7
  ),
  type = "continuous",
  page_margins = page_mar()
)


dt_footnote2 %>%
  mutate(cat = c(rep("Eigene Daten", 6), 
                 rep("Danel et al. (2023)", 4), 
                 rep("Perea García et al. (2019)", 2),
                 rep("Perea García et al. (2022)", 1))) %>%
  group_by(cat) %>%
  as_flextable(hide_grouplabel=T, padding=4) %>%
  set_header_labels(`1` = "",
                    `2` = "M",
                    `3` = "Md",
                    `4` = "Min",
                    `5` = "Max",
                    `6` = "SD",
                    `7` = "Normality",
                    `8` = "M",
                    `9` = "Md",
                    `10` = "Min",
                    `11` = "Max",
                    `12` = "SD",
                    `13` = "Normality") %>%
  add_header_row(values=c(" ", "Männer", "Frauen"),
                 colwidths = c(1, 6, 6)) %>%
  theme_apa() %>%
  width(j=7, width=70) %>%
  width(j=13, width=70) %>%
  bold(j = 1, i = ~ !is.na(cat), bold = TRUE, part = "body" ) %>%
  align(j = 1, i = ~ !is.na(cat), align = "left", part = "body" ) %>%
  height_all(height = 1) %>%
  line_spacing(i = seq(2,7), space = 0.7, part = "body") %>%
  line_spacing(i = seq(9,12), space = 0.7, part = "body") %>%
  line_spacing(i = seq(14,15), space = 0.7, part = "body") %>%
  line_spacing(i = 17, space = 0.7, part = "body") %>%
  add_footer_lines(values = "") %>%
  #compose(i = 1, j = 1, value = as_paragraph(as_i("Note: ")), part = "footer")
  compose(i = 1, j = 1, value = as_paragraph(as_i("M "), " Mittelwert,   ", 
                                             as_i("Md "), " Median,   ",
                                             as_i("Min/Max "), " Minimaler/Maximaler Wert,   ",
                                             as_i("SD "), "Standardabweichung,   ",
                                             as_i("Normality "), "Ergebnis des Shapiro-Wilk-Testes auf Normalverteilung"), part = "footer") %>%
  add_header_row(values="Tab. 1 Deskriptivstatistiken der Auswertung der Photos
                 Für die Vergleichsstudien werden jeweils nur die Parameter angegeben, die aufgrund der von den Autoren zur Verfügung gestellten
    Daten bestimmt werden konnten.",
                 colwidths = (13)) %>%
  font(part="all", font="Times New Roman") %>%
  hline(i=c(1, 8, 13, 16), part="body") %>%
  autofit() %>%
  save_as_docx(path="../../results/Tan1.docx")
  
  
  add_footer_row(values = c("M Mittelwert, Md Median, Min/Max Minimaler/Maximaler Wert, SD Standardabweichung"),
                 colwidths = c(13),
                 top=T)



xray::distributions(df_avg_mm)
funModeling::plot_num(avg[,-c("looker_id", "looker_id_seq")])
avg <- as.data.table(df_avg)
avg[,-c("looker_id", "looker_id_seq")]  
