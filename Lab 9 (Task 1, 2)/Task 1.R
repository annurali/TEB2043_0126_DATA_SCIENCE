install.packages("corrplot")
library(ggplot2)
library(reshape2)
library(corrplot)

# Load the dataset
data("ToothGrowth")

# Display structure of the dataset
str(ToothGrowth)
head(ToothGrowth)

# correlation with only continuous variables
continuous_vars <- ToothGrowth[, c("len", "dose")]

# Compute correlation matrix for continuous variables
cor_matrix_continuous <- cor(continuous_vars)
print("Correlation Matrix (Continuous Variables Only):")
print(round(cor_matrix_continuous, 3))

# Heatmap using corrplot wout clustering
corrplot(cor_matrix_continuous, method = "color", 
         type = "full", 
         addCoef.col = "black", 
         tl.col = "black", 
         tl.srt = 0,
         title = "Correlation: Tooth Length vs Dose",
         mar = c(0, 0, 1, 0))

#separate correlation by supplement type

# Split data by supplement type
oj_data <- subset(ToothGrowth, supp == "OJ")
vc_data <- subset(ToothGrowth, supp == "VC")

# Calculate correlations separately
cor_oj <- cor(oj_data$len, oj_data$dose)
cor_vc <- cor(vc_data$len, vc_data$dose)

print(paste("Correlation between dose and tooth length for OJ supplement:", round(cor_oj, 3)))
print(paste("Correlation between dose and tooth length for VC supplement:", round(cor_vc, 3)))

# Create a comprehensive heatmap using ggplot2 
# 1: create a data frame with correlation results
cor_results <- data.frame(
  Supplement = c("OJ", "VC", "Combined"),
  Correlation = c(cor_oj, cor_vc, cor(ToothGrowth$len, ToothGrowth$dose))
)

# Visualize correlations by supplement type
ggplot(cor_results, aes(x = Supplement, y = Correlation, fill = Supplement)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = round(Correlation, 3)), vjust = -0.5, size = 5) +
  ylim(0, 1) +
  theme_minimal() +
  ggtitle("Correlation Between Dose and Tooth Length by Supplement Type") +
  ylab("Correlation Coefficient") +
  xlab("Supplement Type")

# Better heatmap: Correlation of len and dose with supplementary info
# Create a matrix of means by dose and supplement
agg_data <- aggregate(len ~ dose + supp, data = ToothGrowth, FUN = mean)
head(agg_data)

# Reshape for heatmap
heatmap_data <- reshape(agg_data, 
                        idvar = "dose", 
                        timevar = "supp", 
                        direction = "wide")
colnames(heatmap_data) <- c("Dose", "OJ", "VC")
print(heatmap_data)

# Heatmap of tooth length by dose and supplement
ggplot(heatmap_data, aes(x = Dose, y = "Length")) +
  geom_tile(aes(fill = OJ), alpha = 0.8) +
  scale_fill_gradient(low = "white", high = "blue") +
  theme_minimal() +
  ggtitle("Tooth Length Heatmap: OJ Supplement")

ggplot(heatmap_data, aes(x = Dose, y = "Length")) +
  geom_tile(aes(fill = VC), alpha = 0.8) +
  scale_fill_gradient(low = "white", high = "red") +
  theme_minimal() +
  ggtitle("Tooth Length Heatmap: VC Supplement")


# Create a correlation matrix 
cor_matrix_safe <- cor(ToothGrowth[, c("len", "dose")])

# visualize with corrplot
corrplot(cor_matrix_safe, 
         method = "number",  # Shows numbers instead of colors
         type = "upper",
         addCoef.col = "black",
         number.cex = 1.5,
         tl.col = "black",
         tl.cex = 1.2,
         col = colorRampPalette(c("blue", "white", "red"))(200),
         title = "Correlation: Tooth Length vs Dose",
         mar = c(0, 0, 2, 0))

# Scatter plot with regression lines to visualize the relationship
ggplot(ToothGrowth, aes(x = dose, y = len, color = supp)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE) +
  theme_minimal() +
  ggtitle("Tooth Growth by Dose and Supplement Type") +
  xlab("Dose (mg/day)") +
  ylab("Tooth Length") +
  scale_color_manual(values = c("OJ" = "orange", "VC" = "darkgreen")) +
  annotate("text", x = 1.5, y = 30, 
           label = paste("Correlation OJ:", round(cor_oj, 3)), 
           color = "orange", size = 4) +
  annotate("text", x = 1.5, y = 28, 
           label = paste("Correlation VC:", round(cor_vc, 3)), 
           color = "darkgreen", size = 4)