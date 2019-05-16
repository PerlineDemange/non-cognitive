##################################################
## Project: CogNonCog 2018
## Script purpose: Munge the statistics and run the  multivariable LDSC (Step 1 and 2)
## With the metanalysed 23andMe+lee eduyears GWAS and CP (lee et al)
## https://github.com/MichelNivard/GenomicSEM/wiki/3.-Models-without-Individual-SNP-effects
## Date: March 2019
## Author: Perline Demange 
##################################################

# install.packages("devtools")
# library(devtools)
# install_github("MichelNivard/GenomicSEM")
# GenomicSEM was installed on this machine on the 26/03/2019 

require(GenomicSEM)

setwd("D:/Documents/CogNonCog/Analyses/GSEM_with23andME")


#####################
## Munge summary statistics 
munge("Sumstats/Lee_2018_GWAS_CP_all.txt", "Sumstats/w_hm3.noMHC.snplist",trait.names="CP", 257828, info.filter = 0.9, maf.filter = 0.01)
munge("Sumstats/meta_education_lee_23andMe_adjust_rsid.txt", "Sumstats/w_hm3.noMHC.snplist",trait.names="EA", 1131883, info.filter = 0.9, maf.filter = 0.01)


# run multivariate ldsc
traits <- c("CP.sumstats.gz","EA.sumstats.gz")
sample.prev <- c(NA,NA)
population.prev <- c(NA,NA)
ld<-"eur_w_ld_chr/"
wld <- "eur_w_ld_chr/"
trait.names<-c("CP", "EA")
LDSCoutput <- ldsc(traits, sample.prev, population.prev, ld, wld, trait.names)
save(LDSCoutput, file="LDSCoutputCogNonCog.RData")
