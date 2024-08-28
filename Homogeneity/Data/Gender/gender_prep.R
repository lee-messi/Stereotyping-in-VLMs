
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

# Preprocess function (Gender) -------------------------------------------------

preprocess_gender <- function(file_name, model_name){
  
  df = read_csv(file_name) %>%
    mutate(gender = factor(gender, levels = c("male", "female")),
           gender = relevel(gender, ref = "male"),
           image_1 = substr(image_1, 5, 10),
           image_2 = substr(image_2, 5, 10),
           cosine = scale(cosine_similarity),
           image_pair = pmap_chr(list(image_1, image_2), ~paste(sort(c(...)), collapse = "-")),
           pair_id = as.factor(image_pair)) %>%
    left_join(cfd %>% select(Model, Masculine, Feminine), by = c("image_1" = "Model")) %>%
    rename(masc_1 = Masculine, fem_1 = Feminine) %>%
    left_join(cfd %>% select(Model, Masculine, Feminine), by = c("image_2" = "Model")) %>%
    rename(masc_2 = Masculine, fem_2 = Feminine) %>%
    mutate(masc_1 = as.numeric(masc_1),
           masc_2 = as.numeric(masc_2),
           fem_1 = as.numeric(fem_1),
           fem_2 = as.numeric(fem_2),
           fem = (fem_1 + fem_2)/2) %>%
    select(-c(masc_1, masc_2, fem_1, fem_2, image_1, image_2, image_pair, cosine_similarity)) %>%
    mutate(model = model_name)
  
  return(df)
  
}

# Preprocess Data (Gender) -----------------------------------------------------

gpt4v_mpnetbase = preprocess_gender('../../Data/gender/GPT-4V/gpt4v_mpnetbase.csv', "GPT-4V")
gpt4v_distilroberta = preprocess_gender('../../Data/gender/GPT-4V/gpt4v_distilroberta.csv', "GPT-4V")
gpt4v_allminilm = preprocess_gender('../../Data/gender/GPT-4V/gpt4v_allminilm.csv', "GPT-4V")

gpt4o_mpnetbase = preprocess_gender('../../Data/gender/GPT-4o/gpt4o_mpnetbase.csv', "GPT-4o")
gpt4o_distilroberta = preprocess_gender('../../Data/gender/GPT-4o/gpt4o_distilroberta.csv', "GPT-4o")
gpt4o_allminilm = preprocess_gender('../../Data/gender/GPT-4o/gpt4o_allminilm.csv', "GPT-4o")

gpt4omini_mpnetbase = preprocess_gender('../../Data/gender/GPT-4o-mini/gpt4omini_mpnetbase.csv', "GPT-4o-mini")
gpt4omini_distilroberta = preprocess_gender('../../Data/gender/GPT-4o-mini/gpt4omini_distilroberta.csv', "GPT-4o-mini")
gpt4omini_allminilm = preprocess_gender('../../Data/gender/GPT-4o-mini/gpt4omini_allminilm.csv', "GPT-4o-mini")

save(gpt4v_mpnetbase, gpt4v_distilroberta, gpt4v_allminilm, file = "../../Data/gender/GPT-4V/gpt4v.RData")
save(gpt4o_mpnetbase, gpt4o_distilroberta, gpt4o_allminilm, file = "../../Data/gender/GPT-4o/gpt4o.RData")
save(gpt4omini_mpnetbase, gpt4omini_distilroberta, gpt4omini_allminilm, file = "../../Data/gender/GPT-4o-mini/gpt4omini.RData")
