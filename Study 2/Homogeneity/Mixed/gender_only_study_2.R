
## Anonymous
# Racial Stereotyping in Large Multimodal Models

## Script date: 13 Apr 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("lme4")){install.packages("lme4", dependencies = TRUE); require("lme4")}
if(!require("lmerTest")){install.packages("lmerTest", dependencies = TRUE); require("lmerTest")}
if(!require("afex")){install.packages("afex", dependencies = TRUE); require("afex")}

# Load data --------------------------------------------------------------------

load('homogeneity_study_2.RData')

# Fit mixed effects model (mpnetbase) ------------------------------------------

mpnetbase.gender <- lmer(cosine ~ 1 + gender + (1|pair_id), 
                         data = mpnetbase, 
                         control = lmerControl(optimizer = "nmkbw", 
                                               calc.derivs = FALSE))

summary(mpnetbase.gender)
logLik(mpnetbase.gender)

# Fit mixed effects model (distilroberta) --------------------------------------

distilroberta.gender <- lmer(cosine ~ 1 + gender + (1|pair_id), 
                             data = distilroberta, 
                             control = lmerControl(optimizer = "nmkbw", 
                                                   calc.derivs = FALSE))

summary(distilroberta.gender)
logLik(distilroberta.gender)

# Fit mixed effects model (allminilm) ------------------------------------------

allminilm.gender <- lmer(cosine ~ 1 + gender + (1|pair_id), 
                       data = allminilm, 
                       control = lmerControl(optimizer = "nmkbw", 
                                             calc.derivs = FALSE))

summary(allminilm.gender)
logLik(allminilm.gender)


# Likelihood-ratio tests -------------------------------------------------------

mpnetbase.lrt = mixed(cosine ~ 1 + gender + (1|pair_id), 
                      data = mpnetbase, 
                      control = lmerControl(optimizer = "nmkbw", 
                                            calc.derivs = FALSE),
                      method = "LRT")

distilroberta.lrt = mixed(cosine ~ 1 + gender + (1|pair_id), 
                          data = distilroberta, 
                          control = lmerControl(optimizer = "nmkbw", 
                                                calc.derivs = FALSE),
                          method = "LRT")

allminilm.lrt = mixed(cosine ~ 1 + gender + (1|pair_id), 
                      data = allminilm, 
                      control = lmerControl(optimizer = "nmkbw", 
                                            calc.derivs = FALSE),
                      method = "LRT")

# Save as .RData ---------------------------------------------------------------

rm(mpnetbase, distilroberta, allminilm)
save.image('gender_only_study_2.RData')

