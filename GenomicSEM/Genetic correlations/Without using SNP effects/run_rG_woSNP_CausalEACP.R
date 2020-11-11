#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
sumstats_list  = as.character(args[1])
outputName = as.character(args[2])


#packages
require(GenomicSEM)
library(data.table)
source("function_rG_woSNP_causalEACP.R")

### Load data ###

data <- read.csv(sumstats_list)
filename <- as.vector(data$Filename)
traitname <- as.vector(data$Trait_name)
totalN <- as.vector(data$N_total)
sampleprev <- data$Sample_prevalence
populationprev <- data$Population_prevalence
casecontrol  <- data$Cases_control
mungefile <- as.vector(data$munge_name)

## Genetic correlations with Genomic SEM

rG_woSNP_results <- NULL
for (i in 1:length(mungefile)) {
  results <- LDSCoutput_rG_woSNP_causalEACP("CP.sumstats.gz","EA.sumstats.gz", mungefile[i], sampleprev[i], populationprev[i], traitname[i])
  rG_woSNP_results <- rbind(rG_woSNP_results, results)  
  }

write.csv(rG_woSNP_results, file=paste(outputName, '.csv', sep=''))