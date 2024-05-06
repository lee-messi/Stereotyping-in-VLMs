
## Anonymous
# Racial Stereotyping in Large Multimodal Models

## Script date: 19 Apr 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("ggplot2")){install.packages("ggplot2", dependencies = TRUE); require("ggplot2")}
if(!require("ggsci")){install.packages("ggsci", dependencies = TRUE); require("ggsci")}

# Import data frames -----------------------------------------------------------

load('../Femininity/homogeneity_study_2_femininity.RData')

mpnetbase <- mpnetbase %>% mutate(model = "all-mpnet-base-v2")
distilroberta <- distilroberta %>% mutate(model = "all-distilroberta-v1")
allminilm <- allminilm %>% mutate(model = "all-MiniLM-L12-v2")

all_models = rbind(mpnetbase, distilroberta, allminilm) %>%
  mutate(model = factor(model, 
                        levels = c("all-mpnet-base-v2", 
                                   "all-distilroberta-v1", 
                                   "all-MiniLM-L12-v2"))) %>% 
  mutate(gender = case_when(
    gender == "female" ~ "Women",
    gender == "male" ~ "Men"
  ))

# Interaction plot for all model specifications --------------------------------

ggplot(all_models, aes(x = fem, y = cosine, group = gender, color = gender)) + 
  geom_smooth(method = "lm") +
  theme_bw() + 
  labs(y = "Standardized Cosine Similarity", 
       x = "Mean Femininity Rating") + 
  theme(legend.position = "top",
        legend.title = element_blank(),
        legend.text = element_text(size = 12),
        axis.text.x = element_text(size = 12),
        axis.title.x = element_text(size = 12),
        axis.title.y = element_text(size = 12),
        strip.text.x = element_text(size = 12),
        plot.margin = margin(t = 0, l = 1, r = 1)) + 
  coord_cartesian(ylim = c(-0.75, 0.75)) + 
  facet_grid(cols = vars(model)) + 
  scale_color_jama()

# Save plot
ggsave("../Visualization/homogeneity_interactions_study_2_femininity.pdf", 
       width = 9, height = 4, dpi = "retina")

