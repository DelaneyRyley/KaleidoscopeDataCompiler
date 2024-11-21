
# Create Base Path and Assign Libraries -----------------------------------

# Install packages
library(data.table)
library(tidyverse)

# Assign the base path
base_path <- "C:\Users\user\Desktop\Bat Data\Bat-Data"

# Assign all of the 
translations <- fread(file.path(base_path, "Data", "Species_Translations.csv"))
unique(translations)
