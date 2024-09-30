
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 5 Sept 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("stm")){install.packages("stm", dependencies = TRUE); require("stm")}
if(!require("ggsci")){install.packages("ggsci", dependencies = TRUE); require("ggsci")}
if(!require("stminsights")){install.packages("stminsights", dependencies = TRUE); require("stminsights")}
if(!require("patchwork")){install.packages("patchwork", dependencies = TRUE); require("patchwork")}
if(!require("Cairo")){install.packages("Cairo", dependencies = TRUE); require("Cairo")}

# Load .RData file -------------------------------------------------------------

load('../race_stm.RData')

# Plot interaction effect ------------------------------------------------------

plot.int <- function(topic_number, topic_label){
  
  formula_str <- paste("c(", topic_number, ") ~ race * proto * model")
  formula_obj <- as.formula(formula_str)
  
  effect_estimate = estimateEffect(formula_obj, fit, metadata = meta)
  
  effects_int <- get_effects(estimates = effect_estimate,
                             variable = 'proto',
                             type = 'continuous',
                             moderator = 'race',
                             modval = 'white') %>%
    bind_rows(
      get_effects(estimates = effect_estimate,
                  variable = 'proto',
                  type = 'continuous',
                  moderator = 'race',
                  modval = 'black')
    )
  
  # plot interaction effects
  plot = effects_int %>% 
    mutate(moderator = as.factor(moderator)) %>% 
    mutate(moderator = case_when(
      moderator == "black" ~ "African Americans",
      moderator == "white" ~ "White Americans"
    )) %>%
    ggplot(aes(x = value, y = proportion, color = moderator,
               group = moderator, fill = moderator)) +
    geom_line() +
    geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.2) + 
    labs(title = topic_label, x = 'Prototypicality', y = 'Topic Proportion', 
         color = 'Race', group = 'Race', fill = 'Race') + 
    theme_bw() + 
    theme(plot.title = element_text(size = 12, hjust = 0.5), 
          legend.position = 'none') + 
    scale_fill_jama() + 
    scale_color_jama()
  
  return(plot)
  
}

topic.1.int <- plot.int(1, "Community")
topic.2.int <- plot.int(2, "Astronomy")
topic.3.int <- plot.int(3, "Art")
topic.4.int <- plot.int(4, "Music")
topic.5.int <- plot.int(5, "Software Development")
topic.6.int <- plot.int(6, "Reading")
topic.7.int <- plot.int(7, "Resilience")
topic.8.int <- plot.int(8, "Cooking")

plot_grid <- topic.1.int + topic.2.int + topic.3.int + topic.4.int + 
  topic.5.int + topic.6.int + topic.7.int + topic.8.int +
  plot_layout(ncol = 4, nrow = 2, axis_titles = "collect", guides = "collect") & 
  labs(y = 'Topic Proportion') & 
  theme(legend.position = "bottom", 
        axis.title.y = element_text(size = 12),
        axis.title.x = element_text(size = 12),
        legend.text = element_text(size = 12), 
        legend.title = element_blank())

# Save plot --------------------------------------------------------------------

ggsave("stm_interactions_race.pdf", width = 10, height = 6, 
       dpi = "retina", device = cairo_pdf)

