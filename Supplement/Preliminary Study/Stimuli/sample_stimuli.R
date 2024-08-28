
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 28 Aug 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}

# Randomly sample image stimuli to use -----------------------------------------

# Index of Figures of Black Males (BM-) from CFD
black_idx <- c(1:5, 9:13, 15:34, 36:41, 43:46, 200:219, 221:253)

# Index of Figures of White Males (WM-) from CFD
white_idx <- c(1:4, 6, 9:26, 28:29, 31:41, 200:225, 227:245, 247:258)

set.seed(1048596)
sample(black_idx, 20) %>% sort()
sample(white_idx, 20) %>% sort()
