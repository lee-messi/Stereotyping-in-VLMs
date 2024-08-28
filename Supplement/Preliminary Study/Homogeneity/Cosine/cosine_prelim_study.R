
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 28 Aug 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("effsize")){install.packages("effsize", dependencies = TRUE); require("effsize")}

# Load data --------------------------------------------------------------------

mpnetbase = read.csv('mpnetbase.csv')
distilroberta = read.csv('distilroberta.csv')
allminilm = read.csv('allminilm.csv')

# Independent samples t-tests --------------------------------------------------

mean(mpnetbase %>% filter(race == "African Americans") %>% pull(cosine))
sd(mpnetbase %>% filter(race == "African Americans") %>% pull(cosine))
mean(mpnetbase %>% filter(race == "White Americans") %>% pull(cosine))
sd(mpnetbase %>% filter(race == "White Americans") %>% pull(cosine))

t.test(mpnetbase %>% filter(race == "African Americans") %>% pull(cosine), 
       mpnetbase %>% filter(race == "White Americans") %>% pull(cosine), alternative = "greater")
cohen.d(mpnetbase %>% filter(race == "African Americans") %>% pull(cosine), 
        mpnetbase %>% filter(race == "White Americans") %>% pull(cosine))

mean(distilroberta %>% filter(race == "African Americans") %>% pull(cosine))
sd(distilroberta %>% filter(race == "African Americans") %>% pull(cosine))
mean(distilroberta %>% filter(race == "White Americans") %>% pull(cosine))
sd(distilroberta %>% filter(race == "White Americans") %>% pull(cosine))

t.test(distilroberta %>% filter(race == "African Americans") %>% pull(cosine), 
       distilroberta %>% filter(race == "White Americans") %>% pull(cosine), alternative = "greater")
cohen.d(distilroberta %>% filter(race == "African Americans") %>% pull(cosine), 
        distilroberta %>% filter(race == "White Americans") %>% pull(cosine))

mean(allminilm %>% filter(race == "African Americans") %>% pull(cosine))
sd(allminilm %>% filter(race == "African Americans") %>% pull(cosine))
mean(allminilm %>% filter(race == "White Americans") %>% pull(cosine))
sd(allminilm %>% filter(race == "White Americans") %>% pull(cosine))

t.test(allminilm %>% filter(race == "African Americans") %>% pull(cosine), 
       allminilm %>% filter(race == "White Americans") %>% pull(cosine), alternative = "greater")
cohen.d(allminilm %>% filter(race == "African Americans") %>% pull(cosine), 
        allminilm %>% filter(race == "White Americans") %>% pull(cosine))

