
# 1. Libraries ------------------------------------------------------------


library(sf)
library(tidyverse)
library(future.apply)
plan(multisession)
source("Scripts/99_Max_Perpendicular_Lines.R")
rstudioapi::writeRStudioPreference("data_viewer_max_columns", 100L)

# 2. Batch Processing --------------------------------------------------------


# 2.1. Get file list and create empty df ----------------------------------

# get relevant csv file paths
polygon_csv_files <- list.files("../../Data/ROI (Experiment 1)/", pattern=glob2rx("*Area_Left*.csv|*Area_Right*.csv"))
area_csv_files <- list.files("../../Data/ROI (Experiment 1)/", pattern=glob2rx("*Area_Measurements*"))
density_csv_files <- list.files("../../Data/ROI (Experiment 1)/", pattern=glob2rx("*HaC*.csv|*HrC*.csv"))


# read all density csv files to list (for luminance based measures)
df_pol <- list()

for(ids in seq(1,length(polygon_csv_files))){
  abs_path_pol <- paste("../../Data/ROI (Experiment 1)/", fsep = "/", polygon_csv_files[ids], sep = "")
  df_pol[[polygon_csv_files[ids]]] <- read.csv(abs_path_pol)
}


# read all complete area csv files to list (for eye opening, sclera, iris-pupil-area etc.)
df_area <- list()
for(ids in seq(1,length(area_csv_files))){
  abs_path_area <- paste("../../Data/ROI (Experiment 1)/", fsep = "/", area_csv_files[ids], sep = "")
  df_area[[area_csv_files[ids]]] <- read.csv(abs_path_area)
}


# read all density csv files to list
df_dens <- list()
for(ids in seq(1,length(density_csv_files))){
  abs_path_density <- paste("../../Data/ROI (Experiment 1)/", fsep = "/", density_csv_files[ids], sep = "")
  df_dens[[density_csv_files[ids]]] <- read.csv(abs_path_density)
}

# declutter workspace
rm(abs_path_area, abs_path_pol, abs_path_density, ids, area_csv_files, density_csv_files, polygon_csv_files)

# creaty empty data frame
df_complete <- data.frame(looker_id = double(),
                          looker_id_seq = double(),
                          looker_gender = character(),
                          width_left_px = double(),
                          width_left_mm = double(),
                          width_horiz_left_mm = double(),
                          sc_width_left_px = double(),
                          sc_width_left_mm = double(),
                          sc_width_horiz_left_mm = double(),
                          ir_width_left_px = double(),
                          ir_width_left_mm = double(),
                          ir_width_horiz_left_mm = double(),
                          ir_width_alt_left_px = double(),
                          ir_width_alt_left_mm = double(),
                          width_right_px = double(),
                          width_right_mm = double(),
                          width_horiz_right_mm = double(),
                          sc_width_right_px = double(),
                          sc_width_right_mm = double(),
                          sc_width_horiz_right_mm = double(),
                          ir_width_right_px = double(),
                          ir_width_right_mm = double(),
                          ir_width_horiz_right_mm = double(),
                          ir_width_alt_right_px = double(),
                          ir_width_alt_right_mm = double(),
                          height_left_px = double(),
                          height_left_mm = double(),
                          sc_height_left_px = double(),
                          sc_height_left_mm = double(),
                          ir_height_left_px = double(),
                          ir_height_left_mm = double(),
                          height_right_px = double(),
                          height_right_mm = double(),
                          sc_height_right_px = double(),
                          sc_height_right_mm = double(),
                          ir_height_right_px = double(),
                          ir_height_right_mm = double(),
                          complete_area_left = double(),
                          complete_area_right = double(),
                          eye_opening_area_left = double(),
                          eye_opening_area_right = double(),
                          iris_pupil_area_left = double(),
                          iris_pupil_area_right = double(),
                          sclera_area_left = double(),
                          sclera_area_right = double(),
                          hac_left = double(),
                          hac_right = double(),
                          hrc_left = double(),
                          hrc_right = double(),
                          ril_left = double(),
                          ril_right = double(),
                          luminance_slope_left = double(),
                          luminance_slope_right = double(),
                          width_px = double(),
                          width_mm = double(),
                          width_hor_mm = double(),
                          sc_width_px = double(),
                          sc_width_mm = double(),
                          sc_width_hor_mm = double(),
                          ir_width_px = double(),
                          ir_width_mm = double(),
                          ir_width_hor_mm = double(),
                          ir_width_alt_px = double(),
                          ir_width_alt_mm = double(),
                          height_px = double(),
                          height_mm = double(),
                          sc_height_px = double(),
                          sc_height_mm = double(),
                          ir_height_px = double(),
                          ir_height_mm = double(),
                          complete_area = double(),
                          eye_opening_area = double(),
                          iris_pupil_area = double(),
                          sclera_area = double(),
                          hac = double(),
                          hrc = double(),
                          ril = double(),
                          lum_slope = double(),
                          lum_slope_abs = double(),
                          whr_px = double(),
                          whr_mm = double(),
                          ssi_px = double(),
                          ssi_mm = double(),
                          ssi_alt_px = double(),
                          ssi_alt_mm = double(),
                          ssr = double(),
                          hei_left_px = double(),
                          hei_left_mm = double(),
                          hei_right_px = double(),
                          hei_right_mm = double(),
                          hei_px = double(),
                          hei_mm = double())

# empty data frame for pixel coordinates of eye morphology features
df_pixel_vals <- data.frame(
  looker_id = double(),
  width_left_x1 = double(),
  width_left_x2 = double(),
  width_left_y1 = double(),
  width_left_y2 = double(),
  width_right_x1 = double(),
  width_right_x2 = double(),
  width_right_y1 = double(),
  width_right_y2 = double(),
  sc_width_left_x1 = double(),
  sc_width_left_x2 = double(),
  sc_width_left_y1 = double(),
  sc_width_left_y2 = double(),
  sc_width_right_x1 = double(),
  sc_width_right_x2 = double(),
  sc_width_right_y1 = double(),
  sc_width_right_y2 = double(),  
  ir_width_left_x1 = double(),
  ir_width_left_x2 = double(),
  ir_width_left_y1 = double(),
  ir_width_left_y2 = double(),
  ir_width_right_x1 = double(),
  ir_width_right_x2 = double(),
  ir_width_right_y1 = double(),
  ir_width_right_y2 = double()
)

# get unique looker ids
unique_looker_names <- unique(substr(names(df_dens), 1, 3))
cat("\nThere are ", length(unique_looker_names), " unique looker ids.\n")


# 2.2. Processing of files in file list -------------------------------------

# Get lists of polygons [px, mm]
pol_list_px <- lapply(df_pol, function(x) st_polygon(list(as.matrix(rbind(x[,1:2], x[1,1:2])))))
pol_list_mm <- lapply(df_pol, function(x) st_polygon(list(as.matrix(rbind(x[,3:4], x[1,3:4])))))

# number of valid cases
sum(vali <- sapply(pol_list_px, function(x) st_is_valid(x)))

## PIXEL BASED CALCULATIONS
# get polygon points defining the longest line within polygon describing the 
# eye opening area incl. caruncula lacrimalis and longest line within the polygon
# perpendicular to the longest line (px)
ch_list_px <- lapply(pol_list_px, function(a) max_chord(a))
pch_list_px <- future_mapply(find_max_chord, pol_list_px, ch_list_px, SIMPLIFY = FALSE)

pch_length_list_px <- lapply(pch_list_px, function(x) st_length(x))
ch_linestr_list_px = lapply(ch_list_px, function(x) st_linestring(x, dim="XY"))
ch_length_list_px <- lapply(ch_linestr_list_px, function(x) st_length(x))


## MM BASED CALCULATIONS
# get polygon points defining the longest line within polygon describing the 
# eye opening area incl. caruncula lacrimalis and longest line within the polygon
# perpendicular to the longest line (mm)
ch_list_mm <- lapply(pol_list_mm, function(a) max_chord(a))
pch_list_mm <- future_mapply(find_max_chord, pol_list_mm, ch_list_mm, SIMPLIFY = FALSE, future.seed=TRUE)

pch_length_list_mm <- lapply(pch_list_mm, function(x) st_length(x)) # length of perpendicular lines [mm]
ch_linestr_list_mm = lapply(ch_list_mm, function(x) st_linestring(x, dim="XY")) # create linestring from chord coordinates
ch_length_list_mm <- lapply(ch_linestr_list_mm, function(x) st_length(x)) # length of longest line within polygon


# alternative iris width / diameter measurements
# basically the length of the eye opening area line within the pupil
iris_pol_list_px <- pol_list_px[grepl("Iris_Pupil_Area", names(pol_list_px))]
eoa_ch_list_px <- ch_linestr_list_px[grepl("Eye_Opening_Area", names(ch_linestr_list_px))]

iris_pol_list_mm <- pol_list_mm[grepl("Iris_Pupil_Area", names(pol_list_mm))]
eoa_ch_list_mm <- ch_linestr_list_mm[grepl("Eye_Opening_Area", names(ch_linestr_list_mm))]


iris_width_linestr_list_px <- mapply(st_intersection, iris_pol_list_px, eoa_ch_list_px, SIMPLIFY = FALSE)
iris_width_list_alt_px <- lapply(iris_width_linestr_list_px, st_length)

iris_width_linestr_list_mm <- mapply(st_intersection, iris_pol_list_mm, eoa_ch_list_mm, SIMPLIFY = FALSE)
iris_width_list_alt_mm <- lapply(iris_width_linestr_list_mm, st_length)



for(i in seq(1:length(unique_looker_names))){
  
  # alternative iris width measurements for current looker (i)
  iris_width_list_alt_px_tmp <- iris_width_list_alt_px[grepl(unique_looker_names[i], names(iris_width_list_alt_px))]
  iris_width_list_alt_mm_tmp <- iris_width_list_alt_mm[grepl(unique_looker_names[i], names(iris_width_list_alt_mm))]
  
  iris_width_linestr_px_tmp <- iris_width_linestr_list_px[grepl(unique_looker_names[i], names(iris_width_linestr_list_px))]
  
  # get complete area measurement df from list for current looker (i)
  df_area_tmp <- df_area[[i]] %>%
    filter(!grepl("Scale",Label)) %>%
    separate_wider_delim(Label, ':', names=c("Filename", "ROI_Label")) %>%
    arrange(ROI_Label)
  
  ## get luminance based measurements for current looker (i)
  df_lum_tmp <- df_dens[grepl(unique_looker_names[i], names(df_dens))]
  
  # maximum and minimum gray values
  max_gray_val <- sapply(df_lum_tmp, function(x) x[[which.max(x[,2]),2]])
  min_gray_val <- sapply(df_lum_tmp, function(x) x[[which.min(x[,2]),2]])
  
  # location (x axis in mm) of maximum and minimum gray values
  max_gray_mm <- sapply(df_lum_tmp, function(x) x[[which.max(x[,2]), 1]])
  min_gray_mm <- sapply(df_lum_tmp, function(x) x[[which.min(x[,2]), 1]])
  
  # highest absolute and relative (sclera-iris) contrast values
  hxc <- max_gray_val-min_gray_val
  
  # highest absolute contrast values for left and right eye
  hac <- hxc[1:2]
  
  # highest relative contrast value for left and right eye
  hrc <- hxc[3:4]
  
  # relative iris luminance for left and right eye (in percent)
  ril <- (min_gray_val[1:2]/max_gray_val[1:2])*100
  
  # luminance gray_val_slope (positive gray_val_slope: highest luminance on right side of pupil, negative gray_val_slope: highest luminance on left side of pupil)  
  gray_val_slope <- (max_gray_val[1:2]-min_gray_val[1:2])/(max_gray_mm[1:2]-min_gray_mm[1:2])
  
  # get relevant subsets of lists
  # coordinates of longest lines
  ch_px_tmp <- ch_list_px[grepl(unique_looker_names[i], names(ch_list_px))]
  pch_px_tmp <- pch_list_px[grepl(unique_looker_names[i], names(pch_list_px))]
  
  # length measurements in px and mm (longest overall lines)
  length_ch_px_tmp <- ch_length_list_px[grepl(unique_looker_names[i], names(ch_length_list_px))] # longest width [px]
  length_ch_mm_tmp <- ch_length_list_mm[grepl(unique_looker_names[i], names(ch_length_list_mm))] # longest width [mm]
  
  # length measurements in px and mm (longest lines perpendicular to longest overall lines)
  length_pch_px_tmp <- pch_length_list_px[grepl(unique_looker_names[i], names(pch_length_list_px))] # longest width [px]
  length_pch_mm_tmp <- pch_length_list_mm[grepl(unique_looker_names[i], names(pch_length_list_mm))] # longest width [mm]
  
  
  # add measurements to data frame
  df_complete[i, "looker_id"] <- unique_looker_names[i]
  df_complete[i, "looker_id_seq"] <- i
  df_complete[i, "looker_gender"] <- tolower(substr(unique_looker_names[i], 1, 1))
  
  # Width (incl. caruncula lacrimalis), sclera width and iris width [pixel]
  df_complete[i, "width_left_px"] <- length_ch_px_tmp[[1]]
  df_complete[i, "width_right_px"] <- length_ch_px_tmp[[2]]
  df_complete[i, "sc_width_left_px"] <- length_ch_px_tmp[[3]]
  df_complete[i, "sc_width_right_px"] <- length_ch_px_tmp[[4]]
  df_complete[i, "ir_width_left_px"] <- length_ch_px_tmp[[5]]
  df_complete[i, "ir_width_right_px"] <- length_ch_px_tmp[[6]]

  # Width (incl. caruncula lacrimalis), sclera width and iris width [mm]
  df_complete[i, "width_left_mm"] <- length_ch_mm_tmp[[1]]
  df_complete[i, "width_right_mm"] <- length_ch_mm_tmp[[2]]
  df_complete[i, "sc_width_left_mm"] <- length_ch_mm_tmp[[3]]
  df_complete[i, "sc_width_right_mm"] <- length_ch_mm_tmp[[4]]
  df_complete[i, "ir_width_left_mm"] <- length_ch_mm_tmp[[5]]
  df_complete[i, "ir_width_right_mm"] <- length_ch_mm_tmp[[6]]
  
  # height, sclera height and iris height [pixel]
  df_complete[i, "height_left_px"] <- length_pch_px_tmp[[1]]
  df_complete[i, "height_right_px"] <- length_pch_px_tmp[[2]]
  df_complete[i, "sc_height_left_px"] <- length_pch_px_tmp[[3]]
  df_complete[i, "sc_height_right_px"] <- length_pch_px_tmp[[4]]
  df_complete[i, "ir_height_left_px"] <- length_pch_px_tmp[[5]]
  df_complete[i, "ir_height_right_px"] <- length_pch_px_tmp[[6]]

  # height, sclera height and iris height [mm]
  df_complete[i, "height_left_mm"] <- length_pch_mm_tmp[[1]]
  df_complete[i, "height_right_mm"] <- length_pch_mm_tmp[[2]]
  df_complete[i, "sc_height_left_mm"] <- length_pch_mm_tmp[[3]]
  df_complete[i, "sc_height_right_mm"] <- length_pch_mm_tmp[[4]]
  df_complete[i, "ir_height_left_mm"] <- length_pch_mm_tmp[[5]]
  df_complete[i, "ir_height_right_mm"] <- length_pch_mm_tmp[[6]]
  
  # complete area (incl. caruncula lacrimalis), eye opening area 
  # (sclera + iris + pupil excl. c.l.), iris area (incl. pupil) [mm2]  
  df_complete[i, "complete_area_left"] <- df_area_tmp[[1,"Area"]]
  df_complete[i, "complete_area_right"] <- df_area_tmp[[2,"Area"]]
  df_complete[i, "eye_opening_area_left"] <- df_area_tmp[[3,"Area"]]
  df_complete[i, "eye_opening_area_right"] <- df_area_tmp[[4,"Area"]]
  df_complete[i, "iris_pupil_area_left"] <- df_area_tmp[[5,"Area"]]
  df_complete[i, "iris_pupil_area_right"] <- df_area_tmp[[6,"Area"]]
  
  # alternative measurements for width, sclera and iris width [mm]
  # these values represent the length of a horizontal bounding box that use 
  # the bounding features (i.e. left and right commissurae or iris points most 
  # to the left and right) as limiting points for horizontal elongation. This 
  # way these measurements reflect the horizontal elongation of each structures 
  # (i.e. width measures horizontally compared to width measured as longest
  # distance between left and right commissurae that in most cases is a skewed 
  # line)
  df_complete[i, "width_horiz_left_mm"] <- df_area_tmp[[1, "Width"]]
  df_complete[i, "width_horiz_right_mm"] <- df_area_tmp[[2, "Width"]]
  df_complete[i, "sc_width_horiz_left_mm"] <- df_area_tmp[[3, "Width"]]
  df_complete[i, "sc_width_horiz_right_mm"] <- df_area_tmp[[4, "Width"]]
  df_complete[i, "ir_width_horiz_left_mm"] <- df_area_tmp[[5, "Width"]]
  df_complete[i, "ir_width_horiz_right_mm"] <- df_area_tmp[[6, "Width"]]
  df_complete[i, "iris_centroid_y_left_mm"] <- df_area_tmp[[5, "Y"]]
  df_complete[i, "iris_centroid_y_right_mm"] <- df_area_tmp[[6, "Y"]]
  
  # luminance (gray value brightness) based parameter
  # hac = highest contrast (absolute difference between highest and lowest gray 
  # value (measured including the pupil in the rectange drawn in ImageJ to 
  # obtain density plot))
  # hrc = like hac but excluding pupil
  # ril = relative iris luminance (minimum gray value/maximum gray value x 100)
  # luminance slope: slope of line connecting highest and lowest gray value as 
  # measure for "sharpness" of high to low luminance transition (between sclera
  # and pupil)
  df_complete[i, "hac_left"] <- hac[1]
  df_complete[i, "hac_right"] <- hac[2]
  df_complete[i, "hrc_left"] <- hrc[1]
  df_complete[i, "hrc_right"] <- hrc[2]
  df_complete[i, "ril_left"] <- ril[1]*100
  df_complete[i, "ril_right"] <- ril[2]*100
  df_complete[i, "luminance_slope_left"] <- gray_val_slope[1]
  df_complete[i, "luminance_slope_right"] <- gray_val_slope[2]
  df_complete[i, "luminance_slope_abs_left"] <- abs(gray_val_slope[1])
  df_complete[i, "luminance_slope_abs_right"] <- abs(gray_val_slope[2])
  
  # alternative measurements for iris widht [pixel, mm]
  # here the iris width is not the longest line connecting any two points within
  # the iris area polygon, but the length of the segment of the line between
  # medial and lateral commissurae that lies within the iris polygon. This way,
  # the iris width is measured parallel to the sclera width line
  # Implemented these for measures more consistent with the literature (i.e.
  # Danel et al., 2020)
  df_complete[i, "ir_width_alt_left_px"] <- iris_width_list_alt_px_tmp[[1]]
  df_complete[i, "ir_width_alt_right_px"] <- iris_width_list_alt_px_tmp[[2]]
  df_complete[i, "ir_width_alt_left_mm"] <- iris_width_list_alt_mm_tmp[[1]]
  df_complete[i, "ir_width_alt_right_mm"] <- iris_width_list_alt_mm_tmp[[2]]
  
  # mean values for (overall, sclera, iris) width and height,
  # (overall, eye opening, iris+pupil) areas, luminance based values,
  # ssi and ssr
  # since sample sizes of each constituting variables are equal the mean of
  # means equals the grand mean
  df_complete[i, "width_px"] <- mean(length_ch_px_tmp[[1]], length_ch_px_tmp[[2]])
  df_complete[i, "width_mm"] <- mean(length_ch_mm_tmp[[1]], length_ch_mm_tmp[[2]])
  df_complete[i, "width_hor_mm"] <- mean(df_area_tmp[[1, "Width"]], df_area_tmp[[2, "Width"]])
  df_complete[i, "sc_width_px"] <- mean(length_ch_px_tmp[[3]], length_ch_px_tmp[[4]])
  df_complete[i, "sc_width_mm"] <- mean(length_ch_mm_tmp[[3]], length_ch_mm_tmp[[4]])
  df_complete[i, "sc_width_hor_mm"] <- mean(df_area_tmp[[3, "Width"]], df_area_tmp[[4, "Width"]])
  df_complete[i, "ir_width_px"] <- mean(length_ch_px_tmp[[5]], length_ch_px_tmp[[6]])
  df_complete[i, "ir_width_mm"] <- mean(length_ch_mm_tmp[[5]], length_ch_mm_tmp[[6]])
  df_complete[i, "ir_width_hor_mm"] <- mean(df_area_tmp[[5, "Width"]], df_area_tmp[[6, "Width"]])
  df_complete[i, "ir_width_alt_mm"] <- mean(iris_width_list_alt_mm_tmp[[1]], iris_width_list_alt_mm_tmp[[2]])  
  df_complete[i, "ir_width_alt_px"] <- mean(iris_width_list_alt_px_tmp[[1]], iris_width_list_alt_px_tmp[[2]])  
  df_complete[i, "height_px"] <- mean(length_pch_px_tmp[[1]], length_pch_px_tmp[[2]])
  df_complete[i, "height_mm"] <- mean(length_pch_mm_tmp[[1]], length_pch_mm_tmp[[2]])
  df_complete[i, "sc_height_px"] <- mean(length_pch_px_tmp[[3]], length_pch_px_tmp[[4]])
  df_complete[i, "sc_height_mm"] <- mean(length_pch_mm_tmp[[3]], length_pch_mm_tmp[[4]])  
  df_complete[i, "ir_height_px"] <- mean(length_pch_px_tmp[[5]], length_pch_px_tmp[[6]])
  df_complete[i, "ir_height_mm"] <- mean(length_pch_mm_tmp[[5]], length_pch_mm_tmp[[6]])  
  df_complete[i, "complete_area"] <- mean(df_area_tmp[[1,"Area"]], df_area_tmp[[2,"Area"]])
  df_complete[i, "eye_opening_area"] <- mean(df_area_tmp[[3,"Area"]], df_area_tmp[[4,"Area"]])
  df_complete[i, "iris_pupil_area"] <- mean(df_area_tmp[[5,"Area"]], df_area_tmp[[6,"Area"]]) 
  df_complete[i, "sclera_area"] <- mean((df_area_tmp[[3,"Area"]]-df_area_tmp[[5,"Area"]]), (df_area_tmp[[4,"Area"]]-df_area_tmp[[6,"Area"]]))
  df_complete[i, "hac"] <- mean(hac)
  df_complete[i, "hrc"] <- mean(hrc)  
  df_complete[i, "ril"] <- mean(ril)
  df_complete[i, "lum_slope"] <- mean(gray_val_slope)
  df_complete[i, "lum_slope_abs"] <- mean(abs(gray_val_slope)) 
  df_complete[i, "whr_px"] <- mean((length_ch_px_tmp[[1]]/length_pch_px_tmp[[1]]), (length_ch_px_tmp[[2]]/length_pch_px_tmp[[2]]))
  df_complete[i, "whr_mm"] <- mean((length_ch_mm_tmp[[1]]/length_pch_mm_tmp[[1]]), (length_ch_mm_tmp[[2]]/length_pch_mm_tmp[[2]]))
  df_complete[i, "ssi_px"] <- mean((length_ch_px_tmp[[3]]/length_ch_px_tmp[[5]]), (length_ch_px_tmp[[4]]/length_ch_px_tmp[[6]]))
  df_complete[i, "ssi_mm"] <- mean((length_ch_mm_tmp[[3]]/length_ch_mm_tmp[[5]]), (length_ch_mm_tmp[[4]]/length_ch_mm_tmp[[6]]))
  df_complete[i, "ssi_alt_px"] <- mean((length_ch_px_tmp[[3]]/iris_width_list_alt_px_tmp[[1]]), (length_ch_px_tmp[[4]]/iris_width_list_alt_px_tmp[[2]]))  
  df_complete[i, "ssi_alt_mm"] <- mean((length_ch_mm_tmp[[3]]/iris_width_list_alt_mm_tmp[[1]]), (length_ch_mm_tmp[[4]]/iris_width_list_alt_mm_tmp[[2]]))  
  df_complete[i, "ssr"] <- mean(((df_area_tmp[[3,"Area"]]-df_area_tmp[[5,"Area"]])/df_area_tmp[[3,"Area"]]), ((df_area_tmp[[4,"Area"]]-df_area_tmp[[6,"Area"]])/df_area_tmp[[4,"Area"]]))*100 
  
  # horizontal elongation index values separate for each eye and combined
  df_complete[i, "hei_left_px"] <- (df_complete[i, "width_left_px"])^2/df_complete[i, "eye_opening_area_left"]
  df_complete[i, "hei_left_mm"] <- (df_complete[i, "width_left_mm"])^2/df_complete[i, "eye_opening_area_left"]
  df_complete[i, "hei_right_px"] <- (df_complete[i, "width_right_px"])^2/df_complete[i, "eye_opening_area_right"]
  df_complete[i, "hei_right_mm"] <- (df_complete[i, "width_right_mm"])^2/df_complete[i, "eye_opening_area_right"]
  df_complete[i, "hei_mm"] <- mean(df_complete[i, "hei_left_mm"], df_complete[i, "hei_right_mm"])
  df_complete[i, "hei_px"] <- mean(df_complete[i, "hei_left_px"], df_complete[i, "hei_right_px"])
  
  
  # pixel coordinate values for drawing measurements on
  # sample image of eye region in python
  df_pixel_vals[i, "looker_id"] <- unique_looker_names[i]
  df_pixel_vals[i, "width_left_x1"] <- ch_px_tmp[[1]][1]
  df_pixel_vals[i, "width_left_x2"] <- ch_px_tmp[[1]][2]
  df_pixel_vals[i, "width_left_y1"] <- ch_px_tmp[[1]][3]
  df_pixel_vals[i, "width_left_y2"] <- ch_px_tmp[[1]][4]
  df_pixel_vals[i, "width_right_x1"] <- ch_px_tmp[[2]][1]
  df_pixel_vals[i, "width_right_x2"] <- ch_px_tmp[[2]][2]
  df_pixel_vals[i, "width_right_y1"] <- ch_px_tmp[[2]][3]
  df_pixel_vals[i, "width_right_y2"] <- ch_px_tmp[[2]][4]
  df_pixel_vals[i, "sc_width_left_x1"] <- ch_px_tmp[[3]][1]
  df_pixel_vals[i, "sc_width_left_x2"] <- ch_px_tmp[[3]][2]
  df_pixel_vals[i, "sc_width_left_y1"] <- ch_px_tmp[[3]][3]
  df_pixel_vals[i, "sc_width_left_y2"] <- ch_px_tmp[[3]][4]
  df_pixel_vals[i, "sc_width_right_x1"] <- ch_px_tmp[[4]][1]
  df_pixel_vals[i, "sc_width_right_x2"] <- ch_px_tmp[[4]][2]
  df_pixel_vals[i, "sc_width_right_y1"] <- ch_px_tmp[[4]][3]
  df_pixel_vals[i, "sc_width_right_y2"] <- ch_px_tmp[[4]][4] 
  df_pixel_vals[i, "ir_width_left_x1"] <- ch_px_tmp[[5]][1]
  df_pixel_vals[i, "ir_width_left_x2"] <- ch_px_tmp[[5]][2]
  df_pixel_vals[i, "ir_width_left_y1"] <- ch_px_tmp[[5]][3]
  df_pixel_vals[i, "ir_width_left_y2"] <- ch_px_tmp[[5]][4]
  df_pixel_vals[i, "ir_width_right_x1"] <- ch_px_tmp[[6]][1]
  df_pixel_vals[i, "ir_width_right_x2"] <- ch_px_tmp[[6]][2]
  df_pixel_vals[i, "ir_width_right_y1"] <- ch_px_tmp[[6]][3]
  df_pixel_vals[i, "ir_width_right_y2"] <- ch_px_tmp[[6]][4]
  
  df_pixel_vals[i, "ir_width_left_alt_x1"] <- iris_width_linestr_px_tmp[[1]][1]
  df_pixel_vals[i, "ir_width_left_alt_x2"] <- iris_width_linestr_px_tmp[[1]][2]
  df_pixel_vals[i, "ir_width_left_alt_y1"] <- iris_width_linestr_px_tmp[[1]][3]
  df_pixel_vals[i, "ir_width_left_alt_y2"] <- iris_width_linestr_px_tmp[[1]][4]
  df_pixel_vals[i, "ir_width_right_alt_x1"] <- iris_width_linestr_px_tmp[[2]][1]
  df_pixel_vals[i, "ir_width_right_alt_x2"] <- iris_width_linestr_px_tmp[[2]][2]
  df_pixel_vals[i, "ir_width_right_alt_y1"] <- iris_width_linestr_px_tmp[[2]][3]
  df_pixel_vals[i, "ir_width_right_alt_y2"] <- iris_width_linestr_px_tmp[[2]][4]
  
  df_pixel_vals[i, "height_left_x1"] <- pch_px_tmp[[1]][1]
  df_pixel_vals[i, "height_left_x2"] <- pch_px_tmp[[1]][2]
  df_pixel_vals[i, "height_left_y1"] <- pch_px_tmp[[1]][3]
  df_pixel_vals[i, "height_left_y2"] <- pch_px_tmp[[1]][4]
  df_pixel_vals[i, "height_right_x1"] <- pch_px_tmp[[2]][1]
  df_pixel_vals[i, "height_right_x2"] <- pch_px_tmp[[2]][2]
  df_pixel_vals[i, "height_right_y1"] <- pch_px_tmp[[2]][3]
  df_pixel_vals[i, "height_right_y2"] <- pch_px_tmp[[2]][4]
  df_pixel_vals[i, "sc_height_left_x1"] <- pch_px_tmp[[3]][1]
  df_pixel_vals[i, "sc_height_left_x2"] <- pch_px_tmp[[3]][2]
  df_pixel_vals[i, "sc_height_left_y1"] <- pch_px_tmp[[3]][3]
  df_pixel_vals[i, "sc_height_left_y2"] <- pch_px_tmp[[3]][4]
  df_pixel_vals[i, "sc_height_right_x1"] <- pch_px_tmp[[4]][1]
  df_pixel_vals[i, "sc_height_right_x2"] <- pch_px_tmp[[4]][2]
  df_pixel_vals[i, "sc_height_right_y1"] <- pch_px_tmp[[4]][3]
  df_pixel_vals[i, "sc_height_right_y2"] <- pch_px_tmp[[4]][4] 
  df_pixel_vals[i, "ir_height_left_x1"] <- pch_px_tmp[[5]][1]
  df_pixel_vals[i, "ir_height_left_x2"] <- pch_px_tmp[[5]][2]
  df_pixel_vals[i, "ir_height_left_y1"] <- pch_px_tmp[[5]][3]
  df_pixel_vals[i, "ir_height_left_y2"] <- pch_px_tmp[[5]][4]
  df_pixel_vals[i, "ir_height_right_x1"] <- pch_px_tmp[[6]][1]
  df_pixel_vals[i, "ir_height_right_x2"] <- pch_px_tmp[[6]][2]
  df_pixel_vals[i, "ir_height_right_y1"] <- pch_px_tmp[[6]][3]
  df_pixel_vals[i, "ir_height_right_y2"] <- pch_px_tmp[[6]][4]
}




## calculate measures described by Kobayashi & Kohshima (WHR, SSI) 
# and Kano et al. (2021, SAI, named here SSR)
df_complete <- df_complete %>%
  mutate(sclera_area_left = eye_opening_area_left-iris_pupil_area_left,
         sclera_area_right = eye_opening_area_right-iris_pupil_area_right,
         whr_left_px = width_left_px/height_left_px,
         whr_left_mm = width_left_mm/height_left_mm,
         whr_right_px = width_right_px/height_right_px,
         whr_right_mm = width_right_mm/height_right_mm,
         ssi_left_px = sc_width_left_px/ir_width_left_px,
         ssi_left_mm = sc_width_left_mm/ir_width_left_mm,
         ssi_alt_left_px = sc_width_left_px/ir_width_alt_left_px,
         ssi_alt_left_mm = sc_width_left_mm/ir_width_alt_left_mm,
         ssi_right_px = sc_width_right_px/sc_height_right_px,
         ssi_right_mm = sc_width_right_mm/sc_height_right_mm,
         ssi_alt_right_px = sc_width_right_px/ir_width_alt_right_px,
         ssi_alt_right_mm = sc_width_right_mm/ir_width_alt_right_mm,         
         ssr_left = (sclera_area_left/eye_opening_area_left)*100,
         ssr_right = (sclera_area_right/eye_opening_area_right)*100,
         ) 

# df with mean eye morphology parameters for left and right eye 
df_avg <- df_complete %>%
  select(!contains(c("left", "right")))

# df with mean eye morphology parameters for left and right eye (pixel values)
df_avg_px <- df_avg %>%
  select(!contains(("mm")))

# df with mean eye morphology parameters for left and right eye (mm values)
df_avg_mm <- df_avg %>%
  select(!contains(("px")))

# check sd of mean vars (complete avg df, px avg df, mm avg df)
format(apply(df_avg, 2, sd), scientific = F)
format(apply(df_avg_px, 2, sd), scientific = F)
format(apply(df_avg_mm, 2, sd), scientific = F)

colMeans(select(df_avg_mm, !contains("looker")))
  

# 2.3. Save Dataframes ----------------------------------------------------

write.csv(x = df_avg_mm, file="../../Data/Data Experiment 1 (Eye Morphology)/Eye_Measurements_avg_mm.csv")

# 2.3.1. Complete DF (px and mm, wide) ------------------------------------

## Rename levels of Gender var
# df_complete <- df_complete %>% 
#   separate(looker_id,
#            c("Gender", "ID"),
#            sep = 1,
#            remove=FALSE)
write.csv(x = df_complete, file = "../../Data/Data Experiment 1 (Eye Morphology)/Eye_Measurements_Complete.csv")



# 2.3.2. Wide, px only ----------------------------------------------------

## Write subset of complete df with only pixel values (and ratios) to disk
df_complete %>%
  select(!contains("mm")) %>%
  write.csv(x = ., file = "../../Data/Data Experiment 1 (Eye Morphology)/Eye_Measurements_px.csv")


# 2.3.3. Long, px only ----------------------------------------------------

# gather columns with x coordinates
df_pixel_vals.2 <- df_pixel_vals %>%
  group_by(looker_id) %>%
  gather("names_x", "X", contains("_x")) %>%
  select(looker_id, names_x, X)

# gather columns with y coordinates
df_pixel_vals.3 <- df_pixel_vals %>%
  group_by(looker_id) %>%
  gather("names_y", "Y", contains("_y")) %>%
  select(looker_id, names_y, Y)

# join data frames with x and y coordinates
df_pixel_vals.4 <- cbind(df_pixel_vals.2, df_pixel_vals.3)
df_pixel_vals.4$looker_id...4 <- NULL # remove unnecessary column
names(df_pixel_vals.4) <- c("looker_id", "names_x", "X", "names_y", "Y") # renames columns
write.csv(df_pixel_vals.4, file="Masterarbeit/Code/Eye_Measurements_px_2.csv")

ls()[ls() %in% c("df_complete", "abs_path", "abs_path_complete", "area_csv_files", "polygon_csv_files")]



# 2.3.4. Wide, mm only (1 row per VP) ----------------------------------------------------

## Get Long Format DF with Column for left/right, measure name and value
df_complete.mm <- df_complete %>%
  select(!contains(c("px")))
write.csv(x = df_complete.mm, file = "Masterarbeit/Code/Eye_Measurements_Complete_mm.csv")



# 2.3.5. Long, mm only (2 rows (l/r) per VP) ------------------------------

df.test <- df_complete %>%
  select(!contains(c("px"))) %>%
  select(-c(luminance_slope_right, luminance_slope_left))

cNames <- colnames(df.test)
cNames <- gsub("_mm", "", cNames)

colnames(df.test) <- cNames

df.test <- df.test %>%
  pivot_longer(!contains(c("looker_id", "Gender", "ID"), ignore.case=FALSE),
               names_to = c(".value", "set"),
               names_pattern = "(.+)(_left|_right)") 


df.test <- mutate(df.test,
                  set = sapply(strsplit(df.test$set, split='_', fixed=TRUE),function(x) (x[2])))
write.csv(df.test, file="Masterarbeit/Code/Eye_Measurements_long_mm.csv")


# 2.3.6. Long, mm only (1 row per side/measure/vp) ------------------------

df.test.long <- df.test %>%
  gather("measure", "value", -looker_id, -Gender, -ID, -set)

write.csv(df.test.long, file="Masterarbeit/Code/Eye_Measurements_longer_mm.csv")


# 2.4. Create df with pixel coordinates for plt ---------------------------

# gather columns with x coordinates
df_pixel_vals.2 <- df_pixel_vals %>%
  group_by(looker_id) %>%
  gather("names_x", "X", contains("_x")) %>%
  select(looker_id, names_x, X)

# gather columns with y coordinates
df_pixel_vals.3 <- df_pixel_vals %>%
  group_by(looker_id) %>%
  gather("names_y", "Y", contains("_y")) %>%
  select(looker_id, names_y, Y)

# join data frames with x and y coordinates
df_pixel_vals.4 <- cbind(df_pixel_vals.2, df_pixel_vals.3)
df_pixel_vals.4$looker_id...4 <- NULL # remove unnecessary column
names(df_pixel_vals.4) <- c("looker_id", "names_x", "X", "names_y", "Y") # renames columns
  
ch_list_px <- lapply(pol_list_px, function(a) max_chord(a))
a <- future_mapply(find_max_chord, pol_list_px, ch_list_px, SIMPLIFY = FALSE)



