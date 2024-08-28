
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 25 Aug 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("lme4")){install.packages("lme4", dependencies = TRUE); require("lme4")}
if(!require("lmerTest")){install.packages("lmerTest", dependencies = TRUE); require("lmerTest")}
if(!require("afex")){install.packages("afex", dependencies = TRUE); require("afex")}

# Load data --------------------------------------------------------------------

load('../../../Data/Race/GPT-4o/gpt4o.RData')

# Likelihood Ratio Tests (LRTs) for Race and Prototypicality -------------------

mixed(cosine ~ 1 + race + proto + (1|pair_id), 
      data = gpt4o_mpnetbase, 
      control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + race + proto + (1|pair_id), 
      data = gpt4o_distilroberta, 
      control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + race + proto + (1|pair_id), 
      data = gpt4o_allminilm, 
      control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE),
      method = "LRT")

# Likelihood Ratio Tests (LRTs) for the Interaction effect ----------------------

mixed(cosine ~ 1 + race : proto + (1|pair_id), 
      data = gpt4o_mpnetbase, 
      control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + race : proto + (1|pair_id), 
      data = gpt4o_distilroberta, 
      control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + race : proto + (1|pair_id), 
      data = gpt4o_allminilm, 
      control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE),
      method = "LRT")
