
## Anonymous
# Prototypicality Affects Stereotyping in Vision-Language Models

## Script date: 28 Aug 2024

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("readxl")){install.packages("readxl", dependencies = TRUE); require("readxl")}
if(!require("ggplot2")){install.packages("ggplot2", dependencies = TRUE); require("ggplot2")}
if(!require("ggsci")){install.packages("ggsci", dependencies = TRUE); require("ggsci")}
if(!require("Cairo")){install.packages("Cairo", dependencies = TRUE); require("Cairo")}

# Load CFD codebook ------------------------------------------------------------

cfd <- read_excel('CFD/CFD.xlsx', 'CFD U.S. Norming Data')
column.names <- cfd[7,]
cfd <- cfd[8:nrow(cfd),]
colnames(cfd) <- column.names
cfd <- cfd[2:nrow(cfd),]

# Filter Dataset ---------------------------------------------------------------

white_men = cfd %>% 
  select(c(Model, Feminine)) %>%
  filter(substr(Model, 1, 2) == "WM") %>%
  mutate(Feminine = as.numeric(Feminine))

# Interaction plot for all model specifications --------------------------------

ggplot(white_men, aes(x = Feminine)) +
  geom_histogram(bins = 30, fill = "#374E5599", color = "#374E55FF") +  # Set binwidth appropriately
  scale_x_continuous(limits = c(1, 7)) +
  xlab("Femininity Rating") +
  ylab("Frequency") +
  theme(axis.text.x = element_text(size = 12),
        axis.title.x = element_text(size = 12),
        axis.title.y = element_text(size = 12),
        strip.text.x = element_text(size = 12),
        plot.margin = margin(t = 0, l = 1, r = 1)) +
  theme_bw()

# Save plot --------------------------------------------------------------------

ggsave("femininity_distribution.pdf", width = 9, height = 5, 
       dpi = "retina", device = cairo_pdf)

