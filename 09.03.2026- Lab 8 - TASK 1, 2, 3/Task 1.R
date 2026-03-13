library(readr)

titanic <- read.csv("titanic.csv")
summary(titanic)

hist(titanic$Age,
     main = "Histogram of titanic pessanger age",
     xlab = "Age",
     ylab = "Frequency",
     col = "lightblue",
     border = "black")

boxplot(Survived ~ Sex,
        titanic,
        main = "boxplot of survival by sex",
        xlab = "sex",
        ylab = "survival number",
        col = c("pink", "blue"))



