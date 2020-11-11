##################################################
## Project: CogNonCog 2018
## Script purpose: Run model with CP UKB and CP Cogent separately 
## Date: August 2020
## Author: Perline Demange 
##################################################

# install.packages("devtools")
# library(devtools)
# install_github("MichelNivard/GenomicSEM")

# GenomicSEM was installed on this machine on the 26/03/2019 
# R version 3.5.2 (office computer)

require(GenomicSEM)
library(data.table)


# Munge summary statistics ######

munge("CP_cleaned_Aysu/CLEANED.UKBCP.txt", "../GSEM_with23andME/Sumstats/w_hm3.noMHC.snplist",
      trait.names="CP_UKB", 222543, info.filter = 0.9, maf.filter = 0.01)
munge("CP_cleaned_Aysu/CLEANED.COGENT.txt", "../GSEM_with23andME/Sumstats/w_hm3.noMHC.snplist",
      trait.names="CP_Cogent", 35298, info.filter = 0.9, maf.filter = 0.01)
munge("../GSEM_with23andME/Sumstats/meta_education_lee_23andMe_adjust_rsid.txt",
      "../GSEM_with23andME/Sumstats/w_hm3.noMHC.snplist",trait.names="EA", 1131883, 
      info.filter = 0.9, maf.filter = 0.01)


# Run multivariate ldsc #####
traits <- c("CP_Cogent.sumstats.gz","CP_UKB.sumstats.gz","EA.sumstats.gz")
sample.prev <- c(NA,NA,NA)
population.prev <- c(NA,NA,NA)
ld<-"C:/Users/PDE430/Documents/CogNonCog/Analyses/GSEM_with23andME/eur_w_ld_chr/"
wld <- "C:/Users/PDE430/Documents/CogNonCog/Analyses/GSEM_with23andME/eur_w_ld_chr/"
trait.names<-c("CP_Cogent","CP_UKB", "EA")
LDSCoutput <- ldsc(traits, sample.prev, population.prev, ld, wld, trait.names)
save(LDSCoutput, file="LDSCoutputCogNonCog_CogentUKB.RData")


model<-'C=~NA*EA + start(0.4)*CP_Cogent + start(0.4)*CP_UKB
NC=~NA*EA
NC~~1*NC
C~~1*C
C~~0*NC
CP_Cogent ~~ 0*EA
CP_UKB ~~ 0*EA
CP_Cogent~~0*CP_Cogent
CP_UKB~~0*CP_UKB
EA~~0*EA'

output<-usermodel(LDSCoutput,estimation="DWLS",model=model)
output
save(output, file="Modeloutput_CogentUKB.Rdata" )

# chisq df      p_chisq      AIC       CFI       SRMR
# df 33.81699  2 4.536625e-08 41.81699 0.9891853 0.04748438


# Normal model from paper (Cp meta-analysis)
# load("../GSEM_with23andMe/Modeloutput_with23andMe.Rdata")
# output


# Run GWAS model with the hits snps from original model #####

# Select only SNPs from EA, CP_Cogent and CP_UKB that are hits from Cog and NonCog GWAS 
# when running the full model with CP  

hitcog <- fread("../GSEM_with23andME/Hits_Manhattan/Cog_23andMe_sig_independent_signals.txt")
hitnoncog <- fread("../GSEM_with23andME/Hits_Manhattan/NonCog_23andMe_sig_independent_signals.txt")
head(hitcog)
head(hitnoncog)
allhits <- rbind(hitcog, hitnoncog)
colnames(allhits) <- c("chrpos", "P")
head(allhits)
hits <- allhits$chrpos

CP_cogent <- fread("CP_Cleaned_Aysu/CLEANED.COGENT.txt") 
CP_UKB <- fread("CP_Cleaned_Aysu/CLEANED.UKBCP.txt") 
head(CP_cogent)
EA <- read.table("../GSEM_with23andME/Sumstats/meta_education_lee_23andMe_adjust_rsid.txt", header=T)
head(EA)

CP_cogent_hitsonly <- CP_cogent[which(CP_cogent$cptid %in% hits),]
CP_UKB_hitsonly <- CP_UKB[which(CP_UKB$cptid %in% hits),] 
EA_hitsonly <- EA[which(EA$CHR.POS %in% hits),]
write.table(CP_cogent_hitsonly, "CP_cogent_hitsonly_20200805.txt", row.names=F)
write.table(CP_UKB_hitsonly, "CP_UKB_hitsonly_20200805.txt", row.names=F)
write.table(EA_hitsonly, "EA_hitsonly_20200805.txt", row.names=F)

## Prep sumstats ###########
# From here this was done on LISA, with R version 3.5.1 (2018-07-02) 
# and GenomicSEM 0.02c (from commit a411c5c)

files = c("CP_cogent_hitsonly_20200805.txt", "CP_UKB_hitsonly_20200805.txt", "EA_hitsonly_20200805.txt")
ref = "reference.1000G.maf.0.005.txt"
trait.names = c("CP_Cogent","CP_UKB", "EA")
se.logit = c(F,F,F)
info.filter = 0.6
maf.filter = 0.01

p_sumstats<-sumstats(files, ref, trait.names, se.logit, info.filter, 
                     maf.filter, OLS=c(T,T,T),linprob=NULL, prop=NULL, 
                     N=c(35298,222543,1131883))
save(p_sumstats, file="Sumstats_CogentUKB.RData")

## Run Model GWAS ####

# Running the Genomic SEM GWAS did not work on my version/environment (after update fo the cluster computer...)
# we could not solve this issue (in short time (might be due to newest version of lavaan being installed on cluster computer that would need to be downdgraded)
# so we ran the GWAS on Michel's local computer 
# This is reported in the script script_sensitvity.R 
# Environment differed (different version of GenomicSEM)
# sensitiviy analyses in the script_sensitivity.R revealed these differences did not matter for the results


# Get sumstats for CP GWAS with hits only #####

# I am getting the sumstats for CP with only the hits so we can run the original model again, 
# with new genomic sem on michel's computer

# on Perline's home computer (R version 3.6.3)
CP <- fread("D:/Documents/CogNonCog/Analyses/GSEM_with23andME/Sumstats/Lee_2018_GWAS_CP_all.txt")
CP$chrpos <- paste(CP$CHR, CP$POS, sep=":")
head(CP)

hitcog <- fread("D:/Documents/CogNonCog/Analyses/GSEM_with23andME/Hits_Manhattan/Cog_23andMe_sig_independent_signals.txt")
hitnoncog <- fread("D:/Documents/CogNonCog/Analyses/GSEM_with23andME/Hits_Manhattan/NonCog_23andMe_sig_independent_signals.txt")
head(hitcog)
head(hitnoncog)
allhits <- rbind(hitcog, hitnoncog)
colnames(allhits) <- c("chrpos", "P")
head(allhits)
hits <- allhits$chrpos

CP_hitsonly <- CP[which(CP$chrpos %in% hits),] 
write.table(CP_hitsonly, "CP_hitsonly_20200805.txt", row.names=F)

# on Lisa: R version 3.5.1 (2018-07-02) and GenomicSEM 0.02c (from commit a411c5c)
files = c("CP_hitsonly_20200805.txt", "EA_hitsonly_20200805.txt")
ref = "reference.1000G.maf.0.005.txt"
trait.names = c("CP", "EA")
se.logit = c(F,F)
info.filter = 0.6
maf.filter = 0.01

p_sumstats<-sumstats(files, ref, trait.names, se.logit, info.filter, maf.filter, OLS=c(T,T),
                     linprob=NULL, prop=NULL, N=c(257828,1131883))
save(p_sumstats, file="Sumstats_CP_onlyhits.RData")

# Gwas for CP with hits only was done on Michel's computer with script_sensitivity.R
# Comparison of the results in script_sensitivity.R 
