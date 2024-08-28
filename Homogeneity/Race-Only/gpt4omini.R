
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 25 Aug 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("lme4")){install.packages("lme4", dependencies = TRUE); require("lme4")}
if(!require("lmerTest")){install.packages("lmerTest", dependencies = TRUE); require("lmerTest")}
if(!require("effsize")){install.packages("effsize", dependencies = TRUE); require("effsize")}

# Load data --------------------------------------------------------------------

load('../../../Data/Race/GPT-4o-mini/gpt4ominimini.RData')

# Fit mixed effects model (mpnetbase) ------------------------------------------

mpnetbase.race <- lmer(cosine ~ 1 + race + (1|pair_id), 
                       data = gpt4omini_mpnetbase, 
                       control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(mpnetbase.race)
logLik(mpnetbase.race)

# Fit mixed effects model (distilroberta) --------------------------------------

distilroberta.race <- lmer(cosine ~ 1 + race + (1|pair_id), 
                           data = gpt4omini_distilroberta, 
                           control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(distilroberta.race)
logLik(distilroberta.race)

# Fit mixed effects model (allminilm) ------------------------------------------

allminilm.race <- lmer(cosine ~ 1 + race + (1|pair_id), 
                       data = gpt4omini_allminilm, 
                       control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(allminilm.race)
logLik(allminilm.race)

