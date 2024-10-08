#### Using source files from USGS, create HCDN stations list with basic info

# Load libraries ----------------------------------------------------------
library(openxlsx)
library(data.table)
library(dataRetrieval)


# Load source files -------------------------------------------------------
source("get_hcdn_list.help.R")


# Define function to make a table of HCDN stations with basic info ---------
# Written by   : Kichul Bae
# Written on   : Jul 31, 2023
# Description  : From the USGS website (or local files), retrieve a table of HCDN2009 stations, and make a table that contains station id, huc2, huc4, station name, state name, latitude, longitude, drainage area, and whether it belongs to the conterminous United States (CONUS) or not (1 if it does)

st_code <- load_stcode("online") # Get state code
hcdn <- load_hcdn("online") # Get HCDN2009 stations list

result <- hcdn_table(hcdn, st_code) # Return HCDN stations table with basic info
### For some reasons DataRetrieval cannot provide HUC code for station "06154410" currently (15 Jun 2024). It used to work (HUC2:10, HUC4:05) ###

#saveRDS(result,"hcdn_list/table_hcdn.RData")

table_hcdn <- readRDS("hcdn_list/table_hcdn.RData")

write.csv(table_hcdn, "hcdn_list/table_hcdn.csv", row.names = F)


list_hcdn_conus <- make_list_hcdn(table_hcdn, conus = T) # Return 704 HCDN stations list in CONUS (HUC2: 1~18)
#saveRDS(list_hcdn_conus,"HCDN_LIST/list_hcdn_conus.RData")

list_hcdn_all <- make_list_hcdn(table_hcdn, conus = F) # Return all 743 HCDN stations list 
#saveRDS(list_hcdn_all,"HCDN_LIST/list_hcdn_all.RData")






