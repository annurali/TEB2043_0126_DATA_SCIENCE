w <- as.numeric(readline(prompt = "Enter your current weight in kg: "))
h <- as.numeric(readline(prompt = "Enter your current height in m: "))

bmi <- (w/ h^2) 

cat("The bmi: ", round(bmi,2),"\n")

underweight <- bmi <= 18.4
normal <- bmi >= 18.5 & bmi <= 24.9
overweight <- bmi >= 25.0 & bmi <= 39.9
obese <- bmi >= 40.0

cat("Underweight : ", underweight, "\n")
cat("Normal : ", normal, "\n")
cat("Overweight : ", overweight, "\n")
cat("Obese : ", obese, "\n")