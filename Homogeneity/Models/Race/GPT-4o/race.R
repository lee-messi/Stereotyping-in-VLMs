
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 25 Aug 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("lme4")){install.packages("lme4", dependencies = TRUE); require("lme4")}
if(!require("lmerTest")){install.packages("lmerTest", dependencies = TRUE); require("lmerTest")}
if(!require("effsize")){install.packages("effsize", dependencies = TRUE); require("effsize")}

# Load data --------------------------------------------------------------------

load('../../../Data/Race/GPT-4o/gpt4o.RData')

# Fit mixed effects model (mpnetbase) ------------------------------------------

mpnetbase.race.proto <- lmer(cosine ~ 1 + race + proto + (1|pair_id) + (1 + race + proto|model), 
                             data = gpt4o_mpnetbase, 
                             control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(mpnetbase.race.proto)
logLik(mpnetbase.race.proto)

mpnetbase.interaction <- lmer(cosine ~ 1 + race * proto + (1|pair_id), 
                              data = gpt4o_mpnetbase, 
                              control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(mpnetbase.interaction)
logLik(mpnetbase.interaction)

# Fit mixed effects model (distilroberta) --------------------------------------

distilroberta.race.proto <- lmer(cosine ~ 1 + race + proto + (1|pair_id), 
                                 data = gpt4o_distilroberta, 
                                 control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(distilroberta.race.proto)
logLik(distilroberta.race.proto)

distilroberta.interaction <- lmer(cosine ~ 1 + race * proto + (1|pair_id), 
                                  data = gpt4o_distilroberta, 
                                  control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(distilroberta.interaction) # Summary output for the interaction model
logLik(distilroberta.interaction)

# Fit mixed effects model (allminilm) ------------------------------------------

allminilm.race.proto <- lmer(cosine ~ 1 + race + proto + (1|pair_id), 
                             data = gpt4o_allminilm, 
                             control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(allminilm.race.proto)
logLik(allminilm.race.proto)

allminilm.interaction <- lmer(cosine ~ 1 + race * proto + (1|pair_id), 
                              data = gpt4o_allminilm, 
                              control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(allminilm.interaction)
logLik(allminilm.interaction)

# Supplementary analysis (Race model) ------------------------------------------

mpnetbase.race <- lmer(cosine ~ 1 + race + (1|pair_id), 
                       data = gpt4o_mpnetbase, 
                       control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(mpnetbase.race)

distilroberta.race <- lmer(cosine ~ 1 + race + (1|pair_id), 
                           data = gpt4o_distilroberta, 
                           control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(distilroberta.race)

allminilm.race <- lmer(cosine ~ 1 + race + (1|pair_id), 
                       data = gpt4o_allminilm, 
                       control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(allminilm.race)

