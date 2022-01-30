# Install packages
if(!("plyr" %in% installed.packages())){
  install.packages("plyr")
}
if(!("dplyr" %in% installed.packages())){
  install.packages("dplyr")
}
if(!("tidyr" %in% installed.packages())){
  install.packages("tidyr")
}

# Load libraries
library(plyr)
library(dplyr)
library(tidyr)

# Set working directory 
setwd("./")
getwd()

# Load data
df1 <- read.csv2("Grupa.1.csv", fileEncoding = 'UTF-8-BOM')

# Review of data
dim(df1)
str(df1)
summary(df1)
colnames(df1)
count(df1)

# Select only important data.
df2 <- select(df1, RecordNo, X3M1:X4M10)

# Transform variables to cases
df3 <- pivot_longer(df2,
                   cols = matches("X[34]M"),
                   names_to = c("X", "index"),
                   names_pattern = "(X3|X4)M(\\d+)")

df3 <- mutate(df3, index=as.numeric(index))

df3 <- pivot_wider(df3,
                  names_from= X,
                  values_from = value)


RecordNo <- df3 %>% 
  select(RecordNo) %>%
  distinct() %>%
  mutate(project_id=1)

Companies <- bind_rows(df3 %>% select(company=X3),
                       df3 %>% select(company=X4)) %>%
  
                         filter(!is.na(company)) %>%
                         distinct() %>%
                         mutate(project_id=1)

All.together <- RecordNo %>% left_join(Companies)

# Create Awareness score for X3
All.together <- All.together %>% left_join(df3 %>% select(-X4) %>% rename(company=X3))
All.together <- mutate(All.together, pos=if_else(is.na(index), 998, index))
All.together <- mutate(All.together, pos=if_else(pos>1 & pos<998,2,pos))
All.together <- select(All.together, -index)

# Create Awareness score forX4
All.together <- All.together %>% left_join(df3 %>% select(-X3) %>% rename(company=X4))
All.together <- mutate(All.together, pos=if_else(is.na(index), 3, pos))
All.together <- select(All.together, -index, -project_id)

# Adding labels to factor
All.together$pos <- factor(All.together$pos,
                       levels = c(1,2,3,998),
                       labels = c("Top of Mind", "Unaided", "Aided", "Not mentioned"))

All.together$company <- factor(All.together$company,
                               
                           levels = c(101, 102, 103, 
                                      104, 105, 106, 
                                      107, 108, 109, 
                                      110,
                                      
                                      111, 112, 113, 
                                      114, 115, 116, 
                                      117, 118, 119,
                                      999),
                           
                           labels = c("Borowik", "Czubajka", "Gąska", 
                                      "Podgrzybek", "Koźlarz", "Maślak", 
                                      "Opieńka", "Gołąbek", "Boczniak", 
                                      "Pieczarka",
                                      
                                      "Inna_1", "Inna_2", "Inna_3",
                                      "Inna_4", "Inna_5", "Inna_6",
                                      "Inna_7", "Inna_8", "Inna_9",
                                      "Nie znam żadnych"))

# Recording results
write.csv2(All.together, "Brand.Awarness.csv", row.names = FALSE, na="")
