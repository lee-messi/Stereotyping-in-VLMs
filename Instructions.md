# Instructions for Reproducing Analyses
**Last Updated: 28 Aug 2024**

Any difficulties reproducing the analysis, please contact the corresponding author. Note that the author(s) are blinded for submission purposes. 


## Overview of the Repository Folders (in Alphabetical Order)

* Data
     * Data collected using GPT-4o (**GPT-4o**)
     * Data collected using GPT-4o-mini (**GPT-4o-mini**)
     * Data collected using GPT-4V (**GPT-4V**)

- Homogeneity
     - Cosine similarity values calculated from Sentence-BERT models (**Data**)
     - Code used to fit mixed-effects models (**Models**)
     - Code used to fit race-only models (**Race-Only**)
     - Visualization of homogeneity bias (**Visualization**)

* Pre-registration
     * Pre-registration documentation for Preliminary Study (**Pre-Registration for Racial Stereotyping in Multimodal LLMs.docx**)
     * Pre-registration documentation for Study 1 (**Pre-Registration for Study 2 of Racial Stereotyping in Multimodal LLMs.docx**)

- Supplement
     - Code to visualize distribution of femininity ratings (**Femininity**)
     - Pre-registered preliminary study (**Preliminary Study**)

* Traits
     * Chicago Face Database Codebook (**CFD**)
     * Gender trait associations (**Gender**)
     * Race trait associations (**Race**)


### Notes

The *Stimuli* folders are empty as images of the Chicago Face Database (CFD) are not made available in this repository. Access the CFD using the following website: [https://www.chicagofaces.org/](https://www.chicagofaces.org/). 

Note discrepancies in the naming of the pre-registration documents. Pre-registration for the Preliminary Study is named, "Pre-Registration for Racial Stereotyping in Multimodal LLMs.docx", and pre-registration for Study 1 is named, "Pre-Registration for Study 2 of Racial Stereotyping in Multimodal LLMs.docx". These studies were re-ordered and re-named during writing.  


## Data Availability Statement

This repository does not include all data files; Large .csv and .RData files containing cosine similarity measures for homogeneity bias assessment are not made available because of their size (100MB+). However, these files can be reproduced using the provided code. Images of the CFD (Ma et al., 2015) are not made available. 


## Before You Begin: Install the following packages

- R Packages (R version used: 4.4.1). If R is not installed, download [a version of R](https://cran.r-project.org/).
     - tidyverse: https://cran.r-project.org/web/packages/tidyverse/index.html
     - lme4: https://cran.r-project.org/web/packages/lme4/index.html
     - lmerTest: https://cran.r-project.org/web/packages/lmerTest/index.html
     - afex: https://cran.r-project.org/web/packages/afex/index.html
     - emmeans: https://cran.r-project.org/web/packages/emmeans/index.html
     - psych: https://cran.r-project.org/web/packages/psych/index.html
     - readxl: https://cran.r-project.org/web/packages/readxl/index.html
     - stm: https://cran.r-project.org/web/packages/stm/index.html
     - stminsights: https://cran.r-project.org/web/packages/stm/index.html
     - ggsci: https://cran.r-project.org/web/packages/ggsci/index.html
     - reshape2: https://cran.r-project.org/web/packages/reshape2/index.html
     - patchwork: https://cran.r-project.org/web/packages/patchwork/index.html
     - cairo: https://cran.r-project.org/web/packages/Cairo/index.html

* Python Packages (Python version used: 3.11.5). If Python 3 is not installed, download [a version of Python 3](https://www.python.org/downloads/).
     * openai: https://pypi.org/project/openai/
     * numpy: https://pypi.org/project/numpy/
     * pandas: https://pypi.org/project/pandas/
     * requests: https://pypi.org/project/requests/
     * scipy: https://pypi.org/project/scipy/
     * scikit-learn: https://pypi.org/project/scikit-learn/
     * sentence-transformers: https://pypi.org/project/sentence-transformers/


## Workflow for Reproducing Data Collection in Study 1 (Race)

Note that the following workflow for reproducing analyses in Study 1 must be repeated three times - once for each VLM (i.e., GPT-4V, GPT-4o, and GPT-4o-mini). The following workflow is for the GPT-4V model and should happen inside the "GPT-4V/Race" folder. 

### Image Stimuli Selection ("Stimuli")
* Select images from the CFD and store them inside the "Stimuli" folder. 
     - Store all images of Black males with neutral faces inside the "Black" subfolder of the "Stimuli" folder. There should be 93 of them. 
     - Store all images of White males with neutral faces inside the "White" subfolder of the "Stimuli" folder. There should be 93 of them. 

### Data Collection
* Execute `vision_day_1.ipynb` - `vision_day_9.ipynb`. 
     - Enter your OpenAI API Key in the second code block. 
     - This code uses the OpenAI API to generate texts using the writing prompts and the selected image stimuli and saves them as .csv files. Note that given rate limits, you will want to run code in 24 hour intervals. 

* Execute `preprocess.ipynb`. 
     - This code identifies and removes all non-compliances and saves the remaining texts as `study_1.csv`. 

## Workflow for Reproducing Analyses in Study 2 (Gender)

Note that the following workflow for reproducing analyses in Study 1 must be repeated three times - once for each VLM (i.e., GPT-4V, GPT-4o, and GPT-4o-mini). The following workflow is for the GPT-4V model and should happen inside the "GPT-4V/Gender" folder. 

### Image Stimuli Selection ("Stimuli")
* Select images from the Chicago Face Database. 
     - Store all images of White females with neutral faces inside the "Female" subfolder of the "Stimuli" folder. There should be **90** of them. 
     - Store all images of White males with neutral faces inside the "Male" subfolder of the "Stimuli" folder. There should be 93 of them. 

### Data Collection
* Execute `vision_day_1.ipynb` - `vision_day_9.ipynb`. 
     - Enter your OpenAI API Key in the second code block. 
     - This code uses the OpenAI API to generate texts using the writing prompts and the selected image stimuli and saves them as .csv files. Note that given rate limits, you will want to run code in 24 hour intervals. 

* Execute *preprocess.ipynb*. 
     - This code identifies and removes all non-compliances and saves the remaining texts as `study_2.csv`. 

## Workflow for Reproducing Homogeneity Bias Assessment

Note that the following workflow for reproducing homogeneity bias assessment must be repeated six times - twice (Race/Gender) for each VLM (i.e., GPT-4V, GPT-4o, and GPT-4o-mini). The following workflow is for the analysis of Race in the GPT-4V model and should happen inside the "GPT-4V" subfolders of "Data/Race" and "Modes/Race". 

### Convert Texts into Cosine Similarity ("Data")

* Execute `race_gpt4v.ipynb` inside "Data/Race/GPT-4V". 
     - This code encodes the GPT-4V-generated text into sentence embeddings using three Sentence-BERT models, measures their pairwise cosine similarity values, and saves them as `gpt4v_mpnetbase.csv`, `gpt4v_distilroberta.csv`, and `gpt4v_allminilm.csv`. 

* Execute `race_prep.R`. 
     - This code preprocesses the three .csv files (i.e., introduces the mean prototypicality values associated with each cosine similarity measurement) and saves them as an .RData file for easy loading.

### Fit Mixed-Effects Models ("Models")

* Execute `race.R` inside "Models/Race/GPT-4V". 
     - This code fits six mixed-effects models (one *Race and Prototypicality model* and *Interaction model* for each VLM). 

* Execute `race_lrt.R` inside "Models/Race/GPT-4V". 
     - This code conducts likelihood-ratio tests for the Race and Prototypicality terms using the *Race and Prototypicality models* and the interaction term using the *Interaction models*. 

### Visualize Homogeneity Bias ("Visualization")

* Execute `plot_homogeneity_race.R`. 
     - This code visualizes standardized cosine similarity measures from the three Sentence-BERT models for all VLMs and saves it as `homogeneity_race.pdf`. 

* Execute `plot_race_interactions.R`. 
     - This code visualizes standardized cosine similarity measures by mean prototypicality for all VLMs and saves it as `interactions_race.pdf`. 

## Workflow for Reproducing Trait Associations Assessment

The following workflow for reproducing trait associations assessment only needs to be run twice, once for Race and once for Gender. 

### Fit Structural Topic Models ("Traits")
* Execute `race_stm.R` inside the "STM" folder. 
     - Remove names prior to fitting the STM. `extracted_names.csv`, containing names GPT-4V introduced in its generated text, should be inside the folder. 
     - This code preprocesses the GPT-4V-generated text, fits a structural topic model, and saves it as an .RData file for easy loading. This code then fits regression models comparing topic prevalence of all topics. 

### Visualize Trait Associations ("Visualization")

* Execute `race_interactions_stm.R`. 
     - This code visualizes topic prevalence of the two racial groups with respect to prototypicality ratings of the images. 


## Workflow for Reproducing Preliminiary Study

The following are steps to reproduce analyses introduced in the Preliminary Study section of the supplementary materials. Note that this is a smaller version of Study 1 discussed in the main text and uses a random sample of the image stimuli used in Study 1.

### Image Stimuli Selection ("Stimuli")

- Execute `sample_stimuli.R` inside the "Stimuli" folder.
   * This code randomly generates indices of image stimuli for Black and White males. Note that a random seed has been set for reproducibility.
   * Store the randomly sampled images of Black males with neutral faces inside the "Black" subfolder of the "Stimuli" folder.
   * Store the randomly sampled images of White males with neutral faces inside the "White" subfolder of the "Stimuli" folder.

### Data Collection ("Data")

* Execute `vision_day_1.ipynb` - `vision_day_2.ipynb` inside the "Data" folder.
     - Enter your OpenAI API Key in the second code block.
     - This code uses the OpenAI API to generate texts using the writing prompts and the selected image stimuli and saves them as .csv files inside the "Data" folder. Note that given rate limits, you will want to run code in 24-hour intervals.

- Execute `preprocess.ipynb`. 
     * This code identifies and removes all non-compliances and saves the remaining texts as `prelim_study.csv`. 

### Homogeneity Bias Assessment ("Homogeneity")

* Execute `homogeneity_prelim_study.ipynb` inside the "Cosine" subfolder of the "Homogeneity" folder. 
     - This code encodes the GPT-4V-generated text into sentence embeddings using three Sentence-BERT models, measures their pairwise cosine similarity values, and then saves them as `mpnetbase.csv`, `distilroberta.csv`, and `allminilm.csv`. 

* Execute `cosine_prelim_study.R` inside the "Cosine" subfolder of the "Homogeneity" folder. 
     - This code compares cosine similarity values of African and White Americans using independent samples *t*-tests. 

* Execute `plot_homogeneity_prelim_study.R` inside the "Visualization" subfolder of the "Homogeneity" folder. 
     - This code visualizes standardized cosine similarity of the two racial groups and saves it as `homogeneity_prelim_study.pdf`. 

### Assess Trait Associations ("STM")
* Execute `stm_prelim_study.R` inside the "STM" folder. 
     - `extracted_names.csv` should be inside the "STM" folder. The .csv file contains the names GPT-4V introduced in its generated text. 
     - This code preprocesses the GPT-4V-generated text, fits a structural topic model, and saves it as an .RData file for easy loading. This code then fits regression models comparing topic prevalence of all topics between the two racial groups. 


## Workflow for Reproducing Supplementary Analyses

### Visualize Femininity Ratings ("Femininity")

* Execute `femininity_ratings.R`.
     - This code visualizes femininity ratings associated with images of White men and saves it as `femininity_distribution.pdf`. 