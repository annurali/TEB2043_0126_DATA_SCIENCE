scores <- c(33, 24, 54, 94, 16, 89, 60, 6, 77, 61, 13, 44, 26, 24, 73, 73, 90, 39, 90, 54)

grA <- sum(scores >= 90 & scores <= 100)
grB <- sum(scores >= 80 & scores <= 89)
grC <- sum(scores >= 70 & scores <= 79)
grD <- sum(scores >= 60 & scores <= 69)
grE <- sum(scores >= 50 & scores <= 59)
grF <- sum(scores <= 49)

cat("Number of grade A: ", grA, "\n")
cat("Number of grade B: ", grB, "\n")
cat("Number of grade C: ", grC, "\n")
cat("Number of grade D: ", grD, "\n")
cat("Number of grade E: ", grE, "\n")
cat("Number of grade F: ", grF, "\n")

pass <- scores > 49
cat("Past?: ", "\n")
print(pass)