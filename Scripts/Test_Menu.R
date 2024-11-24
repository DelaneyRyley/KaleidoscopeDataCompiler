
df <- data.frame(
  Species = c("d", "d", "c","b","d"),
  Number = c(1,1,2,3,1)
)

full_name <- c("Mouse","Cat","Bird","Dog")

# For each Unique value in the dataset
  for (i in unique(df$Species)) {
    # Check if you want to change the variable. 
    cut <- menu(choices = c("Yes","No"), title = paste("Do you want to rename:",i,"?"))
    if (cut == 1)
    {
      print(paste("Rename:", i))
      print(cut)
      paste_name <- full_name[menu(choices = full_name, title = paste("What should:", i, "be changed to?"))]
      df <- df %>% 
        mutate(Species = ifelse(Species == i, paste_name, Species))
    }
    else
    {
      print(paste("Not renaming value:", i))
    }

  }
