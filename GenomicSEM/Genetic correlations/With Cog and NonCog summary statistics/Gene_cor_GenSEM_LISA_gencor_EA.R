#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
sumstats_list  = as.character(args[1])
outputName = as.character(args[2])
mungefileName = as.character(args[3])

#packages
library(devtools)
require(GenomicSEM)
library(data.table)
source("gencor_EA_function.R")

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

gencor_results <- NULL
for (i in 1:length(mungefile)) {
  results <- CogNoncog_gen_correlation_EA("EA.sumstats.gz", mungefile[i], sampleprev[i], populationprev[i], traitname[i])
  gencor_results <- rbind(gencor_results, results)  
}

write.csv(gencor_results, file=paste(outputName,'_EA', '.csv', sep=''))