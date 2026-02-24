library(tidyverse)
library(janitor)
library(stringi)

# 1) Read file as ONE column (pipe-separated, messy encoding)
raw <- readLines(
  "C:/Users/annur/OneDrive/mine/picture/OneDrive/algo/TEB2043_0126_DATA_SCIENCE/TEB2043_0126_DATA_SCIENCE/16.02.2026 - Lab Assignment/Unclean Dataset.csv",
  encoding = "ISO-8859-1",
  warn = FALSE
)

# Put into tibble with a proper column name
raw_df <- tibble(raw = raw)

# 2) Keep only rows that look like data (contain |)
raw_df <- raw_df %>%
  filter(str_detect(raw, "\\|"))

# 3) Split into proper columns safely
df_clean <- raw_df %>%
  separate(
    raw,
    into = c("id", "first_name", "last_name", "age", "gender", "course", "enrollment_date", "salary"),
    sep = "\\|",
    fill = "right",
    extra = "drop"
  ) %>%
  mutate(across(where(is.character), ~ stri_trim_both(stri_enc_toutf8(.))))

# 4) Clean column names (guarantees no missing names)
df_clean <- df_clean %>% clean_names()

# 5) Convert types
df_clean <- df_clean %>%
  mutate(
    id = suppressWarnings(as.integer(id)),
    age = suppressWarnings(as.integer(age)),
    enrollment_date = as.Date(enrollment_date),
    salary = suppressWarnings(as.numeric(str_replace_all(salary, "[^0-9]", "")))
  )

# 6) Standardize gender
df_clean <- df_clean %>%
  mutate(
    gender = str_to_lower(gender),
    gender = case_when(
      gender %in% c("m", "male") ~ "male",
      gender %in% c("f", "female") ~ "female",
      TRUE ~ NA_character_
    )
  )

# 7) Remove duplicates
df_clean <- df_clean %>% distinct()

# 8) Handle missing values (simple imputation)
df_clean <- df_clean %>%
  mutate(
    age = ifelse(is.na(age), median(age, na.rm = TRUE), age),
    salary = ifelse(is.na(salary), median(salary, na.rm = TRUE), salary)
  ) %>%
  drop_na(first_name, last_name, gender, course)

# 9) Remove unrealistic ages
df_clean <- df_clean %>%
  filter(age >= 0 & age <= 120)

# 10) Save cleaned file (must include filename)
write_csv(
  df_clean,
  "C:/Users/annur/OneDrive/mine/picture/OneDrive/algo/TEB2043_0126_DATA_SCIENCE/TEB2043_0126_DATA_SCIENCE/16.02.2026 - Lab Assignment/Cleaned_Dataset.csv"
)

cat("Cleaned file saved successfully!\n")

# Final sanity checks
glimpse(df_clean)
head(df_clean)
summary(df_clean)