
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 28 Aug 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("ggsci")){install.packages("ggsci", dependencies = TRUE); require("ggsci")}
if(!require("ggplot2")){install.packages("ggplot2", dependencies = TRUE); require("ggplot2")}
if(!require("ggpubr")){install.packages("ggpubr", dependencies = TRUE); require("ggpubr")}
if(!require("waffle")){install.packages("waffle", dependencies = TRUE); require("waffle")}

# Load generated text ----------------------------------------------------------

data = read.csv('../Data/prelim_study.csv')

# Extract Names ----------------------------------------------------------------

names = read.csv('../STM/extracted_names.csv') %>% pull(names)
names_pattern <- paste(names, collapse = "|")

names_df <- data %>%
  mutate(name = str_extract(text, names_pattern))

# Names of White Americans -----------------------------------------------------

white_names <- names_df %>%
  filter(race == "white") %>%
  count(name) %>%
  arrange(desc(n))

top_white_names <- white_names %>%
  slice_head(n = 4) %>%
  mutate(proportion = n / sum(white_names$n),
         adjusted_count = round(proportion * 100))

others <- sum(white_names$n) - sum(top_white_names$n)
total_n <- sum(white_names$n)
others_proportion <- others / total_n
others_adjusted_count <- round(others_proportion * 100)

others_df <- data.frame(
  name = "Others",
  n = others,
  proportion = others_proportion,
  adjusted_count = others_adjusted_count
)

final_white_names <- rbind(top_white_names, others_df)
final_white_names$name <- factor(final_white_names$name, levels = c(as.character(top_white_names$name), "Others"))

waffle_white <- ggplot(final_white_names, aes(fill = name, values = adjusted_count)) +
  geom_waffle(n_rows = 10, size = 0.33, color = "white") + 
  theme_void() +
  scale_fill_grey(start = 0.35, end = 0.85) + 
  theme(legend.position = "bottom",
        legend.title = element_blank(), 
        legend.text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5)) + 
  labs(title = "White Americans")

# Names of African Americans ---------------------------------------------------

black_names <- names_df %>%
  filter(race == "black") %>%
  count(name) %>%
  arrange(desc(n))

top_black_names <- black_names %>%
  slice_head(n = 4) %>%
  mutate(proportion = n / sum(black_names$n),
         adjusted_count = round(proportion * 100))

others <- sum(black_names$n) - sum(top_black_names$n)
total_n <- sum(black_names$n)
others_proportion <- others / total_n
others_adjusted_count <- round(others_proportion * 100)

others_df <- data.frame(
  name = "Others",
  n = others,
  proportion = others_proportion,
  adjusted_count = others_adjusted_count
)

final_black_names <- rbind(top_black_names, others_df)
final_black_names$name <- factor(final_black_names$name, levels = c(as.character(top_black_names$name), "Others"))

# Plot
waffle_black <- ggplot(final_black_names, aes(fill = name, values = adjusted_count)) +
  geom_waffle(n_rows = 10, size = 0.33, color = "white") + 
  theme_void() +
  scale_fill_grey(start = 0.35, end = 0.85) + 
  theme(legend.position = "bottom",
        legend.title = element_blank(), 
        legend.text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5)) + 
  labs(title = "African Americans")

ggarrange(waffle_black, waffle_white, nrow = 1)
ggsave('names_study_1.pdf', width = 9, height = 4.8, dpi = "retina")

