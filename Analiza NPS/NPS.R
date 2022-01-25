#################################################
# Packages installation
if(!("plyr" %in% installed.packages())){
  install.packages("plyr")
}
if(!("dplyr" %in% installed.packages())){
  install.packages("dplyr")
}
if(!("tidyr" %in% installed.packages())){
  install.packages("tidyr")
}
if(!("ggplot2" %in% installed.packages())){
  install.packages("ggplot2")
}

#################################################
# Loading the libraries
library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)

#################################################
# Function definition - extraction of all column names and searching for the ones defined in list. 
x_col_fun <- function(x, df){
  return(df %>% 
           colnames() %>%
           { grep(x, ., value = TRUE) })
}

factor_fun <- function(vector, levels, labels){
  return(
    factor(
      vector,
      levels = levels,
      labels = labels
    )
  )
}

source_file_fun <- function(base_col, range_min, range_max, type){
  return(
    if_else(between(base_col, range_min, range_max), 1, 0)
  )
}

#################################################
#Input data 
setwd('C:\\Users\\groch\\OneDrive\\Pulpit\\Studia\\Semestr V\\Data Science project\\Projekt zaliczeniowy')

mushroom <- read.csv2("Grupa.1.csv", fileEncoding = 'UTF-8-BOM')
regional_structure <- read.csv2("Regional.Structure(1).csv", fileEncoding = 'UTF-8-BOM')
labels <- read.csv2("RegionC.csv", fileEncoding = 'UTF-8-BOM')

#################################################
# Basic information
dim(regional_structure)
str(regional_structure)
summary(regional_structure)
colnames(regional_structure)
count(regional_structure)

#################################################
# Substraction of columns required for NPS analysis
x_col_list <- x_col_fun('X11_', mushroom)
columnstoleave <- c("RecordNo", "PR_CODE", "RegionA", "X2a", x_col_list)
mushroom = mushroom[columnstoleave]

#################################################
# Join data from remaining files
mushroom <-  mushroom %>% 
  left_join(regional_structure, by = "RegionA") %>% 
    left_join(labels, by = "RegionC")

#################################################
# Cleaning data
mushroom$X2a <- mushroom$X2a %>%
  { gsub(" ", "", .) } %>%
    { gsub(",", ".", .) } %>%
      as.numeric()

#################################################
# Quick check of changes
summary(mushroom)

#################################################
# Intervals definition
mushroom <- mutate(
  mushroom, 
  RX2a = case_when(
    X2a <= 50 ~ 11, 
    between(X2a, 50.01, 100) ~ 12, 
    between(X2a, 100.01, 300) ~ 13, 
    between(X2a, 300.01, 500) ~ 14, 
    X2a > 500.01 ~ 15
    )
)

#################################################
# Labels definition
levels <- c(11,12,13,14,15)
labels <- c("<= 50 ha", "50.01 - 100 ha", "100.01 - 300 ha", 
            "300.01 - 500 ha", "wiecej niz 500 ha")
mushroom$RX2a <- factor_fun(mushroom$RX2a, levels, labels)

#################################################
# Creation of new columns and assigning values
source_file <- mushroom %>% 
  pivot_longer(
    cols = x_col_list, names_to = "Mushroom", values_to = "Recommendation"
    )

levels <- x_col_list
labels <- c("Borowik", "Czubajka", "Gąska", "Podgrzybek", 
            "Koźlarz", "Maślak", "Opieńka", "Gołąbek", 
            "Boczniak", "Pieczarka")
source_file$Mushroom <- factor_fun(source_file$Mushroom, levels, labels)

#################################################
# NPS intervals
source_file <- mutate(
  source_file, 
  Score = case_when(
    between(Recommendation, 0, 6) ~ 11,
    between(Recommendation, 7, 8) ~ 12, 
    between(Recommendation, 9, 10) ~ 13,
  )
)

levels <- c(11,12,13)
labels <- c("Detractors", "Neutrals", "Promoters")
source_file$Score <- factor_fun(source_file$Score, levels, labels)


#################################################  
#Binary table based on NPS intervals
source_file$detrac <- source_file_fun(source_file$Recommendation, 0, 6)

source_file$neutral <- source_file_fun(source_file$Recommendation, 7, 8)

source_file$promo <- source_file_fun(source_file$Recommendation, 9, 10)

#################################################
# Adding sum value
source_file$Total <- 1

#Outliers filter
source_file <- filter(source_file, Recommendation != 99)

#Extraction of only required columns
columnstoleave <- c("RecordNo", "Województwo", "RX2a", "Mushroom", 
                    "Recommendation", "Score", "detrac", "neutral", 
                    "promo", "Total" )

source_file_final <- source_file %>% subset(select = columnstoleave)

#Save to csv
write.csv2(source_file_final, "NPS.Results.csv", row.names = FALSE)


