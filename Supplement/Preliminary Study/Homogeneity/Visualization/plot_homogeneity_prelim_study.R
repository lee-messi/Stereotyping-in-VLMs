
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 28 Aug 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("ggplot2")){install.packages("ggplot2", dependencies = TRUE); require("ggplot2")}
if(!require("ggsci")){install.packages("ggsci", dependencies = TRUE); require("ggsci")}

# Import dataframes ------------------------------------------------------------

mpnetbase = read.csv("../Cosine/mpnetbase.csv") %>% mutate(cosine = scale(cosine))
distilroberta = read.csv("../Cosine/distilroberta.csv") %>% mutate(cosine = scale(cosine))
allminilm = read.csv("../Cosine/allminilm.csv") %>% mutate(cosine = scale(cosine))

all_models = rbind(mpnetbase, distilroberta, allminilm) %>%
  mutate(model = factor(model, 
                        levels = c("all-mpnet-base-v2", 
                                   "all-distilroberta-v1", 
                                   "all-MiniLM-L12-v2")))

# Interaction plot for all model specifications --------------------------------

ggplot(all_models, aes(x = race, y = cosine, color = race)) + 
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
  labs(x = "Race", 
       y = "Standardized Cosine Similarity") + 
  coord_cartesian(ylim = c(-0.15, 0.15)) +
  facet_grid(cols = vars(model)) + 
  scale_color_jama()

# Save plot
ggsave("../Visualization/homogeneity_prelim_study.pdf", 
       width = 9, height = 4, dpi = "retina")

