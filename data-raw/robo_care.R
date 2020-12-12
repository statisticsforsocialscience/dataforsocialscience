# This creates the actual robo_care data set

library(tidyverse)
library(labelled)
library(psych)
library(glue)
#

score_items <- function(df, keys, ...) {
  psych::scoreItems(keys, df, ...)
}


kut_keys <- list(KUT = c(
  "KUT1",
  "-KUT2",
  "KUT3",
  "KUT4",
  "-KUT5",
  "KUT6",
  "-KUT7",
  "-KUT8"
))

res <- robo_care_raw %>% select(starts_with("KUT")) %>% mutate_all(as.numeric) %>% scoreItems(keys, ., min = 1, max = 6)



add_scores <- function(df, item_prefix, keys){
  # printing
  cat("\n\n============================================================\n")
  cat(glue::glue("Adding scores for the {item_prefix} scale.\n\n"))
  cat("============================================================\n\n")
  cat("--Testing keys...\n")
  #df <- robo_care_raw
  #item_prefix <- "KUT"

  res <- df %>% select(starts_with(item_prefix)) %>%
    alpha(keys = keys, title = item_prefix, check.keys = T)
  summary(res)
  cat("--Possible drops?\n")
  res$alpha.drop %>% arrange(desc(raw_alpha)) %>% print()
  cat("============================================================\n")
  cat("--Calculating scale\n")
  res <- df %>% select(starts_with(item_prefix)) %>%
                         mutate_all(as.numeric) %>%
                         scoreItems(keys, ., min = 1, max = 6)
  sco <- res$scores %>% as_tibble()


  print(res)

  cat("\n\n+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\n\n")
  flush.console()
  df %>% bind_cols(sco)
}


names(robo_care_raw)

kut_keys <- list(KUT = c(
  "KUT1",
  "-KUT2",
  "KUT3",
  "KUT4",
  "-KUT5",
  "KUT6",
  "-KUT7",
  "-KUT8"
))

diff_pref_keys <- list(diff_preff = c(
  "DIFFPREF1",
  "DIFFPREF2",
  "DIFFPREF3",
  "DIFFPREF4",
  "-DIFFPREF5",
  "-DIFFPREF6"
))

tk_keys <- list(TK = c(
  "TK1",
  "TK2",
  "TK3",
  "TK4"
))

priv_con_key <- list(priv_con = c(
  "PRIVCON1",
  "PRIVCON2",
  "-PRIVCON3",
  "PRIVCON4"
))


library(magrittr)
robo_care <- robo_care_raw %>%
  add_scores("KUT", kut_keys) %>%
  add_scores("DIFFPREF", diff_pref_keys) %>%
  add_scores("TK", tk_keys) %>%
  add_scores("PRIVCON", priv_con_key)

auto_score <- function(df, prefix) {
  res <- df %>% select(starts_with(prefix)) %>% alpha(title = prefix, warnings = FALSE, check.keys = TRUE)

  # generate fitting key list
  key_list <- res$keys %>%
    as.character() %>%
    str_sub(start = 1, end = -2) %>%
    paste0(names(res$keys)) %>% list()

  names(key_list) <- prefix

  add_scores(df, prefix, key_list)
}


robo_care_labelled <- robo_care_raw %>% auto_score("KUT") %>%
  auto_score("DIFFPREF") %>%
  auto_score("TK") %>%
  auto_score("PRIVCON") %>%
  auto_score("AUTOT") %>%
  auto_score("CAREX") %>%
  auto_score("CAMCON")


usethis::use_data(robo_care_labelled, overwrite = TRUE)


