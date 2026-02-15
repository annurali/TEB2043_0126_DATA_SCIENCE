v1 <- matrix(c(2,3,1,5,4,6,8,7,9), nrow = 3, ncol = 3)

v2 <- t(v1)

rownames(v1) <- c("R1", "R2", "R3")
colnames(v1) <- c("C1", "C2", "C3")

rownames(v2) <- c("R1", "R2", "R3")
colnames(v2) <- c("C1", "C2", "C3")

print(v1)
print(v2)

add <- v1 + v2
subs <- v1 - v2
mult <- v1 *  v2
div <- v1 / v2

cat("Addition of matrix 1 and matrix 2:\n")
print(add)
cat("Subtraction of matrix 1 and matrix 2:\n")
print(subs)
cat("Multiplication of matrix 1 and matrix 2:\n")
print(mult)
cat("Division of matrix 1 and matrix 2:\n")
print(div)
