## code to prepare `robo_care` dataset goes here
library(haven)
library(tidyverse)
library(lubridate)
library(labelled)

raw <- read_sav("data-raw/robot_original_data_anonymized.sav")


my_var_names <- names(raw)
my_var_labels <- as.character(var_label(raw))
codebook <- tibble(old_name = my_var_names, label = my_var_labels, new_name = c(""))
#write_excel_csv2(codebook, "data-raw/codebook.csv")
# update this file to rename variables
codebook <- read_csv2("data-raw/codebook_new.csv") %>% filter(new_name != "")

raw_selected <- raw %>% select(codebook$old_name)
names(raw_selected) <- codebook$new_name

robo_care_raw <- raw_selected %>% separate(date_created, into = c("date_created", "time_created"), extra = "merge", sep = " ") %>%
  mutate(date_created = mdy(date_created)) %>%
  unite(col = "date_created", date_created, time_created) %>%
  mutate(date_created = as_datetime(date_created)) %>%
  separate(date_modified, into = c("date_modified", "time_modified"), extra = "merge", sep = " ") %>%
  mutate(date_modified = mdy(date_modified)) %>%
  unite(col = "date_modified", date_modified, time_modified) %>%
  mutate(date_modified = as_datetime(date_modified))

usethis::use_data(robo_care_raw, overwrite = TRUE)


