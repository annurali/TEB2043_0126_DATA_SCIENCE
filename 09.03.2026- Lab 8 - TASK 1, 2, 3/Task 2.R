data <- iris

summary(data)
hist(data$Sepal.Length,
     main = "histogram of iris sepal length",
     xlab = "Sepal Length (cm)",
     ylab = "frequency",
     col = "red",
     border = "black"
)

boxplot(data$Petal.Length ~ data$Species,
        main = "Boxplot of petal length by species",
        xlab = "species",
        ylab = "petal length",
        col = c("pink", "red","purple"))