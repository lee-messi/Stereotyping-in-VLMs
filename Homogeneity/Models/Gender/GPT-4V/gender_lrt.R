
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 28 Oct 2024 

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("lme4")){install.packages("lme4", dependencies = TRUE); require("lme4")}
if(!require("lmerTest")){install.packages("lmerTest", dependencies = TRUE); require("lmerTest")}
if(!require("afex")){install.packages("afex", dependencies = TRUE); require("afex")}

# Load data --------------------------------------------------------------------

load('../../../Data/Gender/GPT-4V/gpt4v.RData')

# Likelihood Ratio Tests (LRTs) for Gender and Femininity ----------------------

mixed(cosine ~ 1 + gender + fem + (1|pair_id), 
      data = gpt4v_mpnetbase, 
      control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + gender + fem + (1|pair_id), 
      data = gpt4v_distilroberta, 
      control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + gender + fem + (1|pair_id), 
      data = gpt4v_allminilm, 
      control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE),
      method = "LRT")

# Likelihood Ratio Tests (LRTs) for the Interaction effect ----------------------

mixed(cosine ~ 1 + gender : fem + (1|pair_id), 
      data = gpt4v_mpnetbase, 
      control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + gender : fem + (1|pair_id), 
      data = gpt4v_distilroberta, 
      control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE),
      method = "LRT")

mixed(cosine ~ 1 + gender : fem + (1|pair_id), 
      data = gpt4v_allminilm, 
      control = lmerControl(optimizer = "nmkbw", calc.derivs = FALSE),
      method = "LRT")
