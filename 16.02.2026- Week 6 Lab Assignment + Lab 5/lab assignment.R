library(dplyr)
library(tidyr)
library(stringr)
library(janitor)

uncleaned_data <- read.csv("C:/Users/annur/Downloads/Unclean Dataset.csv", fileEncoding = "ISO-8859-1",
                           stringsAsFactors = FALSE)

#load dataset
cat("number of duplicates: ", sum(duplicated(uncleaned_data)), "\n")
print(colSums(is.na(uncleaned_data)))
str(uncleaned_data)
summary(uncleaned_data)
head(uncleaned_data)

#1. remove duplicatw

uncleaned_data <- uncleaned_data %>% distinct()
cat("Duplicates removed successfully!\n")



#2. handle missing val
# if numeric col fill w median
# if categorical col fill w mode (frequent value)

get_mode <- function(x){
  ux <- na.omit(x)
  ux[which.max(tabulate(match(ux,ux)))]
}

for(col in names(uncleaned_data)){
  if(is.numeric(uncleaned_data[[col]])){
    uncleaned_data[[col]][is.na(uncleaned_data[[col]])] <- median(uncleaned_data[[col]], na.rm = TRUE)
  }
  else {
    uncleaned_data[[col]][is.na(uncleaned_data[[col]])] <- get_mode(uncleaned_data[[col]])
  }
}

print("Missing values handled successfully")

#3. convert irrelevent data types to numeric
for(col in names(uncleaned_data)){
  uncleaned_data[[col]] <- suppressWarnings(as.numeric(uncleaned_data[[col]]))
}
cat("Converted incompatible data types successfully!\n")


#4. remove special charac from text col
if("price" %in% names(uncleaned_data)){
  uncleaned_data$price <- uncleaned_data$price %%
    str_replace_all("[^0-9.]", "") %>%
    as.numeric()
}
cat("Special characters removed successfully!\n")

numericCol <- uncleaned_data %>% select(where(is.numeric)) #select numeric col

#calc iqr
q1 <- apply(numericCol,2,quantile,0.25, na.rm = TRUE)
q3 <- apply(numericCol,2,quantile,0.75, na.rm = TRUE)
iqr <- q3 - q1
cat("Outlier handling with IQR computed successfully!\n")

#remove outlier usin iqr
cleaned <- uncleaned_data %>%
  filter(
    !apply(numericCol, 1, function(row){
      any(row < (q1 - 1.5 * iqr) | row > (q1 + 1.5 * iqr), na.rm = TRUE)
    })
  )
cat("Outliers removed successfully!\n")

#save
write.csv(cleaned, "Cleaned_Dataset.csv")
cat("Clean dataset saved as 'Cleaned_Dataset.csv' in the current working directory.\n")

#final check
cat("num of duplicates: ", sum(duplicated(cleaned)), "\n")
print(colSums(is.na(cleaned)))
str(cleaned)
summary(cleaned)
head(cleaned)



