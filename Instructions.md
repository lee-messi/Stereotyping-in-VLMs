# Instructions for Reproducing Analyses
**Last Updated: 6 May 2024**

Any difficulties reproducing the analysis, please contact the corresponding author. 


## Overview of the Repository Folders (in Alphabetical Order)

* CFD
     * Codebook of the Chicago Face Database (**CFD.xlsx**)

- Pre-registration
     - Pre-registration documentation for Preliminary Study (**Pre-Registration for Racial Stereotyping in Multimodal LLMs.docx**)
     - Pre-registration documentation for Study 1 (**Pre-Registration for Study 2 of Racial Stereotyping in Multimodal LLMs.docx**)

* Preliminary Study
     * Folder containing GPT-4V-generated text (**Data**)
     * Folder containing code used to assess homogeneity bias (**Homogeneity**)
     * Folder containing code used to compare frequency of names (**Names**)
     * Folder containing the image stimuli (**Stimuli**)
     * Folder containing code used to assess trait associations (**STM**)

- Study 1
     - Folder containing GPT-4V-generated text (**Data**)
     - Folder containing code used to assess homogeneity bias (**Homogeneity**)
     - Folder containing code used to compare frequency of names (**Names**)
     * Folder containing the image stimuli (**Stimuli**)
     - Folder containing code used to assess trait associations (**STM**)

* Study 2
     * Folder containing GPT-4V-generated text (**Data**)
     * Folder containing code used to assess homogeneity bias (**Homogeneity**)
     * Folder containing code used to compare frequency of names (**Names**)
     * Folder containing the image stimuli (**Stimuli**)
     * Folder containing code used to assess trait associations (**STM**)

- Supplement
     - Code to visualize distribution of femininity ratings (**Femininity_Ratings.R**)
     - Image file visualizing distribution of femininity ratings (**femininity_distribution.pdf**)

### Notes

The *Stimuli* subfolders inside "Study 1" and "Study 2" folders are not visible as image files from the Chicago Face Database are not made available on this repository. Follow the workflow outlined below to create the *Stimuli* subfolders and to store relevant image files in the right locations. 

Note discrepancies in the naming of the pre-registration documents. Pre-registration for the Preliminary Study is named, "Pre-Registration for Racial Stereotyping in Multimodal LLMs.docx", and pre-registration for Study 1 is named, "Pre-Registration for Study 2 of Racial Stereotyping in Multimodal LLMs.docx". These studies were re-organized and re-named after data collection. 


## Data Availability Statement

This repository does not include all data files: Large (100MB+) .csv and .RData files containing cosine similarity measures for homogeneity bias assessment are not made available, but they can be reproduced using the provided code. Image files from the Chicago Face Databse (Ma et al., 2015) are not made available. These files can be obtained from [the Chicago Face Database website](https://www.chicagofaces.org/).

## Before You Begin: Install the following packages

- R Packages (R version used: 4.3.1). If R is not installed, download [a version of R](https://cran.r-project.org/).
     - tidyverse: https://cran.r-project.org/web/packages/tidyverse/index.html
     - text: https://cran.r-project.org/web/packages/text/index.html
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

* Python Packages (Python version used: 3.11.5). If Python 3 is not installed, download [a version of Python 3](https://www.python.org/downloads/).
     * openai: https://pypi.org/project/openai/
     * numpy: https://pypi.org/project/numpy/
     * pandas: https://pypi.org/project/pandas/
     * requests: https://pypi.org/project/requests/
     * scipy: https://pypi.org/project/scipy/
     * scikit-learn: https://pypi.org/project/scikit-learn/
     * sentence-transformers: https://pypi.org/project/sentence-transformers/


## Workflow for Reproducing Analyses in Preliminary Study ("Preliminary Study" Folder)

### **Image Stimuli Selection ("Stimuli" Folder)**
* Execute *sample_stimuli.R* inside the "Stimuli" folder. 
     - This code randomly samples 20 images each for Black and White males. 
     - Store the randomly sampled images of Black males with neutral faces inside the "Black" subfolder of the "Stimuli" folder. 
     - Store the randomly sampled images of White males with neutral faces inside the "White" subfolder of the "Stimuli" folder. 

### **Data Collection ("Data" Folder)**
* Execute *vision_day_1.ipynb* - *vision_day_2.ipynb* inside the "Data" folder. 
     - Enter your OpenAI API Key in the second code block. 
     - This code uses the OpenAI API to generate texts using the writing prompts and the selected image stimuli and saves them as .csv files inside the "Data" folder. Note that given rate limits, you will want to run code in 24 hour intervals. 

* Execute *preprocess.ipynb*. 
     - This code identifies and removes all non-compliances and saves the remaining texts as *prelim_study.csv*. 

### **Assess Homogeneity Bias ("Homogeneity" Folder)**

* Execute *homogeneity_prelim_study.ipynb* inside the "Cosine" subfolder of the "Homogeneity" folder. 
     - This code encodes the GPT-4V-generated text into sentence embeddings using three Sentence-BERT models, measures their pairwise cosine similarity values, and then saves them as *mpnetbase.csv*, *distilroberta.csv*, and *allminilm.csv*. 

* Execute *cosine_prelim_study.R* inside the "Cosine" subfolder of the "Homogeneity" folder. 
     - This code compares cosine similarity values of African and White Americans using independent samples *t*-tests. 

* Execute *plot_homogeneity_prelim_study.R* inside the "Visualization" subfolder of the "Homogeneity" folder. 
     - This code visualizes standardized cosine similarity measures of the two racial groups from the three Sentence-BERT models and saves it as *homogeneity_prelim_study.pdf*. 

### **Assess Trait Associations ("STM" Folder)**
* Execute *stm_prelim_study.R* inside the "STM" folder. 
     - *extracted_names.csv* should be inside the "STM" folder. The .csv file contains the names GPT-4V introduced in its generated text. 
     - This code preprocesses the GPT-4V-generated text, fits a structural topic model, and saves it as an .RData file for easy loading. This code then fits regression models comparing topic prevalence of all topics between the two racial groups. 


## Workflow for Reproducing Analyses in Study 1 

### **Image Stimuli Selection ("Stimuli" Folder)**
* Select images from the Chicago Face Database. 
     - Store all images of Black males with neutral faces inside the "Black" subfolder of the "Stimuli" folder. There should be 93 of them. 
     - Store all images of White males with neutral faces inside the "White" subfolder of the "Stimuli" folder. There should be 93 of them. 

### **Data Collection ("Data" Folder)**
* Execute *vision_day_1.ipynb* - *vision_day_9.ipynb* inside the "Data" folder. 
     - Enter your OpenAI API Key in the second code block. 
     - This code uses the OpenAI API to generate texts using the writing prompts and the selected image stimuli and saves them as .csv files inside the "Data" folder. Note that given rate limits, you will want to run code in 24 hour intervals. 

* Execute *preprocess.ipynb*. 
     - This code identifies and removes all non-compliances and saves the remaining texts as *study_1.csv*. 


### **Assess Homogeneity Bias ("Homogeneity" Folder)**
* Execute *homogeneity_study_1.ipynb* inside the "Cosine" subfolder of the "Homogeneity" folder. 
     - This code encodes the GPT-4V-generated text into sentence embeddings using three Sentence-BERT models, measures their pairwise cosine similarity values, and then saves them as *mpnetbase.csv*, *distilroberta.csv*, and *allminilm.csv*. 

* Execute *prepare_study_1.R* inside the "Mixed" subfolder of the "Homogeneity" folder. 
     - This code preprocesses the three .csv files (i.e., introduces the prototypicality values) and saves them as an .RData file for easy loading.

* Execute *mixed_study_1.R* inside the "Mixed" subfolder of the "Homogeneity" folder.
     - This code fits mixed-effects models (*Race and Prototypicality models* and *Interaction models*). 

* Execute *lrt_study_1.R* inside the "Mixed" subfolder of the "Homogeneity" folder.
     - This code conducts likelihood-ratio tests. 

* Execute *power_study_1.R* inside the "Mixed" subfolder of the "Homogeneity" folder. 
     - This code conducts power analysis for Study 1. 

* Execute *race_only_study_1.R* inside the "Mixed" subfolder of the "Homogeneity" folder. 
     - This code fits mixed-effects models where race is the only fixed effect (*Race-only models*). 

* Execute *plot_homogeneity_study_1.R* inside the "Visualization" subfolder of the "Homogeneity" folder. 
     - This code visualizes standardized cosine similarity measures of the two racial groups from the three Sentence-BERT models and saves it as *homogeneity_study_1.pdf*. 

* Execute *plot_homogeneity_interactions_study_1.R* inside the "Visualization" subfolder of the "Homogeneity" folder. 
     - This code visualizes standardized cosine similarity measures of the two racial groups by mean prototypicality and saves it as *homogeneity_interactions_study_1.pdf*. 


### **Assess Trait Associations ("STM" Folder)**
* Execute *stm_study_1.R* inside the "STM" folder. 
     - *extracted_names.csv* should be inside the "STM" folder. The .csv file contains the names GPT-4V introduced in its generated text. 
     - This code preprocesses the GPT-4V-generated text, fits a structural topic model, and saves it as an .RData file for easy loading. This code then fits regression models comparing topic prevalence of all topics betweenthe two racial groups. 

* Execute *plot_interactions_study_1.R* inside the "Visualization" subfolder of the "STM" folder. 
     - This code visualizes topic prevalence of the two racial groups with respect to prototypicality ratings of the images. 


## Workflow for Reproducing Analyses in Study 2

### **Image Stimuli Selection (*Stimuli* Folder)**
* Select images from the Chicago Face Database. 
     - Store all images of White females with neutral faces inside the "Female" subfolder of the "Stimuli" folder. There should be **90** of them. 
     - Store all images of White males with neutral faces inside the "Male" subfolder of the "Stimuli" folder. There should be 93 of them. 

### **Data Collection ("Data" Folder)**
* Execute *vision_day_1.ipynb* - *vision_day_9.ipynb* inside the "Data" folder. 
     - Enter your OpenAI API Key in the second code block. 
     - This code uses the OpenAI API to generate texts using the writing prompts and the selected image stimuli and saves them as .csv files inside the "Data" folder. Note that given rate limits, you will want to run code in 24 hour intervals. 

* Execute *preprocess.ipynb*. 
     - This code identifies and removes all non-compliances and saves the remaining texts as *study_2.csv*. 

### **Assess Homogeneity Bias ("Homogeneity" Folder)**
* Execute *homogeneity_study_2.ipynb* inside the "Cosine" subfolder of the "Homogeneity" folder. 
     - This code encodes the GPT-4V-generated text into sentence embeddings using three Sentence-BERT models, measures their pairwise cosine similarity values, and then saves them as *mpnetbase.csv*, *distilroberta.csv*, and *allminilm.csv*. 

* Execute *prepare_study_2.R* inside the "Mixed" subfolder of the "Homogeneity" folder. 
     - This code preprocesses the three .csv files (i.e., introduces the prototypicality values) and saves them as an .RData file for easy loading.

* Execute *mixed_study_2.R* inside the "Mixed" subfolder of the "Homogeneity" folder.
     - This code fits mixed-effects models (*Gender and Prototypicality models* and *Interaction models*). 

* Execute *lrt_study_2.R* inside the "Mixed" subfolder of the "Homogeneity" folder.
     - This code conducts likelihood-ratio tests. 

* Execute *power_study_2.R* inside the "Mixed" subfolder of the "Homogeneity" folder. 
     - This code conducts power analysis for Study 2. 

* Execute *gender_only_study_2.R* inside the "Mixed" subfolder of the "Homogeneity" folder. 
     - This code fits mixed-effects models where gender is the only fixed effect (*Gender-only models*). 

* Execute *plot_homogeneity_study_2.R* inside the "Visualization" subfolder of the "Homogeneity" folder. 
     - This code visualizes standardized cosine similarity measures of the two gender groups from the three Sentence-BERT models and saves it as *homogeneity_study_2.pdf*. 

* Execute *plot_homogeneity_interactions_study_2.R* inside the "Visualization" subfolder of the "Homogeneity" folder. 
     - This code visualizes standardized cosine similarity measures of the two gender groups by mean prototypicality and saves it as *homogeneity_interactions_study_2.pdf*. 


### **Assess Homogeneity Bias w.r.t. Perceived Femininity ("Femininity" Folder)**
* Execute *prepare_study_2_femininity.R* inside the "Femininity" subfolder of the "Homogeneity" folder. 
     - This code preprocesses the three .csv files (i.e., introduces the femininity values) and saves them as an .RData file for easy loading.

* Execute *mixed_study_2_femininity.R* inside the "Femininity" subfolder of the "Homogeneity" folder.
     - This code fits mixed-effects models (*Gender and Femininity models* and *Interaction models*). 

* Execute *lrt_study_2_femininity.R* inside the "Femininity" subfolder of the "Homogeneity" folder.
     - This code conducts likelihood-ratio tests. 


> **Assess Trait Associations ("STM" Folder)**
* Execute *stm_study_2.R* inside the "STM" folder. 
     - *extracted_names.csv* should be inside the "STM" folder. The .csv file contains the names GPT-4V introduced in its generated text. 
     - This code preprocesses the GPT-4V-generated text, fits a structural topic model, and saves it as an .RData file for easy loading. This code then fits regression models comparing topic prevalence of all topics between the two gender groups. 

* Execute *plot_interactions_study_2.R* inside the "Visualization" subfolder of the "STM" folder. 
     - This code visualizes topic prevalence of the two gender groups with respect to prototypicality ratings of the images and saves it as *stm_interactions_study_2.pdf*.


### **Assess Trait Associations w.r.t. Perceived Femininity ("STM" Folder)**
* Execute *stm_study_2_femininity.R* inside the "STM" folder. 
     - *extracted_names.csv* should be inside the "STM" folder. The .csv file contains the names GPT-4V introduced in its generated text. 
     - This code preprocesses the GPT-4V-generated text, fits a structural topic model, and saves it as an .RData file for easy loading. This code then fits regression models comparing topic prevalence of all topics between the two gender groups. 

* Execute *plot_interactions_study_2.R* inside the "Femininity Visualization" subfolder of the "STM" folder. 
     - This code visualizes topic prevalence of the two gender groups with respect to femininity ratings of the images and saves it as *stm_interactions_study_2_femininity.pdf*.
