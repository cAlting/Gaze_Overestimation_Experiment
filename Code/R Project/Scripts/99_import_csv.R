import_csv <- function(csv_dir, recursive=T, full.names=T, include.dirs=T){
  csv <- file.path(normalizePath(list.files(csv_dir, 
                                            recursive=T, 
                                            full.names = T, 
                                            include.dirs = T,
                                            pattern = "*csv")))

  out_df <- csv %>%
    map_df(~read.csv(.))

}
