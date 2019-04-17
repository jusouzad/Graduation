library(tidyverse)
library(MASS)
library(readr)
library(tidyverse)
library(tidyr)
library(dplyr)
bd = read_csv("bac_3methods.csv")


# Comparacao entre metodo 1 e 2

metodo1 = bd %>% filter(Method == c("1", "2")) %>% spread(key = Method, value = BAC)
colnames(metodo1) = c("SampleID", "SD_pct", "t1", "t2")
metodo1 %>% filter(t1 != c("na"))

metodo2 = bd %>% filter(Method == c("1", "2")) %>% spread(key = Method, value = BAC)
colnames(metodo2) = c("SampleID", "SD_pct", "t1", "t2")
metodo2 %>% filter(t2 != c("na"))

t.test(metodo1$t1, metodo2$t2, alternative = "two.sided")
## Não rejeito H0

# Comparacao entre metodo 1 e 3

metodo3 = bd %>% filter(Method == c("1", "3")) %>% spread(key = Method, value = BAC)
colnames(metodo3) = c("SampleID", "SD_pct", "t1", "t3")
metodo3 %>% filter(t3 != c("na"))

t.test(metodo1$t1, metodo3$t3, alternative = "two.sided")
## Não rejeito H0

# Comparacao entre metodo 2 e 3

t.test(metodo2$t2, metodo3$t3, alternative = "two.sided")
## Não rejeito H0

# Testando a normalidade dos dados

shapiro.test(metodo1$t1)
shapiro.test(metodo2$t2)
shapiro.test(metodo3$t3)