### Set all files into one folder
setwd("./")

### Needed library
#install.packages("tidyverse", dependencies = TRUE)
#install.packages("datasets")
#install.packages("boot")
library(boot)
library(tidyverse)

#Loaded file and select 3 columns
cornfield <- read.csv2("Data.csv")
cornfield <- select(cornfield, RecordNo, X2a:X2b)

#Change commas into dots in column X2a called "Wartosc tegoroczna"
cornfield$X2a <- cornfield$X2a %>%
  { gsub(" ", "", .) } %>%
  { gsub(",", ".", .) } %>%
  as.numeric()

#Change column names
colnames(cornfield)[1] <- "RecordNo"
colnames(cornfield)[2] <- "Wartosc tegoroczna"
colnames(cornfield)[3] <- "Wartosc przyszloroczna"

#Eliminate zero values
cornfield <- cornfield[apply(df1!=0, 1, all),]

#Calculate change of current and next year
cornfield <- mutate(cornfield, 'change' = cornfield$`Wartosc tegoroczna` - cornfield$`Wartosc przyszloroczna`)

#Sample parameteres
median(cornfield$`Wartosc tegoroczna`)
mean(cornfield$`Wartosc tegoroczna`)
median(cornfield$`Wartosc przyszloroczna`)
mean(cornfield$`Wartosc przyszloroczna`)
cor(cornfield$`Wartosc tegoroczna`, cornfield$`Wartosc przyszloroczna`, method='s')
mean(cornfield$change)

#Estimating function
foo <- function(data, indices){
  dt<-data[indices,]
  c(
    mean(dt[,2] - dt[,3]),
    mean(dt[,2]),
    mean(dt[,3])
  )
}

#Bootstrap method
myBootstrap <- boot(cornfield, foo, R=1000)

#View results
View(myBootstrap)
print(myBootstrap)
View(myBootstrap$t)

#Comparing with the original mean
mean(cornfield$change)
head(myBootstrap$t0)

#Normal distriburation
plot(myBootstrap, index=1)
boot.ci(myBootstrap, index=1)

#Mean for current year
plot(myBootstrap, index=2)
boot.ci(myBootstrap, index=2)

#Mean for next year
plot(myBootstrap, index=3)
boot.ci(myBootstrap, index=3)
