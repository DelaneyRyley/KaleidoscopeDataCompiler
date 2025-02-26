# Credits -----------------------------------------------------------------
# Functions for Bat Acoustic Recorder Package
# Created by Ryley Delaney
# Date: December 2024


# Functions ---------------------------------------------------------------

# Splits rows where the ID contains two species
split_doubleID <- function(dat) {
  dat <- dat %>%
    # Use separate_rows() to split rows where " and " is found
    separate_rows(Manual.ID, sep = "(?i) and |,") %>%
    # Retain all resulting rows without filtering anything out
    mutate(Manual.ID = str_trim(Manual.ID))  # Clean up any extra spaces
  return(dat)
}

# Finds Column name of a data-frame
get_Col_Name <- function(data, search) {
  # A function that searches each column for a value in a data frame and returns the name of the column that value is in.
  column_name <- names(data)[sapply(data, function(col)
    any(col == search))]
  return(column_name)
}

# Add guilds to dataframe based on species
add_Guilds <- function(dat) {
  dat$Manual.ID <- as.character(dat$Manual.ID)
  dat <- dat %>% 
    left_join(guilds, by = c("Manual.ID" = "Complexes"))
  
  return(dat)
}

# Lets the user translate typos
translate_Data <- function(dat) {
  # For each Unique value in the dataset
  for (i in 1:3) {
    cat("\n)")
  }
  for (i in unique(dat$Manual.ID)) {
    # Check if name already equals anything in our translations list.
    if (!(i %in% translations))
    {
      # Check if you want to change the variable.
      cut <- menu(
        choices = c("Yes", "No", "Quit"),
        title = paste("Do you want to rename:", i, "?")
      )
      if (cut == 1)
      {
        print(paste("Rename:", i))
        paste_index <- menu(
          choices = c(translations, "Cancel"),
          title = paste("What should:", i, "be changed to?")
        )
        # Checks to see if the user doesn't want to rename the bat.
        if (paste_index == length(translations) + 1) { # If cancel is selected.
          print(paste(i, "has been left as", i))
        }
        else if (is.na(i)) {
          dat <- dat %>%
            mutate(Manual.ID = ifelse(is.na(Manual.ID), translations[paste_index], Manual.ID))
        }
        else {
          dat <- dat %>%
            mutate(Manual.ID = ifelse(
              !is.na(Manual.ID) & Manual.ID == i,
              translations[paste_index],
              Manual.ID
            ))
          print(paste("Renamed", i, "to", translations[paste_index]))
        }
      }
      # If answered no.
      else if (cut == 2)
      {
        # Change nothing and print that the value wasn't changed
        print(paste(i, " has been left as ", i))
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
  return(dat)
}

# Adds together hours and minutes.
rework_Time <- function(dat) {
  dat <- dat %>%
    mutate(TIME = trimws(# Removes the AM or PM (case insensitive) suffixes from the end of the string.
      # Including AM or PM cases that have one or zero spaces before it "\\s?"
      # Also trims the white spaces
      sub("\\s?(AM|PM)+$", "", TIME, ignore.case = TRUE)),
      # Within the TIME column
      # trim the milliseconds from the TIME data.
      TIME = sub("\\.\\d+$", "", TIME))
  
  # Remove the hours so that all time is presented in minutes and seconds.
  # For each row in dat
  for (i in 1:nrow(dat)) {
    # If the length of the string is more than 5 chars.
    if (nchar(dat$TIME[i]) > 5) {
      # Substring to the last 5 characters. (Minutes and seconds)
      dat$TIME[i] <- substr(dat$TIME[i], (nchar(dat$TIME[i]) - 4), nchar(dat$TIME[i]))
    }
  }
  # Add time hours and minutes together
  dat <- dat %>%
    mutate(pass_time = paste0(dat$HOUR, ":", dat$TIME)) %>% 
    select(-TIME, -HOUR)
  return(dat)
}

# Combine all csv's into a single dataframe and cleans up data
combine_csv <- function(dat) {
  # Read in all data CSV's with names from the csv_files object
  dat <- dat %>%
    # Combine them into one data frame
    bind_rows() %>%
    # Change characters to factors
    mutate_if(is.character, factor) %>% 
    # Rename the MANUAL ID column to Manual ID
    rename(Manual.ID = MANUAL.ID) %>%
    mutate(
      # Change year to a factor
      Year = factor(Year),
      # Change Manual ID to a factor
      Manual.ID = factor(Manual.ID),
      # Change the name of Wet Heathland
     # Main.Habitat = ifelse(Main.Habitat == "wet heathland", "Wet Heathland", Main.Habitat)
    )
  return(dat)
}

# Write the final CSV to the outputs folder
final_Output <- function(dat, destination) {
  # Write data including Column Titles to destination
  menu(choices = "Ok", title = "Please close any open CSV files to \n ensure R outputs without error.")
  print("Modified Data Produced, Check Outputs folder")
  write_csv(dat, destination, col_names = TRUE)
}

# Load Data, Translations and Guilds to environment
load_Data <- function() {
  # Add all .csv files from Data folder into a single object
  csv_files <- list.files("Data", pattern = "\\.csv$", full.names = TRUE)
  
  # Remove from the object our Species Translations
  csv_files <- csv_files[!grepl("Species_Translations\\.csv$|Guilds\\.csv$", csv_files)]
  
  comb <- list(dat = dat <- lapply(csv_files, read.csv, na.strings = c("")),
               translations = as.list(translations <- read_csv("Data/Species_Translations.csv")$Translations),
               guilds = guilds <- guilds <- read.csv("Data/Guilds.csv", header = TRUE))
  list2env(comb, envir = .GlobalEnv)
}

# Creates all the necessary folders based on working directories
create_Directories <- function(wrkdir = getwd()) # Defaults as working directory if not specified
{
  datdirmade <- FALSE
  # Check if Data folder exists
  print("Checking if Data folder exists...")
  if (dir.exists(paste0(wrkdir,"/Data")))
  {
    print("Data Folder exists")
  }
  else
  {
    datdirmade <- TRUE
    print("Creating Data folder.")
    dir.create(paste0(wrkdir,"/Data"))
  }
  
  
  # Check if Outputs folder exists
  print("Checking if Outputs folder exists...")
  if (dir.exists(paste0(wrkdir,"/Outputs")))
  {
    print("Outputs Folder exists")
  }
  else
  {
    print("Creating Outputs folder.")
    dir.create(paste0(wrkdir,"/Outputs"))
  }
  
  # If Data folder made, direct user to place there data in the folder.
  if (datdirmade == TRUE) 
  {
    cat("\n\n")
    cat("Data folder created, please place .csv's in data folder\n")
    readline(prompt = "Press ENTER to continue")
  }
}