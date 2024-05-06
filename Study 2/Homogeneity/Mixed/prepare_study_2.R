
## Anonymous
# Racial Stereotyping in Large Multimodal Models

## Script date: 12 Apr 2024

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
           masc = if_else(gender == "male" & !is.na(masc_1) & !is.na(masc_2), (masc_1 + masc_2)/2, NA_real_),
           fem = if_else(gender == "female" & !is.na(fem_1) & !is.na(fem_2), (fem_1 + fem_2)/2, NA_real_),
           proto = coalesce(masc, fem)) %>%
    select(-c(masc_1, masc_2, fem_1, fem_2))
  
  return(df)
  
}

mpnetbase = preprocess('../Cosine/mpnetbase.csv')
distilroberta = preprocess('../Cosine/distilroberta.csv')
allminilm = preprocess('../Cosine/allminilm.csv')

# Save as .RData ---------------------------------------------------------------

save.image('../Mixed/homogeneity_study_2.RData')
