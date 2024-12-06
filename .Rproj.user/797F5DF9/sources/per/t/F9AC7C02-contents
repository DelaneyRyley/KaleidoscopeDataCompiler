
# Create Base Path and Assign Libraries ---------------------------------------

# Install packages
library(data.table)
library(tidyverse)

# Source our functions
source("Scripts/Functions.R")

# Assign the base path
#base_path <- "C:/Users/user/Desktop/Bat Data/Bat Data/BatData"




# Load in Data, Translations and Guilds ---------------------------------------------
  load_Data()

  
  
# Create a list of all the variables we want to keep.
dat_var_keep <- c("Year",
                  "Fmin",
                  "Fmean",
                  "Fmax",
                  "TIME",
                  "HOUR",
                  "MANUAL.ID",
                  "Main.Habitat")

# Remove all rows that don't belong to dat_var_keep
dat <- lapply(dat, function(df)
  df[, dat_var_keep, drop = FALSE])

# Combine all csv's into a single object ---------------------------------------
dat <- combine_csv(dat)

# Split Rows with multiple ID's ------------------------------------------------
dat <- split_doubleID(dat)

# Clean up the Time Column -----------------------------------------------------
dat <- rework_Time(dat)

# Rename Misspells to Species Name based on Translation List -------------------
dat <- translate_Data(dat)

# Add Guilds to Dataframe -------------------------------------------------
dat <- add_Guilds(dat)

# Write data to CSV ------------------------------------------------------------
final_Output(dat, "Outputs/Bat_Accoustic_Recorder_Data.csv")

  

  
  