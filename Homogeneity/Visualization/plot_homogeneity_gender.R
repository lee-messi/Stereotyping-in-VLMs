
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 25 Aug 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("ggplot2")){install.packages("ggplot2", dependencies = TRUE); require("ggplot2")}
if(!require("ggsci")){install.packages("ggsci", dependencies = TRUE); require("ggsci")}
if(!require("Cairo")){install.packages("Cairo", dependencies = TRUE); require("Cairo")}

# Import data frames -----------------------------------------------------------

load('../Data/Gender/GPT-4v/gpt4v.RData')
load('../Data/Gender/GPT-4o/gpt4o.RData')
load('../Data/Gender/GPT-4o-mini/gpt4omini.RData')

# Define Function --------------------------------------------------------------

new.variables <- function(df, encoder_name){
  df = df %>% 
    mutate(gender = case_when(gender == "male" ~ "Men",
                            gender == "female" ~ "Women")) %>%
    mutate(encoder = encoder_name)
  return(df)
}

# Modify dataframes ------------------------------------------------------------

gpt4v_mpnetbase = new.variables(gpt4v_mpnetbase, "all-mpnet-base-v2")
gpt4v_distilroberta = new.variables(gpt4v_distilroberta, "all-distilroberta-v1")
gpt4v_allminilm = new.variables(gpt4v_allminilm, "all-MiniLM-L12-v2")

gpt4o_mpnetbase = new.variables(gpt4o_mpnetbase, "all-mpnet-base-v2")
gpt4o_distilroberta = new.variables(gpt4o_distilroberta, "all-distilroberta-v1")
gpt4o_allminilm = new.variables(gpt4o_allminilm, "all-MiniLM-L12-v2")

gpt4omini_mpnetbase = new.variables(gpt4omini_mpnetbase, "all-mpnet-base-v2")
gpt4omini_distilroberta = new.variables(gpt4omini_distilroberta, "all-distilroberta-v1")
gpt4omini_allminilm = new.variables(gpt4omini_allminilm, "all-MiniLM-L12-v2")

all_cosines = rbind(gpt4v_mpnetbase, gpt4v_distilroberta, gpt4v_allminilm,
                    gpt4o_mpnetbase, gpt4o_distilroberta, gpt4o_allminilm,
                    gpt4omini_mpnetbase, gpt4omini_distilroberta, gpt4omini_allminilm) %>%
  mutate(encoder = factor(encoder, levels = c("all-mpnet-base-v2", 
                                              "all-distilroberta-v1", 
                                              "all-MiniLM-L12-v2"))) %>%
  mutate(model = factor(model, levels = c("GPT-4V", "GPT-4o", "GPT-4o-mini"))) %>%
  mutate(gender = factor(gender, levels = c("Women", "Men")))

# Interaction plot for all model specifications --------------------------------

ggplot(all_cosines, aes(x = gender, y = cosine, color = gender)) + 
  geom_hline(yintercept = 0.0, linetype = "dashed") + 
  geom_point(stat = "summary", fun = "mean", 
             position = position_dodge(1.0), size = 2) + 
  theme_bw() + 
  theme(legend.position = "none",
        axis.text.x = element_text(size = 10),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size = 12),
        strip.text = element_text(size = 12),
        plot.margin = margin(t = 0, l = 1, r = 1)) + 
  labs(y = "Standardized Cosine Similarity") + 
  coord_cartesian(ylim = c(-0.20, 0.20)) +
  facet_grid(rows = vars(model), cols = vars(encoder)) + 
  scale_color_jama()

# Save plot --------------------------------------------------------------------

ggsave("homogeneity_gender.pdf",width = 9, height = 6, 
       dpi = "retina", device = cairo_pdf)

