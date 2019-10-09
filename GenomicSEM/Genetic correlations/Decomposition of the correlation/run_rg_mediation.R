#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
sumstats_list  = as.character(args[1])
outputName = as.character(args[2])
mungefileName = as.character(args[3])

#packages
require(GenomicSEM)
library(data.table)
source("function_rG_mediation.R")

### Load data ###

data <- read.csv(sumstats_list)
filename <- as.vector(data$Filename)
traitname <- as.vector(data$Trait_name)
totalN <- as.vector(data$N_total)
sampleprev <- data$Sample_prevalence
populationprev <- data$Population_prevalence
casecontrol  <- data$Cases_control
mungefile <- readRDS(mungefileName)

## Genetic correlations with Genomic SEM

rG_mediation_results <- NULL
for (i in 1:length(mungefile)) {
  results <- LDSCoutput_rG_mediation("CP.sumstats.gz","EA.sumstats.gz", mungefile[i], sampleprev[i], populationprev[i], traitname[i])
  rG_mediation_results <- rbind(rG_woSNP_results, results)  
}

write.csv(rG_mediation_results, file=paste(outputName, '.csv', sep=''))