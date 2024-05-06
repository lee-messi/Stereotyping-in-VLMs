
## Anonymous
# Racial Stereotyping in Large Multimodal Models

## Script date: 8 Mar 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("readxl")){install.packages("readxl", dependencies = TRUE); require("readxl")}

# Load CFD codebook ------------------------------------------------------------

cfd <- read_excel('../../../CFD/CFD.xlsx', 'CFD U.S. Norming Data')
column.names <- cfd[7,]
cfd <- cfd[8:nrow(cfd),]
colnames(cfd) <- column.names
cfd <- cfd[2:nrow(cfd),]

# Preprocess function ----------------------------------------------------------

preprocess <- function(file_name){
  
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
    select(-Prototypic) %>%
    mutate(proto = (proto_1 + proto_2)/2)
  
  return(df)
  
}

mpnetbase = preprocess('../Cosine/mpnetbase.csv')
distilroberta = preprocess('../Cosine/distilroberta.csv')
allminilm = preprocess('../Cosine/allminilm.csv')

# Save as .RData ---------------------------------------------------------------

save.image('../Mixed/homogeneity_study_1.RData')
