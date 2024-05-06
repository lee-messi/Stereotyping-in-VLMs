
## Anonymous
# Racial Stereotyping in Large Multimodal Models

## Script date: 18 Apr 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("lme4")){install.packages("lme4", dependencies = TRUE); require("lme4")}
if(!require("lmerTest")){install.packages("lmerTest", dependencies = TRUE); require("lmerTest")}
if(!require("effsize")){install.packages("effsize", dependencies = TRUE); require("effsize")}
if(!require("emmeans")){install.packages("emmeans", dependencies = TRUE); require("emmeans")}

# Load data --------------------------------------------------------------------

load('homogeneity_study_2_femininity.RData')

# Independent samples t-tests --------------------------------------------------

mean(mpnetbase %>% filter(gender == "female") %>% pull(cosine_similarity))
sd(mpnetbase %>% filter(gender == "female") %>% pull(cosine_similarity))
mean(mpnetbase %>% filter(gender == "male") %>% pull(cosine_similarity))
sd(mpnetbase %>% filter(gender == "male") %>% pull(cosine_similarity))

t.test(mpnetbase %>% filter(gender == "female") %>% pull(cosine_similarity), 
       mpnetbase %>% filter(gender == "male") %>% pull(cosine_similarity), alternative = "greater")
cohen.d(mpnetbase %>% filter(gender == "female") %>% pull(cosine_similarity), 
        mpnetbase %>% filter(gender == "male") %>% pull(cosine_similarity))

mean(distilroberta %>% filter(gender == "female") %>% pull(cosine_similarity))
sd(distilroberta %>% filter(gender == "female") %>% pull(cosine_similarity))
mean(distilroberta %>% filter(gender == "male") %>% pull(cosine_similarity))
sd(distilroberta %>% filter(gender == "male") %>% pull(cosine_similarity))

t.test(distilroberta %>% filter(gender == "female") %>% pull(cosine_similarity), 
       distilroberta %>% filter(gender == "male") %>% pull(cosine_similarity), alternative = "greater")
cohen.d(distilroberta %>% filter(gender == "female") %>% pull(cosine_similarity), 
        distilroberta %>% filter(gender == "male") %>% pull(cosine_similarity))

mean(allminilm %>% filter(gender == "female") %>% pull(cosine_similarity))
sd(allminilm %>% filter(gender == "female") %>% pull(cosine_similarity))
mean(allminilm %>% filter(gender == "male") %>% pull(cosine_similarity))
sd(allminilm %>% filter(gender == "male") %>% pull(cosine_similarity))

t.test(allminilm %>% filter(gender == "female") %>% pull(cosine_similarity), 
       allminilm %>% filter(gender == "male") %>% pull(cosine_similarity), alternative = "greater")
cohen.d(allminilm %>% filter(gender == "female") %>% pull(cosine_similarity), 
        allminilm %>% filter(gender == "male") %>% pull(cosine_similarity))

# Fit mixed effects model (mpnetbase) ------------------------------------------

mpnetbase.gender.fem <- lmer(cosine ~ 1 + gender + fem + (1|pair_id), 
                             data = mpnetbase, 
                             control = lmerControl(optimizer = "nmkbw", 
                                                   calc.derivs = FALSE))

summary(mpnetbase.gender.fem) # Summary output of model including femtypicality
logLik(mpnetbase.gender.fem)

mpnetbase.interaction <- lmer(cosine ~ 1 + gender * fem + (1|pair_id), 
                              data = mpnetbase, 
                              control = lmerControl(optimizer = "nmkbw", 
                                                    calc.derivs = FALSE))

summary(mpnetbase.interaction) # Summary output for the interaction model
logLik(mpnetbase.interaction)

# Fit mixed effects model (distilroberta) --------------------------------------

distilroberta.gender.fem <- lmer(cosine ~ 1 + gender + fem + (1|pair_id), 
                                 data = distilroberta, 
                                 control = lmerControl(optimizer = "nmkbw", 
                                                       calc.derivs = FALSE))

summary(distilroberta.gender.fem) # Summary output of model including femulinity
logLik(distilroberta.gender.fem)

distilroberta.interaction <- lmer(cosine ~ 1 + gender * fem + (1|pair_id), 
                                  data = distilroberta, 
                                  control = lmerControl(optimizer = "nmkbw", 
                                                        calc.derivs = FALSE))

summary(distilroberta.interaction) # Summary output for the interaction model
logLik(distilroberta.interaction)

# Fit mixed effects model (allminilm) ------------------------------------------

allminilm.gender.fem <- lmer(cosine ~ 1 + gender + fem + (1|pair_id), 
                             data = allminilm, 
                             control = lmerControl(optimizer = "nmkbw", 
                                                   calc.derivs = FALSE))

summary(allminilm.gender.fem) # Summary output of model including femulinity
logLik(allminilm.gender.fem)

allminilm.interaction <- lmer(cosine ~ 1 + gender * fem + (1|pair_id), 
                              data = allminilm, 
                              control = lmerControl(optimizer = "nmkbw", 
                                                    calc.derivs = FALSE))

summary(allminilm.interaction) # Summary output for the interaction model
logLik(allminilm.interaction)

# Pairwise comparisons ---------------------------------------------------------

mpnetbase.trends = emtrends(mpnetbase.interaction, 
                            specs = "gender", var = "fem") |> test()

distilroberta.trends = emtrends(distilroberta.interaction, 
                                specs = "gender", var = "fem") |> test()

allminilm.trends = emtrends(allminilm.interaction, 
                            specs = "gender", var = "fem") |> test()

# Save as .RData ---------------------------------------------------------------

save.image('mixed_models_study_2_femininity.RData')

