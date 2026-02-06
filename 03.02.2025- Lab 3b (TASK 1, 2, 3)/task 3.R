names <- c("Robert", "Hemsworth", "Scarlet", "Evans",
                   "Pratt", "Larson", "Holland", "Paul", "Simu", "Renner")
phy <- c(59, 71, 83, 68, 65, 57, 62, 92, 92, 59)
chem <- c(89, 86, 65, 52, 60, 67, 40, 77, 90, 61)

phyFail <- sum(phy <= 49)
chemFail <- sum(chem <= 49)

cat("The number of students fail in Physics: ", phyFail, "\n")
cat("The number of students fail in Chemistry: ", chemFail, "\n")

#highrst score
maxPhy <- max(phy)
maxChem <- max(chem)

cat("Student with highest Physics's score: ", names[phy == maxPhy], "\n")
cat("Student with highest Chemistry's score: ", names[chem == maxChem], "\n")