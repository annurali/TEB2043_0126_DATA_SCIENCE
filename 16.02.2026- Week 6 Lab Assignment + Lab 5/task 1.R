y <- as.numeric(readline(prompt = "Input year: "))
if (y%%4 == 0 && y%%100 != 0){
  cat("Output: ", y, "is a leap year")
}else{
  cat("Output: ", y, "is not a leap year")
}