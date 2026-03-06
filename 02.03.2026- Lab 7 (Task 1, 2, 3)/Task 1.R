library(readxl) 
getwd()
setwd("C:/Users/annur/OneDrive/mine/picture/OneDrive/algo/TEB2043_0126_DATA_SCIENCE/TEB2043_0126_DATA_SCIENCE/02.03.2026- Lab 7 (Task 1, 2, 3)")

titanic <- read.csv("titanic.csv")
View(titanic)

#to get the num of na
empCell <- sum(is.na(titanic))
cat("The number of empty cells or NA is: ", empCell)

#to know where the position of na
pos <- which(is.na(titanic))

#get count of NA in eacg column
print(sapply(titanic, function(x) sum(is.na(x))))

#manage na/ empty cells in data frame
dim(titanic)
titanic_cleaned = na.omit(titanic)
dim(titanic_cleaned)

#drop cabin column
titanic_cleaned$Cabin <- NULL

#filter values in dataframe
library(dplyr)

#get the col name
colnames(titanic_cleaned)

#replace blank with underscore
names(titanic_cleaned) = gsub(" ", "NA", colnames(titanic_cleaned))

#filtering values in data frame
print(filter(titanic_cleaned, Sex == 'female'))
print(filter(titanic_cleaned, Fare == 500))

#filtering data by multiple conditions
#titanic-=_cleaned %>% filter (sex == 'female', fare > 500)

#sorting by values in col
titanic_sortbyfare = arrange(titanic_cleaned, Fare) #asc order
#desc order : titanic_sortbyfare = arrange(titanic_cleaned, desc(fare))

#report
surv <- length(which(titanic_sortbyfare$Survived == 1))
total <- length(titanic_sortbyfare$Survived)

surv_rate <- (surv / total) * 100
cat("The survival rate is", surv_rate, "%")

#save
write.csv(titanic_sortbyfare, "titanic_sortbyfare.csv")
done <- read.csv("titanic_sortbyfare.csv")
View(done)






