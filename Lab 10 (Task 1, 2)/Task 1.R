
data("Theoph")
head(Theoph)

#linear model
model <- lm(Dose ~ Wt, data = Theoph)
summary(model)

#plot regression
plot(Theoph$Wt, Theoph$Dose)
abline(model, col = "blue")

#predict new values
new_data <- data.frame(Wt = c(90, 95, 100))
predict(model, new_data)

