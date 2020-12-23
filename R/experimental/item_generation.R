if(FALSE) {

library(MASS)
library(tidyverse)




library(labelled)
fkt_agreement <- function(x) {
  x %>% labelled::to_factor(ordered = TRUE) %>%
    fct_relevel(
      "Stimme sehr zu",
      "Stimme zu",
      "Stimme eher zu",
      "Stimme eher nicht zu",
      "Stimme nicht zu",
      "Stimme gar nicht zu"
    )

}

to_ordered <- function(x) {
  to_factor(x, ordered = TRUE)
}

library(forcats)



robo_care_raw %>% select(starts_with("KUT")) %>% mutate_all(to_ordered)

robo_care_raw %>% select(solace_human) %>% mutate_at(vars(solace_human), fkt_agreement) %>%
  pull(solace_human) %>% as.numeric %>% mean(na.rm = TRUE)

library(psych)


robo_care_raw %>% select(starts_with("KUT")) %>% mutate_all(as.numeric) %>% scoreItems()


test$scores


generateItemData <-
  function(n,
           item_count = 5,
           likert_scale = 6,
           mean = 0,
           sd = 1) {
    latent <- rnorm(n, mean, sd)
    latent

    item_count = 5
    n = 100
    items <- data.frame(id = 1:n)
    for (i in 1:item_count) {
      item = latent + rnorm(n, mean = 0, sd = 0.2)
      items <- dplyr::bind_cols(items, item)
    }
    items
  }


d1 <- generateItemData(100)



set.seed(8649)     # this makes the example exactly reproducible
N      = 100        # this is how much data I'll generate
latent = rnorm(N)  # this is the actual latent variable I want to be measureing

##### generate latent responses to items
item1 = latent + rnorm(N, mean = 0, sd = 0.2)  # the strongest correlate
item2 = latent + rnorm(N, mean = 0, sd = 0.3)
item3 = latent + rnorm(N, mean = 0, sd = 0.5)
item4 = latent + rnorm(N, mean = 0, sd = 1.0)
item5 = latent + rnorm(N, mean = 0, sd = 1.2)  # the weakest

##### convert latent responses to ordered categories


r1 <- c(-Inf, -2.5, -1, 0, 1, 2.5, Inf)

item1 <- findInterval(item1, r1)
item1 <- findInterval(item2, r1)



qplot(item1)


item2 = findInterval(item2, vec = c(-Inf, -2.5, -1, 1, 2.5, Inf))
item3 = findInterval(item3, vec = c(-Inf, -3,  -2, 2, 3,  Inf))  # middle values typical
item4 = findInterval(item4, vec = c(-Inf, -3,  -2, 2, 3,  Inf))
item5 = findInterval(item5, vec = c(-Inf, -3.5, -3, -1, 0.5, Inf))  # high ratings typical


qplot(item1)


##### combined into final scale
manifest = round(rowMeans(cbind(item1, item2, item3, item4, item5)), 1)
manifest
# [1]  3.4  3.6  3.4  3.8  2.6  3.4  3.2  2.0  3.8  3.2
round(latent, 1)
# [1]  1.3  0.6  0.2  1.0 -1.5  0.1  0.4 -2.5  2.3 -0.3
cor(manifest, latent)
# [1] 0.9280074


#' This functions adds the score of a given item set and a key set using the psych package
#'
#' @param df the dataframe to use
#' @param item_prefix the prefix common to all items. Data is selected using dplyr::starts_with
#' @param keys a keylist as used in the psych::scoreItems function
#'
#' @return the data frame with an added column
#  @export
#'
#' @examples
#' keys <- list(KUT = c("KUT1", "-KUT2", "KUT3", "KUT4"))
#' robo_care_raw %>% add_scores("KUT", keys)
add_scores <- function(df, item_prefix, keys){
  # printing
  cat("\n\n===========================================================\n")
  cat(glue::glue("Adding scores for the {item_prefix} scale.\n\n"))
  cat("============================================================\n\n")
  cat("--Testing keys...\n")
  #df <- robo_care_raw
  #item_prefix <- "KUT"

  res <- df %>% select(starts_with(item_prefix)) %>%
    psych::alpha(keys = keys, title = item_prefix, check.keys = T)
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



}
