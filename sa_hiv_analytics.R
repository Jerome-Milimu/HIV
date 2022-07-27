
#library
install.packages("ggalluvial")

library(ggplot2)
library(tidyverse)
library(ggalluvial)
library(rio)

# Data
data <- as_tibble(import("sa_ng_ke_hiv_estimates_20.csv"))
data

data <- mutate_if(data, is.character, as.factor)
data

hiv_plot <- ggplot(data = data,
       aes(axis1 = sex, axis2 = age, axis3 = country,
           y = frequency)) +
  scale_x_discrete(limits = c("sex", "age", "country"), expand = c(.2, .05)) +
  xlab("Demographic") +
  geom_alluvium(aes(fill = viral_suppression )) +
  geom_stratum() +
  geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
  theme_minimal() +
  ggtitle("2020 HIV viral suppression estimates for PLHIV in South Africa and Kenya ",
          "stratified by demographics and viral suppresion")

hiv_plot

png("hiv_plot.png")
jpeg("hiv_plot.jpeg")
