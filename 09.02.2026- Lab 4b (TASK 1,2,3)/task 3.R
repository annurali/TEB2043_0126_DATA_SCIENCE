v1 <- c(1:24)
array1 <- array(c(v1), dim = c(2, 4, 3))

v2 <- c(1:30)
array2 <- array(c(v2), dim = c(3, 2, 5))

print(array1)
print(array2)

cat("this is the second row of the second matrix of the first array:", "\n")
print(array1[2, ,2])
cat("this is the 3rd row and 2nd column of the first matrix of the second array:", "\n")
print(array2[3,2,1])