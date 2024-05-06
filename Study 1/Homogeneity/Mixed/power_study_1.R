
## Anonymous
# Racial Stereotyping in Large Multimodal Models

## Script date: 23 Mar 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("readxl")){install.packages("readxl", dependencies = TRUE); require("readxl")}
if(!require("lme4")){install.packages("lme4", dependencies = TRUE); require("lme4")}
if(!require("lmerTest")){install.packages("lmerTest", dependencies = TRUE); require("lmerTest")}
if(!require("arrow")){install.packages("arrow", dependencies = TRUE); require("arrow")}
if(!require("simr")){install.packages("simr", dependencies = TRUE); require("simr")}

# Load generated text ----------------------------------------------------------

load('homogeneity_study_1.RData')

# Given the massive sample size and the time to run simulations, 
# we randomly sampled 50 observations for each image pair.
# Hence, the power calculations here are under-estimated. 
set.seed(1048596)
mpnetbase_sample = mpnetbase %>% group_by(image_pair) %>% sample_n(50)

# Fit mixed effects model and determine power (race = 0.30) --------------------

mpnetbase.interaction <- lmer(cosine ~ 1 + race * proto + (1|pair_id), 
                              data = mpnetbase_sample, 
                              control = lmerControl(optimizer = "nmkbw", 
                                                    calc.derivs = FALSE))

summary(mpnetbase.interaction)
fixef(mpnetbase.interaction)["raceblack"] <- 0.30

powerSim(mpnetbase.interaction, nsim = 100, 
         test = fixed("raceblack", method = "z"))

# Investigate the relationship between the number of groups and power ----------

length(unique(mpnetbase$pair_id)) # current number of pairs: 8742

pc.more.groups <- powerCurve(mpnetbase.interaction, 
                             breaks = c(3660, 4290, 4970, 6480, 8742), 
                             along = "pair_id", nsim = 100, 
                             test = fixed("raceblack", method = "z"))

plot(pc.more.groups) # Plot power curve
save.image("power_study_1.RData") # Save power curve
