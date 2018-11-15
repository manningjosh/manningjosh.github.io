### This is the stump script to read the data and plot the maps
### You have to write the code suggested here.
### Feel free to follow the ideas in a different manner/in a different file.
### However, you have to submit your main code file.
###
### The file must be executable on the server!
### I.e. someone else must be able to just run it with 'Rscript maps.R'
### /on server/ and get the correct output.


## read the data
library(data.table)
library(ggplot2)
library(dplyr)
library(mapproj)
middle_data <- decrypt::decryptData(data.table::fread("/opt/data/temp_prec_middle_encrypted.csv.bz2", sep = "\t"))
print("loading data")

## hint1: figure out the correct format and use the correct function.
##
## hint2: read.table and friends are slow (about 6 min to read data).
## You may use data.table::fread instead (a few seconds)


## filter out North American observations
new_data <- middle_data %>%
  filter(latitude > 15 & latitude < 85 & longitude > 180 & longitude < 305)

## delete the original (large data) from R workspace
## this is necessary to conserve memory.
rm(middle_data)

## -------------------- do the following for 1960, 1987, 2014 and temp/precipitation --------------------

## select jpg graphics device


## select the correct year - plot longitude-latitude and color according to the temp/prec variable
## I recommend to use ggplot() but you can use something else too.
plot_year_temp <- function(year) {
  specific_data <- new_data %>%
    select(longitude, latitude, airtemp, time) %>%
    filter(time == year)
  ggplot(specific_data) +
    geom_tile(mapping = aes(longitude, latitude, fill = airtemp)) +
    labs(title = paste("Air Temperature Mapping", year)) +
    coord_map()
}

plot_year_prec <- function(year) {
  specific_data <- new_data %>%
    select(longitude, latitude, precipitation, time) %>%
    filter(time == year)
  ggplot(specific_data) +
    geom_tile(mapping = aes(longitude, latitude, fill = precipitation)) +
    labs(title = paste("Precipitation Mapping", year)) +
    coord_map()
}

jpeg("1960_temp.jpg")
plot_year_temp("1960-06-01")
dev.off()
jpeg("1960_prec.jpg")
plot_year_prec("1960-06-01")
dev.off()
jpeg("1987_temp.jpg")
plot_year_temp("1986-06-01")
dev.off()
jpeg("1987_prec.jpg")
plot_year_prec("1986-06-01")
dev.off()
jpeg("2014_temp.jpg")
plot_year_temp("2014-06-01")
dev.off()
jpeg("2014_prec.jpg")
plot_year_prec("2014-06-01")

## Note: if using ggplot, you may want to add "+ coord_map()" at the end of the plot.  This
## makes the map scale to look better.  You can also pick a particular map projection, look
## the documentation.  (You need 'mapproj' library).
## Warning: map projections may be slow (several minutes per plot).

## close the device
dev.off()
## -------------------- you are done.  congrats :-) --------------------

