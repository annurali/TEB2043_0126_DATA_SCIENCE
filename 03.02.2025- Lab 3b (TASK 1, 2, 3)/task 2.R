scores <- c(59, 71, 83, 68, 65, 57, 62, 92, 92, 59)

# Assign student names
names(scores) <- c("Robert", "Hemsworth", "Scarlet", "Evans",
                   "Pratt", "Larson", "Holland", "Paul", "Simu", "Renner")


highest <- max(scores)
lowest <- min(scores)
avg <- mean(scores)


highest_pos <- which(scores == highest)
lowest_pos <- which(scores == lowest)


cat("Highest score:", highest, "\n")
cat("Lowest score:", lowest, "\n")
cat("Average score:", avg, "\n")

cat("Student with highest score:", names(scores)[highest_pos], "\n")
cat("Student with lowest score:", names(scores)[lowest_pos], "\n")
