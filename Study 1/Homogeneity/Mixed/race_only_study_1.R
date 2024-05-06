
## Anonymous
# Racial Stereotyping in Large Multimodal Models

## Script date: 9 Apr 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("lme4")){install.packages("lme4", dependencies = TRUE); require("lme4")}
if(!require("lmerTest")){install.packages("lmerTest", dependencies = TRUE); require("lmerTest")}
if(!require("afex")){install.packages("afex", dependencies = TRUE); require("afex")}

# Load data --------------------------------------------------------------------

load('homogeneity_study_1.RData')

# Fit mixed effects model (mpnetbase) ------------------------------------------

mpnetbase.race <- lmer(cosine ~ 1 + race + (1|pair_id), 
                       data = mpnetbase, 
                       control = lmerControl(optimizer = "nmkbw", 
                                             calc.derivs = FALSE))

summary(mpnetbase.race) # Summary output of model including prototypicality
logLik(mpnetbase.race)

# Fit mixed effects model (distilroberta) --------------------------------------

distilroberta.race <- lmer(cosine ~ 1 + race + (1|pair_id), 
                           data = distilroberta, 
                           control = lmerControl(optimizer = "nmkbw", 
                                                 calc.derivs = FALSE))

summary(distilroberta.race) # Summary output of model including prototypicality
logLik(distilroberta.race)

# Fit mixed effects model (allminilm) ------------------------------------------

allminilm.race <- lmer(cosine ~ 1 + race + (1|pair_id), 
                       data = allminilm, 
                       control = lmerControl(optimizer = "nmkbw", 
                                             calc.derivs = FALSE))

summary(allminilm.race) # Summary output of model including prototypicality
logLik(allminilm.race)


# Likelihood-ratio tests -------------------------------------------------------

mixed(cosine ~ 1 + race + (1|pair_id), 
      data = mpnetbase, 
      control = lmerControl(optimizer = "nmkbw", 
                            calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + race + (1|pair_id), 
      data = distilroberta, 
      control = lmerControl(optimizer = "nmkbw", 
                            calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + race + (1|pair_id), 
      data = allminilm, 
      control = lmerControl(optimizer = "nmkbw", 
                            calc.derivs = FALSE),
      method = "LRT")

# Save as .RData ---------------------------------------------------------------

save.image('race_only_study_1.RData')

