#----------------------------- BRAND EQUITY ANALYSIS ---------------------------
# Analysis made for final project for Data Science Professional at CDV.
# Analysis based on Mushrooms dataset.
# Author: Slawomir Kranc


#---------------------------- INITIAL REQUIREMENTS ----------------------------#
# 1. Put both files data and .R script code into the same location (folder).
# 2. Set working directory.
setwd("./")
# 3. Install require package with dependencies (comment after finished installation).
install.packages("tidyverse", dependencies = TRUE)
# 4. Load require package.
library(tidyverse)


# -------------------------------- AWARNESS ------------------------------------
# According to Brand Health Index description, awarness questions are X3 and X4.

# Load file.
df1 <- read.csv2("Data.csv")

# Select only important data.
df1 <- select(df1, RecordNo, X3M1:X4M10)

# Split data X3 and X4 questions into one column.
df1 <- pivot_longer(df1,
                    cols = matches("X[34]M")
                    ,names_to = c("X","index")
                    ,names_pattern = "(X3|X4)M(\\d+)"
)

# Transform index as numeric 
df1 <- mutate(df1, index=as.numeric(index))

# Separate X3 and X4 questions.
df1 <- pivot_wider(df1
                   ,names_from = X
                   ,values_from = value
)

# Create RecordNo dataset, will be useful to later join data for all calculations.
RecordNo <- df1 %>% select(RecordNo) %>% distinct() %>% mutate(project_id=1)

# Create mushrooms names dataset, will be useful to later join data for all calculations.
mushrooms <- bind_rows(df1 %>% select(mushrooms=X3), df1 %>% select(mushrooms=X4)) %>%
  filter(!is.na(mushrooms)) %>% distinct() %>% mutate(project_id=1)

# Join mushrooms with RecordNo data.
All.together1 <- RecordNo %>% left_join(mushrooms)

# Create Awareness score 

#For X3 question
All.together1 <- All.together1 %>% left_join(df1 %>% select(-X4) %>% rename(mushrooms=X3))
All.together1 <- mutate(All.together1, Awareness_score=1)
All.together1 <- mutate(All.together1, Awareness_score=if_else(index==1,5,Awareness_score,missing = Awareness_score))
All.together1 <- mutate(All.together1, Awareness_score=if_else(index>=2,4,Awareness_score,missing = Awareness_score))
All.together1 <- select(All.together1, -index)

#For X4 question
All.together1 <- All.together1 %>% left_join(df1 %>% select(-X3) %>% rename(mushrooms=X4))
All.together1 <- mutate(All.together1, Awareness_score=if_else(!is.na(index),2,Awareness_score,missing = Awareness_score))
All.together1 <- select(All.together1, -index)



# -------------------------------- USAGE ---------------------------------------
# According to Brand Health Index description, usage questions are X6 and X7.

# Load file.
df2 <- read.csv2("Data.csv")

# Select only important data.
df2 <- select(df2, RecordNo, X6M1:X7M10)

# Split data X6 and X7 questions into one column.
df2 <- pivot_longer(df2,
                    cols = matches("X[67]M")
                    ,names_to = c("X","index")
                    ,names_pattern = "(X6|X7)M(\\d+)"
)

# Transform index as numeric 
df2 <- mutate(df2, index=as.numeric(index))

# Separate X6 and X7 questions.
df2 <- pivot_wider(df2
                   ,names_from = X
                   ,values_from = value
)

# Join mushrooms with RecordNo data.
All.together2 <- RecordNo %>% left_join(mushrooms)

# Create Usage score

# For X6 question
All.together2 <- All.together2 %>% left_join(df2 %>% select(-X7) %>% rename(mushrooms=X6))
All.together2 <- mutate(All.together2, Usage_score=1)
All.together2 <- mutate(All.together2, Usage_score=if_else(index==1,5,Usage_score,missing = Usage_score))
All.together2 <- mutate(All.together2, Usage_score=if_else(index>=2,4,Usage_score,missing = Usage_score))
All.together2 <- select(All.together2, -index)

# For X7 question
All.together2 <- All.together2 %>% left_join(df2 %>% select(-X6) %>% rename(mushrooms=X7))
All.together2 <- mutate(All.together2, Usage_score=if_else(!is.na(index),2,Usage_score,missing = Usage_score))
All.together2 <- select(All.together2, -index)


### ------------------------------ PREFERENCE ----------------------------------
# According to Brand Health Index description, preference question is X10.

# Load file.
df3 <- read.csv2("Data.csv")

# Select only important data.
df3 <- select(df3, RecordNo, X10M1:X10M3)

# Split data X10 question into one column.
df3 <- pivot_longer(df3,
                    cols = starts_with("X")
                    ,names_to = c("X","index")
                    ,names_pattern = "(X10)M(\\d+)"
)

# Transform index as numeric 
df3 <- mutate(df3, index=as.numeric(index))

# Split X10 question and value into one column.
df3 <- pivot_wider(df3
                   ,names_from = X
                   ,values_from = value
)

# Join mushrooms with RecordNo data.
All.together3 <- RecordNo %>% left_join(mushrooms)

# Create Preference score 
# For X10 question
All.together3 <- All.together3 %>% left_join(df3 %>% select(index,X10) %>% rename(mushrooms=X10))
All.together3 <- mutate(All.together3, Preference_score=1)
All.together3 <- mutate(All.together3, Preference_score=if_else(index==1,5,Preference_score,missing = Preference_score))
All.together3 <- mutate(All.together3, Preference_score=if_else(index>=2,4,Preference_score,missing = Preference_score))
All.together3 <- select(All.together3, -index)



# -------------------------------- FAMILIARITY ---------------------------------
# According to Brand Health Index description, familiartity question is X5.

# Familiarity_score
df4 <- read.csv2("Data.csv") %>%
  select(RecordNo, X5M1:X5M10) %>%
  pivot_longer(X5M1:X5M10, names_to = "mushrooms", values_to = "Familiarity_score", names_pattern = "X5M(\\d+)") %>%
  mutate(Familiarity_score=as.numeric(Familiarity_score)) %>%
  mutate(mushrooms=as.numeric(mushrooms)) %>%
  mutate(mushrooms = mushrooms + 100) %>%
  mutate(Familiarity_score=if_else(is.na(Familiarity_score), 1,  Familiarity_score)) %>%
  mutate(Familiarity_score=if_else(Familiarity_score==999,1,Familiarity_score, missing = Familiarity_score))


# -------------------------------- FUTURE USE-----------------------------------
# According to Brand Health Index description, Future use question is X8.

# Future usage score
df5 <- read.csv2("Data.csv") %>%
  select(RecordNo, X8M1:X8M10) %>%
  pivot_longer(X8M1:X8M10, names_to = "mushrooms", values_to = "FutureUsage_score", names_pattern = "X8M(\\d+)") %>%
  mutate(FutureUsage_score=as.numeric(FutureUsage_score)) %>%
  mutate(mushrooms=as.numeric(mushrooms)) %>%
  mutate(mushrooms = mushrooms + 100) %>%
  mutate(FutureUsage_score=if_else(is.na(FutureUsage_score), 1,  FutureUsage_score)) %>%
  mutate(FutureUsage_score=if_else(FutureUsage_score==999,1,FutureUsage_score, missing =FutureUsage_score))


# -------------------------------- SATISFACTION --------------------------------
# According to Brand Health Index description, Future use question is X9.

# Satisfaction score
df6 <- read.csv2("Data.csv") %>%
  select(RecordNo, X9M1:X9M10) %>%
  pivot_longer(X9M1:X9M10, names_to = "mushrooms", values_to = "Satisfaction_score", names_pattern = "X9M(\\d+)") %>%
  mutate(Satisfaction_score=as.numeric(Satisfaction_score)) %>%
  mutate(mushrooms=as.numeric(mushrooms)) %>%
  mutate(mushrooms = mushrooms + 100) %>%
  mutate(Satisfaction_score=if_else(is.na(Satisfaction_score), 1,  Satisfaction_score)) %>%
  mutate(Satisfaction_score=if_else(Satisfaction_score==999,1,Satisfaction_score, missing =Satisfaction_score))


# -------------------------------- TOTAL ---------------------------------------
# This is final calculations. Here there is joining all above analysis results and
# eliminate outliers.

# Join all datasets to single.
Total <- left_join(All.together1, All.together2)
Total <- left_join(Total, All.together3)
Total <- left_join(Total, df4)
Total <- left_join(Total, df5)
Total <- left_join(Total, df6)

# Drop NA values
Total$Awareness_score[is.na(Total$Awareness_score)] <- 999
Total$Usage_score[is.na(Total$Usage_score)] <- 999
Total$Preference_score[is.na(Total$Preference_score)] <- 999
Total$Familiarity_score[is.na(Total$Familiarity_score)] <- 999
Total$FutureUsage_score[is.na(Total$FutureUsage_score)] <- 999
Total$Satisfaction_score[is.na(Total$Satisfaction_score)] <- 999

# Filter only valid (1-5) data
Total <- filter(Total, Awareness_score <6)
Total <- filter(Total, Usage_score <6)
Total <- filter(Total, Preference_score <6)
Total <- filter(Total, Familiarity_score <6)
Total <- filter(Total, FutureUsage_score <6)
Total <- filter(Total, Satisfaction_score <6)

# Verifying dataset answers with mushrooms names in questionnaire (should be 101-110).
summary(Total$mushrooms)

# Add mushrooms labels
AddAddMyLabels <- source("AddLabelsScript.R", encoding = "UTF8")
Total$mushrooms <- AddMyLabels(Total$mushrooms)

# Write data to outfile.
write.csv2(Total, "Brand_Equity_Results.csv", row.names = FALSE)