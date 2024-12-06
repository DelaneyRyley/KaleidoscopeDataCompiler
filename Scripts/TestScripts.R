
# Sets the variable "selection" to be chosen using a menu
  x <- c("Cat", "Dog", "Mouse")
  selection <- x[menu(x)]

  # Pull from dat, the strings within the dat MANUAL.ID column that contain "and" or ","
  # The [1,] gives only the first result.
  dat[str_detect(dat$MANUAL.ID, "(?i)( and |,)"), ][1,]
  
  
  

# Splitting Rows Code Test ------------------------------------------------

  # Example data frame
  test_dat <- data.frame(
    Year = c(2021, 2022, 2023, 2024, 2021, 2022, 27, 8029),
    Fmin = c(1, 2, 3, 4, 5, 6, 7, 8),
    Fmean = c(5, 6, 7, 8, 9, 10, 11, 12),
    Fmax = c(9, 10, 11, 12, 5, 6, 7, 8),
    TIME = c(10, 20, 30, 40, 50, 60, 70, 80),
    HOUR = c(1, 2, 3, 4, 5, 6, 7, 8),
    MANUAL.ID = c("dog", "cat", "dog and cat", "dog", "fish", "bird", "fish and dog", "raptor, kang")
  )
  
  # Step 1: Find rows where MANUAL.ID contains "and"
  # Step 2: Split "dog and cat" into two rows
  
  # Adjusted script to handle all values
  dat_split <- test_dat %>%
    # Use separate_rows() to split rows where " and " is found
    separate_rows(MANUAL.ID, sep = "(?i) and |,") %>%
    # Retain all resulting rows without filtering anything out
    mutate(MANUAL.ID = str_trim(MANUAL.ID))  # Clean up any extra spaces
  
  
 test_df <- data.frame(
   Name = c("Dog","Dog", "Bird", "Cat", "Bird"),
   Size = c(1,3,3,4,2)
 )
 
 df <- test_df %>% group_by(Name)
 
 

# Search a dataframe for a specific value and return the column na --------

 df <- data.frame(A = c(1, 2, 3), B = c(4, 5, 3), C = c(6, 7, 8))
  
 # A function that searches each column for a value in a data frame and returns the name of the column that value is in.
 get_Col_Name <- function(data, search) {
   column_name <- names(data)[sapply(data, function(col) any(col == search))]
   return(column_name)
 }
get_Col_Name(df, 2) 
