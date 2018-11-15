#!/bin/bash
# --------------------------------------------------------------------------------
# document here the main bash commands you are using for the server access.  The file contains
# two parts: the first one for the commands you run on your laptop, and the second one for the
# commands on the remote server.
#
# The question lists give your some guidance what to do and report but you are free to do it
# in a different way.  If you use a graphical frontend instead of scp for copying files,
# just say which one in the appropriate place.
#
# Note: this file does not to be runnable
#
# -------------------- local commands --------------------
# 1. create a directory for this project.
mkdir "server_data"

# 2. log onto the server
ssh joshwm@info201.ischool.uw.edu

# 3. copy the small data subset from the server to your local machine
scp joshwm@info201.ischool.uw.edu:/opt/data/temp_prec_tiny.csv.bz2 .

# 4. copy your R-script to the server
scp ~/desktop/info201/a6-server-manningjosh/maps.R joshwm@info201.ischool.uw.edu:/home/joshwm

# 5. (after succesfully running the script remotely): copy the output files back to your computer
scp joshwm@info201.ischool.uw.edu:/home/joshwm/1960_temp.jpg ~/desktop/info201/a6-server-manningjosh/server_data
scp joshwm@info201.ischool.uw.edu:/home/joshwm/1960_prec.jpg ~/desktop/info201/a6-server-manningjosh/server_data
scp joshwm@info201.ischool.uw.edu:/home/joshwm/1987_temp.jpg ~/desktop/info201/a6-server-manningjosh/server_data
scp joshwm@info201.ischool.uw.edu:/home/joshwm/1987_prec.jpg ~/desktop/info201/a6-server-manningjosh/server_data
scp joshwm@info201.ischool.uw.edu:/home/joshwm/2014_temp.jpg ~/desktop/info201/a6-server-manningjosh/server_data
scp joshwm@info201.ischool.uw.edu:/home/joshwm/2014_prec.jpg ~/desktop/info201/a6-server-manningjosh/server_data

# 6. inspect that the copy was successful
cd server_data
ls

# -------------------- remote commands --------------------
# 1. explore the data directory '/opt/data'.  How do you find out the size of the files?
cd opt/data/
ls

# 2. explore the first few lines of the small sample data
R
head(data.table::fread("temp_prec_tiny.csv.bz2"))

# 3. create a directory for this project
mkdir "a6-server"

# 4. (after copying your code from the laptop): inspect the files in the project directory
cd /home/joshwm/a6-server
ls

# 5. run your script
R
source("maps.R")
quit()
y
Rscript maps.R

# 6. How do you install missing R packages?
R
install.packages("required_package")
library(required_package)

# 7. (after running the script): inspect the folder for output files
cd /home/joshwm/server_data
ls
