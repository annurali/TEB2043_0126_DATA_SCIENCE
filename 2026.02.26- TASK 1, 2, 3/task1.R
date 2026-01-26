number <- 1:20
square <- number^ 2

#display result
cat("Number \t Square \n")
cat("*******\t ******")
for(i in 1:length(number)){
  cat(number[i], " \t", square[i], " \n")
}