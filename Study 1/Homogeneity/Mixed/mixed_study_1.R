
## Anonymous
# Racial Stereotyping in Large Multimodal Models

## Script date: 10 Mar 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("lme4")){install.packages("lme4", dependencies = TRUE); require("lme4")}
if(!require("lmerTest")){install.packages("lmerTest", dependencies = TRUE); require("lmerTest")}
if(!require("effsize")){install.packages("effsize", dependencies = TRUE); require("effsize")}

# Load data --------------------------------------------------------------------

load('homogeneity_study_1.RData')

# Independent samples t-tests --------------------------------------------------

mean(mpnetbase %>% filter(race == "black") %>% pull(cosine_similarity))
sd(mpnetbase %>% filter(race == "black") %>% pull(cosine_similarity))
mean(mpnetbase %>% filter(race == "white") %>% pull(cosine_similarity))
sd(mpnetbase %>% filter(race == "white") %>% pull(cosine_similarity))

t.test(mpnetbase %>% filter(race == "black") %>% pull(cosine_similarity), 
       mpnetbase %>% filter(race == "white") %>% pull(cosine_similarity), alternative = "greater")
cohen.d(mpnetbase %>% filter(race == "black") %>% pull(cosine_similarity), 
        mpnetbase %>% filter(race == "white") %>% pull(cosine_similarity))

mean(distilroberta %>% filter(race == "black") %>% pull(cosine_similarity))
sd(distilroberta %>% filter(race == "black") %>% pull(cosine_similarity))
mean(distilroberta %>% filter(race == "white") %>% pull(cosine_similarity))
sd(distilroberta %>% filter(race == "white") %>% pull(cosine_similarity))

t.test(distilroberta %>% filter(race == "black") %>% pull(cosine_similarity), 
       distilroberta %>% filter(race == "white") %>% pull(cosine_similarity), alternative = "greater")
cohen.d(distilroberta %>% filter(race == "black") %>% pull(cosine_similarity), 
        distilroberta %>% filter(race == "white") %>% pull(cosine_similarity))

mean(allminilm %>% filter(race == "black") %>% pull(cosine_similarity))
sd(allminilm %>% filter(race == "black") %>% pull(cosine_similarity))
mean(allminilm %>% filter(race == "white") %>% pull(cosine_similarity))
sd(allminilm %>% filter(race == "white") %>% pull(cosine_similarity))

t.test(allminilm %>% filter(race == "black") %>% pull(cosine_similarity), 
       allminilm %>% filter(race == "white") %>% pull(cosine_similarity), alternative = "greater")
cohen.d(allminilm %>% filter(race == "black") %>% pull(cosine_similarity), 
        allminilm %>% filter(race == "white") %>% pull(cosine_similarity))

# Fit mixed effects model (mpnetbase) ------------------------------------------

mpnetbase.race.proto <- lmer(cosine ~ 1 + race + proto + (1|pair_id), 
                             data = mpnetbase, 
                             control = lmerControl(optimizer = "nmkbw", 
                                                   calc.derivs = FALSE))

summary(mpnetbase.race.proto) # Summary output of model including prototypicality
logLik(mpnetbase.race.proto)

mpnetbase.interaction <- lmer(cosine ~ 1 + race * proto + (1|pair_id), 
                              data = mpnetbase, 
                              control = lmerControl(optimizer = "nmkbw", 
                                                    calc.derivs = FALSE))

summary(mpnetbase.interaction) # Summary output for the interaction model
logLik(mpnetbase.interaction)

# Fit mixed effects model (distilroberta) --------------------------------------

distilroberta.race.proto <- lmer(cosine ~ 1 + race + proto + (1|pair_id), 
                                 data = distilroberta, 
                                 control = lmerControl(optimizer = "nmkbw", 
                                                       calc.derivs = FALSE))

summary(distilroberta.race.proto) # Summary output of model including prototypicality
logLik(distilroberta.race.proto)

distilroberta.interaction <- lmer(cosine ~ 1 + race * proto + (1|pair_id), 
                                  data = distilroberta, 
                                  control = lmerControl(optimizer = "nmkbw", 
                                                        calc.derivs = FALSE))

summary(distilroberta.interaction) # Summary output for the interaction model
logLik(distilroberta.interaction)

# Fit mixed effects model (allminilm) ------------------------------------------

allminilm.race.proto <- lmer(cosine ~ 1 + race + proto + (1|pair_id), 
                             data = allminilm, 
                             control = lmerControl(optimizer = "nmkbw", 
                                                   calc.derivs = FALSE))

summary(allminilm.race.proto) # Summary output of model including prototypicality
logLik(allminilm.race.proto)

allminilm.interaction <- lmer(cosine ~ 1 + race * proto + (1|pair_id), 
                              data = allminilm, 
                              control = lmerControl(optimizer = "nmkbw", 
                                                    calc.derivs = FALSE))

summary(allminilm.interaction) # Summary output for the interaction model
logLik(allminilm.interaction)

# Supplementary analysis (Race model) ------------------------------------------

mpnetbase.race <- lmer(cosine ~ 1 + race + (1|pair_id), 
                       data = mpnetbase, 
                       control = lmerControl(optimizer = "nmkbw", 
                                             calc.derivs = FALSE))

summary(mpnetbase.race)

distilroberta.race <- lmer(cosine ~ 1 + race + (1|pair_id), 
                           data = distilroberta, 
                           control = lmerControl(optimizer = "nmkbw", 
                                                 calc.derivs = FALSE))

summary(distilroberta.race)

allminilm.race <- lmer(cosine ~ 1 + race + (1|pair_id), 
                       data = allminilm, 
                       control = lmerControl(optimizer = "nmkbw", 
                                             calc.derivs = FALSE))

summary(allminilm.race)

# Save as .RData ---------------------------------------------------------------

# save.image('mixed_models_study_1.RData')

