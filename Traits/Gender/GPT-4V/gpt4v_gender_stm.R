
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 28 Aug 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("stm")){install.packages("stm", dependencies = TRUE); require("stm")}
if(!require("reshape2")){install.packages("reshape2", dependencies = TRUE); require("reshape2")}
if(!require("ggsci")){install.packages("ggsci", dependencies = TRUE); require("ggsci")}
if(!require("stminsights")){install.packages("stminsights", dependencies = TRUE); require("stminsights")}
if(!require("readxl")){install.packages("readxl", dependencies = TRUE); require("readxl")}

# Load CFD codebook ------------------------------------------------------------

cfd <- read_excel('../../CFD/CFD.xlsx', 'CFD U.S. Norming Data')
column.names <- cfd[7,]
cfd <- cfd[8:nrow(cfd),]
colnames(cfd) <- column.names
cfd <- cfd[2:nrow(cfd),]

# Load generated text ----------------------------------------------------------

data = read.csv('../../../Data/GPT-4V/Gender/study_2.csv') %>%
  mutate(image = substr(image, 5, 10)) %>% 
  left_join(cfd %>% select(Model, Feminine), by = c("image" = "Model")) %>%
  rename(fem = Feminine) %>%
  mutate(fem = as.numeric(fem))

# Remove names -----------------------------------------------------------------

names = read.csv('../extracted_names.csv') %>% pull(names)

filtered <- data %>%
  mutate(text = str_replace_all(text, paste(names, collapse="|"), " ")) %>% 
  mutate(gender = factor(gender)) %>%
  mutate(gender = relevel(gender, ref = "male"))

# Prepare text for the STM -----------------------------------------------------

processed <- textProcessor(filtered$text, metadata = filtered)

out <- prepDocuments(processed$documents, processed$vocab, processed$meta)
docs <- out$documents
vocab <- out$vocab
meta <- out$meta

out <- prepDocuments(processed$documents, 
                     processed$vocab, 
                     processed$meta, 
                     lower.thresh = 5)

# Determine optimal number of topics -------------------------------------------

set.seed(1048596)

kresult <- searchK(docs, 
                   vocab,
                   c(3:15), 
                   interactions = FALSE,
                   prevalence = ~gender + fem + gender * fem,
                   data = meta, 
                   cores = 4)

plot(kresult)

# Fit the STM model using K = 8 ------------------------------------------------

fit <- stm(documents = out$documents, 
           vocab = out$vocab, 
           K = 8, 
           prevalence = ~ gender + fem + gender * fem, 
           data = out$meta, 
           init.type = "Spectral", 
           seed = 1048596)

# Save as .RData file ----------------------------------------------------------

# save.image('gpt4v_gender_stm.RData')
load('gpt4v_gender_stm.RData')

# Extract expected topic proportions -------------------------------------------

proportions_table <- make.dt(fit)
summarize_all(proportions_table, mean)

# Frex words for each topic ----------------------------------------------------

labelTopics(fit, topics = 1, n = 3)
labelTopics(fit, topics = 2, n = 3)
labelTopics(fit, topics = 3, n = 3)
labelTopics(fit, topics = 4, n = 3)
labelTopics(fit, topics = 5, n = 3)
labelTopics(fit, topics = 6, n = 3)
labelTopics(fit, topics = 7, n = 3)
labelTopics(fit, topics = 8, n = 3)

# Find sample texts for each topic ---------------------------------------------

findThoughts(fit, texts = filtered$text, n = 1, topics = 1)
findThoughts(fit, texts = filtered$text, n = 1, topics = 2)
findThoughts(fit, texts = filtered$text, n = 1, topics = 3)
findThoughts(fit, texts = filtered$text, n = 1, topics = 4)
findThoughts(fit, texts = filtered$text, n = 1, topics = 5)
findThoughts(fit, texts = filtered$text, n = 1, topics = 6)
findThoughts(fit, texts = filtered$text, n = 1, topics = 7)
findThoughts(fit, texts = filtered$text, n = 1, topics = 8)

# Main effect of gender ----------------------------------------------------------

set.seed(1048596)
summary(estimateEffect(c(1) ~ gender, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(2) ~ gender, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(3) ~ gender, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(4) ~ gender, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(5) ~ gender, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(6) ~ gender, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(7) ~ gender, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(8) ~ gender, fit, metadata = meta))

# Main effect of femininity ----------------------------------------------------

set.seed(1048596)
summary(estimateEffect(c(1) ~ fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(2) ~ fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(3) ~ fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(4) ~ fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(5) ~ fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(6) ~ fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(7) ~ fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(8) ~ fem, fit, metadata = meta))

# Interaction effect -----------------------------------------------------------

set.seed(1048596)
summary(estimateEffect(c(1) ~ gender * fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(2) ~ gender * fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(3) ~ gender * fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(4) ~ gender * fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(5) ~ gender * fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(6) ~ gender * fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(7) ~ gender * fem, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(8) ~ gender * fem, fit, metadata = meta))

