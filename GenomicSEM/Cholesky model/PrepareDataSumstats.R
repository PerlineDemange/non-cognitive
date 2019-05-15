##################################################
## Project: CogNonCog 2018
## Script purpose: Prepare the summary statistics to be used by GSEM (Step 1 and 2)
## With the metanalysed 23andMe+lee eduyears GWAS and CP (lee et al)
## https://github.com/MichelNivard/GenomicSEM/wiki/5.-User-Specified-Models-with-SNP-Effects
## Date: March 2019
## Author: Perline Demange 
##################################################

require(GenomicSEM)

files = c("Lee_2018_GWAS_CP_all.txt", "meta_education_lee_23andMe_adjust_rsid.txt")
ref = "reference.1000G.maf.0.005.txt"
trait.names = c("CP","EA")
se.logit = c(F,F)
info.filter = 0.6
maf.filter = 0.01

p_sumstats<-sumstats(files, ref, trait.names, se.logit, info.filter, maf.filter, OLS=c(T,T),linprob=NULL, prop=NULL, N=c(257828,1131883))
save(p_sumstats, file="Sumstats.RData")

