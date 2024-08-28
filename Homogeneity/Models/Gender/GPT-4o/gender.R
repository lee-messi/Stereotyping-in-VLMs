
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 25 Aug 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("lme4")){install.packages("lme4", dependencies = TRUE); require("lme4")}
if(!require("lmerTest")){install.packages("lmerTest", dependencies = TRUE); require("lmerTest")}
if(!require("effsize")){install.packages("effsize", dependencies = TRUE); require("effsize")}

# Load data --------------------------------------------------------------------

load('../../../Data/Gender/GPT-4o/gpt4o.RData')

# Fit mixed effects model (mpnetbase) ------------------------------------------

mpnetbase.gender.fem <- lmer(cosine ~ 1 + gender + fem + (1|pair_id),
                             data = gpt4o_mpnetbase, 
                             control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(mpnetbase.gender.fem)
logLik(mpnetbase.gender.fem)

mpnetbase.interaction <- lmer(cosine ~ 1 + gender * fem + (1|pair_id),
                              data = gpt4o_mpnetbase, 
                              control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(mpnetbase.interaction)
logLik(mpnetbase.interaction)

# Fit mixed effects model (distilroberta) --------------------------------------

distilroberta.gender.fem <- lmer(cosine ~ 1 + gender + fem + (1|pair_id), 
                                 data = gpt4o_distilroberta,
                                 control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(distilroberta.gender.fem)
logLik(distilroberta.gender.fem)

distilroberta.interaction <- lmer(cosine ~ 1 + gender * fem + (1|pair_id), 
                                  data = gpt4o_distilroberta,
                                  control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(distilroberta.interaction)
logLik(distilroberta.interaction)

# Fit mixed effects model (allminilm) ------------------------------------------

allminilm.gender.fem <- lmer(cosine ~ 1 + gender + fem + (1|pair_id), 
                             data = gpt4o_allminilm, 
                             control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(allminilm.gender.fem)
logLik(allminilm.gender.fem)

allminilm.interaction <- lmer(cosine ~ 1 + gender * fem + (1|pair_id), 
                              data = gpt4o_allminilm,
                              control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(allminilm.interaction)
logLik(allminilm.interaction)

# Supplementary analysis (gender model) ------------------------------------------

mpnetbase.gender <- lmer(cosine ~ 1 + gender + (1|pair_id), 
                       data = gpt4o_mpnetbase, 
                       control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(mpnetbase.gender)

distilroberta.gender <- lmer(cosine ~ 1 + gender + (1|pair_id), 
                           data = gpt4o_distilroberta,
                           control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(distilroberta.gender)

allminilm.gender <- lmer(cosine ~ 1 + gender + (1|pair_id), 
                       data = gpt4o_allminilm, 
                       control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE))

summary(allminilm.gender)
