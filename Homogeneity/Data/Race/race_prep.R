
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 23 Aug 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("readxl")){install.packages("readxl", dependencies = TRUE); require("readxl")}

# Load CFD codebook ------------------------------------------------------------

cfd <- read_excel('../../Data/CFD/CFD.xlsx', 'CFD U.S. Norming Data')
column.names <- cfd[7,]
cfd <- cfd[8:nrow(cfd),]
colnames(cfd) <- column.names
cfd <- cfd[2:nrow(cfd),]

# Preprocess function (Race) ---------------------------------------------------

preprocess_race <- function(file_name, model_name){
  
  df = read_csv(file_name) %>%
    mutate(race = factor(race)) %>%
    mutate(race = relevel(race, ref = "white")) %>%
    mutate(image_1 = substr(image_1, 5, 10)) %>% 
    mutate(image_2 = substr(image_2, 5, 10)) %>% 
    mutate(cosine = scale(cosine_similarity)) %>% 
    mutate(image_pair = pmap_chr(list(image_1, image_2), ~paste(sort(c(...)), collapse = "-")),
           pair_id = as.factor(image_pair)) %>%
    left_join(cfd %>% select(Model, Prototypic), by = c("image_1" = "Model")) %>%
    mutate(proto_1 = as.numeric(Prototypic)) %>%
    select(-Prototypic) %>%
    left_join(cfd %>% select(Model, Prototypic), by = c("image_2" = "Model")) %>%
    mutate(proto_2 = as.numeric(Prototypic)) %>%
    mutate(proto = (proto_1 + proto_2)/2) %>% 
    select(-c(Prototypic, proto_1, proto_2, image_1, image_2, image_pair, cosine_similarity)) %>%
    mutate(model = model_name)
  
  return(df)
  
}

# Preprocess Data (Race) -------------------------------------------------------

gpt4v_mpnetbase = preprocess_race('../../Data/Race/GPT-4V/gpt4v_mpnetbase.csv', "GPT-4V")
gpt4v_distilroberta = preprocess_race('../../Data/Race/GPT-4V/gpt4v_distilroberta.csv', "GPT-4V")
gpt4v_allminilm = preprocess_race('../../Data/Race/GPT-4V/gpt4v_allminilm.csv', "GPT-4V")

gpt4o_mpnetbase = preprocess_race('../../Data/Race/GPT-4o/gpt4o_mpnetbase.csv', "GPT-4o")
gpt4o_distilroberta = preprocess_race('../../Data/Race/GPT-4o/gpt4o_distilroberta.csv', "GPT-4o")
gpt4o_allminilm = preprocess_race('../../Data/Race/GPT-4o/gpt4o_allminilm.csv', "GPT-4o")

gpt4omini_mpnetbase = preprocess_race('../../Data/Race/GPT-4o-mini/gpt4omini_mpnetbase.csv', "GPT-4o-mini")
gpt4omini_distilroberta = preprocess_race('../../Data/Race/GPT-4o-mini/gpt4omini_distilroberta.csv', "GPT-4o-mini")
gpt4omini_allminilm = preprocess_race('../../Data/Race/GPT-4o-mini/gpt4omini_allminilm.csv', "GPT-4o-mini")

save(gpt4v_mpnetbase, gpt4v_distilroberta, gpt4v_allminilm, file = "../../Data/Race/GPT-4V/gpt4v.RData")
save(gpt4o_mpnetbase, gpt4o_distilroberta, gpt4o_allminilm, file = "../../Data/Race/GPT-4o/gpt4o.RData")
save(gpt4omini_mpnetbase, gpt4omini_distilroberta, gpt4omini_allminilm, file = "../../Data/Race/GPT-4o-mini/gpt4omini.RData")
