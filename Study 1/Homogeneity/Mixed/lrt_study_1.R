
## Anonymous
# Racial Stereotyping in Large Multimodal Models

## Script date: 31 Mar 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("lme4")){install.packages("lme4", dependencies = TRUE); require("lme4")}
if(!require("lmerTest")){install.packages("lmerTest", dependencies = TRUE); require("lmerTest")}
if(!require("afex")){install.packages("afex", dependencies = TRUE); require("afex")}

# Load data --------------------------------------------------------------------

load('homogeneity_study_1.RData')

# Likelihood Ratio Tests (LRTs) for Race and Prototypicality -------------------

mixed(cosine ~ 1 + race + proto + (1|pair_id), 
      data = mpnetbase, 
      control = lmerControl(optimizer = "nmkbw", 
                            calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + race + proto + (1|pair_id), 
      data = distilroberta, 
      control = lmerControl(optimizer = "nmkbw", 
                            calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + race + proto + (1|pair_id), 
      data = allminilm, 
      control = lmerControl(optimizer = "nmkbw", 
                            calc.derivs = FALSE),
      method = "LRT")

# Likelihood Ratio Tests (LRTs) for the Interaction effect ----------------------

mixed(cosine ~ 1 + race * proto + (1|pair_id), 
      data = mpnetbase, 
      control = lmerControl(optimizer = "nmkbw", 
                            calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + race * proto + (1|pair_id), 
      data = distilroberta, 
      control = lmerControl(optimizer = "nmkbw", 
                            calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + race * proto + (1|pair_id), 
      data = allminilm, 
      control = lmerControl(optimizer = "nmkbw", 
                            calc.derivs = FALSE),
      method = "LRT")
