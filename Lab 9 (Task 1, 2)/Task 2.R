install.packages("gridExtra")
library(ggplot2)
library(gridExtra)
library(dplyr)

data("mtcars")
head(mtcars)

# select omly numeric columns for transformation
numeric_cols <- mtcars[, c("mpg", "cyl", "disp", "hp", "drat", "wt", "qsec", "vs", "am", "gear", "carb")]

# Display original summary statistics
summary_original <- summary(numeric_cols)
print("Original Data Summary Statistics (First 6 variables):")
print(summary_original[, 1:6])

# 1. LOG TRANSFORMATION
# Apply log transformation 
# adding 1 to avoid log(0) issues
log_transformed <- log(numeric_cols + 1)
summary_log <- summary(log_transformed)
print("Log Transformed Data Summary:")
print(summary_log[, 1:6])

# 2. STANDARD SCALING (Z-score)
standard_scaled <- scale(numeric_cols)
summary_standard <- summary(standard_scaled)
print("Standard Scaled Data Summary:")
print(summary_standard[, 1:6])

# 3. MIN-MAX SCALING
min_max_scale <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}
minmax_scaled <- as.data.frame(lapply(numeric_cols, min_max_scale))
summary_minmax <- summary(minmax_scaled)
print("Min-Max Scaled Data Summary:")
print(summary_minmax[, 1:6])

# Visualization for comparison
#use mpg ans example
comparison_df <- data.frame(
  Original = numeric_cols$mpg,
  Log_Transformed = log_transformed$mpg,
  Standard_Scaled = standard_scaled[, "mpg"],
  MinMax_Scaled = minmax_scaled$mpg
)

# Create density plots for comparison
p1 <- ggplot(comparison_df, aes(x = Original)) + 
  geom_density(fill = "blue", alpha = 0.5) + 
  ggtitle("Original mpg") + theme_minimal()

p2 <- ggplot(comparison_df, aes(x = Log_Transformed)) + 
  geom_density(fill = "green", alpha = 0.5) + 
  ggtitle("Log Transformed mpg") + theme_minimal()

p3 <- ggplot(comparison_df, aes(x = Standard_Scaled)) + 
  geom_density(fill = "red", alpha = 0.5) + 
  ggtitle("Standard Scaled mpg") + theme_minimal()

p4 <- ggplot(comparison_df, aes(x = MinMax_Scaled)) + 
  geom_density(fill = "purple", alpha = 0.5) + 
  ggtitle("Min-Max Scaled mpg") + theme_minimal()

# Arrange plots
grid.arrange(p1, p2, p3, p4, ncol = 2, 
             top = "Comparison of Normalization Methods on mpg Variable")

# Boxplots to show distribution changes
boxplot_data <- stack(comparison_df)
names(boxplot_data) <- c("Value", "Method")
ggplot(boxplot_data, aes(x = Method, y = Value, fill = Method)) +
  geom_boxplot() +
  theme_minimal() +
  ggtitle("Distribution Comparison Across Normalization Methods")

# Summary statistics comparison table
comparison_stats <- data.frame(
  Method = c("Original", "Log", "Standard", "Min-Max"),
  Mean = c(mean(comparison_df$Original), mean(comparison_df$Log_Transformed),
           mean(comparison_df$Standard_Scaled), mean(comparison_df$MinMax_Scaled)),
  SD = c(sd(comparison_df$Original), sd(comparison_df$Log_Transformed),
         sd(comparison_df$Standard_Scaled), sd(comparison_df$MinMax_Scaled)),
  Min = c(min(comparison_df$Original), min(comparison_df$Log_Transformed),
          min(comparison_df$Standard_Scaled), min(comparison_df$MinMax_Scaled)),
  Max = c(max(comparison_df$Original), max(comparison_df$Log_Transformed),
          max(comparison_df$Standard_Scaled), max(comparison_df$MinMax_Scaled)),
  Range = c(diff(range(comparison_df$Original)), diff(range(comparison_df$Log_Transformed)),
            diff(range(comparison_df$Standard_Scaled)), diff(range(comparison_df$MinMax_Scaled)))
)

print("Comparison Statistics:")
print(comparison_stats)