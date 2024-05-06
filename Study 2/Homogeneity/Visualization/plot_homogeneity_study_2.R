
## Anonymous
# Racial Stereotyping in Large Multimodal Models

## Script date: 19 Apr 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("ggplot2")){install.packages("ggplot2", dependencies = TRUE); require("ggplot2")}
if(!require("ggsci")){install.packages("ggsci", dependencies = TRUE); require("ggsci")}

# Import data frames -----------------------------------------------------------

mpnetbase = read.csv("../Cosine/mpnetbase.csv") %>%
  mutate(cosine = scale(cosine_similarity)) %>% 
  mutate(gender = case_when(
    gender ==  "female" ~ "Women",
    gender ==  "male" ~ "Men"
  )) %>%
  mutate(model = "all-mpnet-base-v2")

distilroberta = read.csv("../Cosine/distilroberta.csv") %>% 
  mutate(cosine = scale(cosine_similarity)) %>% 
  mutate(gender = case_when(
    gender ==  "female" ~ "Women",
    gender ==  "male" ~ "Men"
  )) %>%
  mutate(model = "all-distilroberta-v1")

allminilm = read.csv("../Cosine/allminilm.csv") %>% 
  mutate(cosine = scale(cosine_similarity)) %>% 
  mutate(gender = case_when(
    gender ==  "female" ~ "Women",
    gender ==  "male" ~ "Men"
  )) %>%
  mutate(model = "all-MiniLM-L12-v2")

all_models = rbind(mpnetbase, distilroberta, allminilm) %>%
  mutate(model = factor(model, 
                        levels = c("all-mpnet-base-v2", 
                                   "all-distilroberta-v1", 
                                   "all-MiniLM-L12-v2")))

# Interaction plot for all model specifications --------------------------------

ggplot(all_models, aes(x = gender, y = cosine, color = gender)) + 
  geom_hline(yintercept = 0.0, linetype = "dashed") + 
  geom_point(stat = "summary", fun = "mean", 
             position = position_dodge(1.0), size = 2) + 
  theme_bw() + 
  theme(legend.position = "none",
        axis.text.x = element_text(size = 10),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size = 12),
        strip.text.x = element_text(size = 12),
        plot.margin = margin(t = 0, l = 1, r = 1)) + 
  labs(x = "Gender", 
       y = "Standardized Cosine Similarity") + 
  coord_cartesian(ylim = c(-0.15, 0.15)) +
  facet_grid(cols = vars(model)) + 
  scale_color_jama()

# Save plot
ggsave("../Visualization/homogeneity_study_2.pdf", 
       width = 9, height = 4, dpi = "retina")

