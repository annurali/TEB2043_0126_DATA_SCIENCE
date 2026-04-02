data("ChickWeight")
head(ChickWeight)

library(class)

# convert diet to factor
ChickWeight$Diet <- as.factor(ChickWeight$Diet)

# split features and label
x <- scale(ChickWeight[, c("weight", "Time")])
y <- ChickWeight$Diet

# split train-test
set.seed(123)

train_index <- sample(1:nrow(x), 0.7 * nrow(x))

x_train <- x[train_index, ]
x_test  <- x[-train_index, ]

y_train <- y[train_index]
y_test  <- y[-train_index]

#try diff k values
k_values <- 1:10
accuracy <- c()

for (k in k_values) {
  pred <- knn(x_train, x_test, y_train, k = k)
  acc <- mean(pred == y_test)
  accuracy <- c(accuracy, acc)
}

accuracy

#confusion matrix
best_pred <- knn(x_train, x_test, y_train, k = 3)

table(Predicted = best_pred, Actual = y_test)