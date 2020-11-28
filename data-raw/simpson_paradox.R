## code to prepare `simpson_paradox` dataset goes here
library(MASS)
library(tidyverse)

set.seed(5)

### build the g1

mu <- c(3, 3)
sigma <- rbind(c(4, -0.7), c(-0.7, 4))
g1 <- as.data.frame(mvrnorm(n = 1000, mu = mu, Sigma = sigma))
g1$group <- c("Group 1")


### build the g2
mu <- c(7, 7)
sigma <- rbind(c(4, -0.7), c(-0.7, 4))
g2 <- as.data.frame(mvrnorm(n = 1000, mu = mu, Sigma = sigma))
g2$group <- c("Group 2")




# the combined data of all three groups
simpson_paradox <- rbind(g1, g2) %>% tibble()

usethis::use_data(simpson_paradox, overwrite = TRUE)


#simpson_paradox %>% ggplot() + aes(x = V2, y = V1) + geom_point()


#simpson_paradox %>%
#  filter(group == "female") %>%
#  dplyr::select(V1, V2) %>%
#  cor()
