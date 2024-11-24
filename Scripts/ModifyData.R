
# Create Base Path and Assign Libraries -----------------------------------

# Install packages
library(data.table)
library(tidyverse)

# Assign the base path
#base_path <- "C:/Users/user/Desktop/Bat Data/Bat Data/BatData"




# Load in Translations ----------------------------------------------------

  # Read in all the species translations csv
  translations <- colnames(read_csv("Data/Species_Translations.csv") %>% 
    mutate_if(is.character, factor))


# Load and Modify Data ---------------------------------------------------------------

  # Add all .csv files from Data folder into a single object
  csv_files <- list.files("Data", pattern = "\\.csv$", full.names = TRUE)
  
  # Remove the from the object the our Species Translations
  csv_files <- csv_files[!grepl("Species_Translations\\.csv$", csv_files)]
  
  # Create a list of all the variables we want to keep.
  dat_var_keep <- c("Year", "Fmin", "Fmean", "Fmax", "TIME", "HOUR", "Manual.ID", "Main.Habitat")
  
  # Load in the Stradbroke data
  # From the csv_files object
  dat <- csv_files %>% 
    # dat
    dat[, dat_var_keep]
    # Read in all data csv's with names from the csv_files object, which now contains 4 data frames.
    lapply(read.csv, na.strings = c("")) %>% 
    # Combine them into the same number of rows.
    bind_rows()
    # Rename the MANUAL ID column to Manual ID
    rename(Manual.ID = MANUAL.ID) %>% 
    mutate(
      # Change year to a factor
      Year = factor(Year),
      # Change Manual ID to a factor
      Manual.ID = factor(Manual.ID),
      # Change the name of Wet Heathland
      Main.Habitat = ifelse(Main.Habitat == "wet heathland", "Wet Heathland", Main.Habitat)
           )
  
  #################
  # Don't know what I'm going to do with the time scales, might exclude from the model at this time.
  # Or ask  how to add them together.
  ########################

  # Modify the data so that only the columns with our "keep" variables remain.
  dat <-  %>% 
    # Use separate_rows() to split rows where " and " is found
    separate_rows(Manual.ID, sep = "(?i) and |,") %>%
    # Retain all resulting rows without filtering anything out
    mutate(Manual.ID = str_trim(Manual.ID))  # Clean up any extra spaces
  
  
  

# Rename Misspells to Species Name -----------------------------------------

  # For each Unique value in the dataset
  for (i in 1:3) {cat("\n)")}
  for (i in unique(dat$Manual.ID)) {
    # Check if name already equals anything in our translations list.
    if (!(i %in% translations))
    {
      # Check if you want to change the variable. 
      cut <- menu(choices = c("Yes","No","Quit"), title = paste("Do you want to rename:",i,"?"))
      if (cut == 1)
      {
        print(paste("Rename:", i))
        paste_name <- translations[menu(choices = translations, title = paste("What should:", i, "be changed to?"))]
        dat <- dat %>% 
          mutate(Manual.ID = ifelse(Manual.ID == i, paste_name, Manual.ID))
        print(paste("Renamed", i, "to", paste_name))
      }
      # If answered no.
      else if (cut == 2)
      {
        # Change nothing and print that the value wasn't changed
        print(paste("Not renaming value:", i))
      }
      # If Answered Quit
      else if (cut == 3)
      {
        # Print that you're exiting the function.
        print("Quitting Program")
        break
      }
    }
  }

# Write data to CSV -------------------------------------------------------

  # Write data including Column Titles
  menu(choices = "Ok", title = "Please close any open CSV files to \n ensure R outputs without error.")
  print("Modified Data Produced, Check Outputs folder")
  write_csv(dat, "Outputs/Modified_Stradbroke_Data.csv", col_names = TRUE)

  
