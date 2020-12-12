# This creates the actual robo_care data set

library(tidyverse)
library(labelled)
library(psych)
library(glue)




keys <- list(KUT = c("KUT1", "-KUT2", "KUT3", "KUT4"))
robo_care_raw %>% hcictools::add_scores("KUT", keys)

robo_care_labelled <- robo_care_raw %>% hcictools::auto_score("KUT") %>%
  auto_score("DIFFPREF") %>%
  auto_score("TK") %>%
  auto_score("PRIVCON") %>%
  auto_score("AUTOT") %>%
  auto_score("CAREX") %>%
  auto_score("CAMCON")


usethis::use_data(robo_care_labelled, overwrite = TRUE)


