### R script to run genetic cor with genomic SEM on lisa
### Infos on the method https://github.com/MichelNivard/GenomicSEM/wiki/


#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
sumstats_list  = as.character(args[1])
outputName = as.character(args[2])

#packages
library(devtools)
require(GenomicSEM)
library(data.table)

### Load data ###

data <- read.csv(sumstats_list)
filename <- as.vector(data$Filename)
traitname <- as.vector(data$Trait_name)
totalN <- as.vector(data$N_total)
sampleprev <- data$Sample_prevalence
populationprev <- data$Population_prevalence
casecontrol  <- data$Cases_control

# Munge Cog and NoCog
#munge(c("C:/Users/PDE430/Documents/CogNonCog/Analyses/New/Cognitive_GWAS_short_New.txt","C:/Users/PDE430/Documents/CogNonCog/Analyses/New/Non_Cognitive_GWAS_short_New.txt"), "C:/Users/PDE430/Documents/CogNonCog/Summarystatistics/w_hm3.noMHC.snplist",trait.names=c("C","NC"), c(257700, 510795), info.filter = 0.9, maf.filter = 0.01)

## Munge loop
mungefile = NULL
for (i in 1:length(filename)) { 
  munge(filename[i], "w_hm3.noMHC.snplist",trait.names=traitname[i], totalN[i], info.filter = 0.9, maf.filter = 0.01)
  mungedname <- paste(traitname[i], ".sumstats.gz", sep="")
  mungefile <- c(mungefile, mungedname)
} 
saveRDS(mungefile, file=paste(outputName, '.Rda', sep=''))

