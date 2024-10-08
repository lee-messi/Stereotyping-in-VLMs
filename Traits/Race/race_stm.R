
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 4 Sept 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("stm")){install.packages("stm", dependencies = TRUE); require("stm")}
if(!require("reshape2")){install.packages("reshape2", dependencies = TRUE); require("reshape2")}
if(!require("ggsci")){install.packages("ggsci", dependencies = TRUE); require("ggsci")}
if(!require("stminsights")){install.packages("stminsights", dependencies = TRUE); require("stminsights")}
if(!require("readxl")){install.packages("readxl", dependencies = TRUE); require("readxl")}

# Load CFD codebook ------------------------------------------------------------

cfd <- read_excel('../CFD/CFD.xlsx', 'CFD U.S. Norming Data')
column.names <- cfd[7,]
cfd <- cfd[8:nrow(cfd),]
colnames(cfd) <- column.names
cfd <- cfd[2:nrow(cfd),]

# Load generated text ----------------------------------------------------------

preprocess_race <- function(file_name, model_name){
  df = read.csv(file_name) %>% 
    mutate(image = substr(image, 5, 10)) %>% 
    left_join(cfd %>% select(Model, Prototypic), by = c("image" = "Model")) %>%
    mutate(proto = as.numeric(Prototypic)) %>%
    select(-Prototypic) %>% 
    mutate(model = model_name)
  return(df)
}

gpt4v = preprocess_race('../../Data/GPT-4V/Race/study_1.csv', "GPT-4V")
gpt4o = preprocess_race('../../Data/GPT-4o/Race/study_1.csv', "GPT-4o")
gpt4omini = preprocess_race('../../Data/GPT-4o-mini/Race/study_1.csv', "GPT-4o-mini")

# Remove names -----------------------------------------------------------------

names = read.csv('extracted_names.csv') %>% pull(names)

remove_names = function(df){
  df = df %>% 
    mutate(text = str_replace_all(text, paste(names, collapse="|"), "")) %>% 
    mutate(race = factor(race)) %>%
    mutate(race = relevel(race, ref = "white"))
  return(df)
}

gpt4v = remove_names(gpt4v)
gpt4o = remove_names(gpt4o)
gpt4omini = remove_names(gpt4omini)
all_texts = rbind(gpt4v, gpt4o, gpt4omini)
all_texts = all_texts %>% 
  mutate(model = factor(model)) %>%
  mutate(model = relevel(model, "GPT-4V"))

# Prepare text for the STM -----------------------------------------------------

processed <- textProcessor(all_texts$text, metadata = all_texts)

out <- prepDocuments(processed$documents, processed$vocab, processed$meta)
docs <- out$documents
vocab <- out$vocab
meta <- out$meta

out <- prepDocuments(processed$documents, 
                     processed$vocab, 
                     processed$meta, 
                     lower.thresh = 10)

# Determine optimal number of topics -------------------------------------------

set.seed(1048596)

kresult <- searchK(docs, 
                   vocab,
                   c(3:15), 
                   interactions = FALSE,
                   prevalence = ~race + proto + race * proto + model,
                   data = meta, 
                   cores = 4)

plot(kresult)

# Fit the STM model using K = 8 ------------------------------------------------

fit <- stm(documents = out$documents, 
           vocab = out$vocab, 
           K = 8, 
           prevalence = ~ race + proto + race * proto + model, 
           data = out$meta, 
           init.type = "Spectral", 
           seed = 1048596)

# Save as .RData file ----------------------------------------------------------

# save.image('race_stm.RData')
load('race_stm.RData')

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

findThoughts(fit, texts = all_texts$text, n = 1, topics = 1)
findThoughts(fit, texts = all_texts$text, n = 1, topics = 2)
findThoughts(fit, texts = all_texts$text, n = 1, topics = 3)
findThoughts(fit, texts = all_texts$text, n = 1, topics = 4)
findThoughts(fit, texts = all_texts$text, n = 1, topics = 5)
findThoughts(fit, texts = all_texts$text, n = 1, topics = 6)
findThoughts(fit, texts = all_texts$text, n = 1, topics = 7)
findThoughts(fit, texts = all_texts$text, n = 1, topics = 8)

# Main effect of race ----------------------------------------------------------

set.seed(1048596)
summary(estimateEffect(c(1) ~ race + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(2) ~ race + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(3) ~ race + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(4) ~ race + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(5) ~ race + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(6) ~ race + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(7) ~ race + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(8) ~ race + model, fit, metadata = meta))

# Main effect of prototypicality -----------------------------------------------

set.seed(1048596)
summary(estimateEffect(c(1) ~ proto + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(2) ~ proto + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(3) ~ proto + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(4) ~ proto + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(5) ~ proto + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(6) ~ proto + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(7) ~ proto + model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(8) ~ proto + model, fit, metadata = meta))

# Interaction effect -----------------------------------------------------------

set.seed(1048596)
summary(estimateEffect(c(1) ~ race * proto * model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(2) ~ race * proto * model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(3) ~ race * proto * model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(4) ~ race * proto * model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(5) ~ race * proto * model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(6) ~ race * proto * model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(7) ~ race * proto * model, fit, metadata = meta))

set.seed(1048596)
summary(estimateEffect(c(8) ~ race * proto * model, fit, metadata = meta))

