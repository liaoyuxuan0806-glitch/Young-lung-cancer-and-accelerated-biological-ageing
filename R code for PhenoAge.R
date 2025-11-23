library(nhanesA)
library(BioAge)
library(haven)
library(tidyverse)
library(dplyr)
library(openxlsx)
library(dplyr)
data<-read.xlsx("bioage_data.xlsx")
#biomarkers_phenoage
biomarkers_phenoage = c("albumin_gL","lymph","mcv","glucose_mmol","rdw","creat_umol","lncrp","alp","wbc")

#phenoage using NHANES
phenoage = phenoage_nhanes(biomarkers_phenoage)

# calculate PhenoAge
data_with_phenoage = data %>%
  phenoage_calc(data = .,         
                biomarkers = biomarkers_phenoage,  
                fit = phenoage$fit, 
                orig = TRUE)         