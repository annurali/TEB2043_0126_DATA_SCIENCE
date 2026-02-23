emp.data <- data.frame(
  name = c("Anastasia", "Dima", "Michael","Matthew", "laura", "Kevin", "Jonas"),
  score = c(12.5, 9.0, 16.5, 12.0, 9.0, 8.0, 19.0),
  attemps = c(1, 3, 2, 3, 2, 1, 2)
)
#add col
emp.data$qualify <- c("yes", "no", "yes", "no", "no", "no", "yes")

#create new row
emp.newdata <- data.frame(
  name = c("Emily"),
  score = c(14.5),
  attemps = c(1),
  qualify = c("yes")
)

#bind tha data frames
emp.final <- rbind(emp.data, emp.newdata)

#change datatype

emp.final$score = as.numeric(emp.final$score)
emp.final$attemps = as.numeric(emp.final$attemps)
emp.final$qualify = as.factor(emp.final$qualify)

View(emp.final)
summary(emp.final)
