##################################################
## Project: CogNonCog 2018
## Script purpose: Run model and GWAS with CP UKB and CP Cogent separately 
## Date: August 2020
## Author: Michel Nivard
##################################################

# Michel's computer: R3.6.2, Lavaan 0.6.7, Genomic SEM  06 August 2020

require(GenomicSEM)

# Rerun the "GWAS" for the hits with cogent as seperate variable ####

#obtained from script Model_Cogent_CP.R
load("~/Desktop/R2 sensitivity/Sumstats_CogentUKB.RData") # contains only hits of original gwasbysub
load("~/Desktop/R2 sensitivity/LDSCoutputCogNonCog_CogentUKB (1).RData")

model<-'C=~NA*EA +start(0.2)*EA + start(0.3)*CP_Cogent + start(0.4)*CP_UKB
NC=~NA*EA +start(0.2)*EA
C~SNP
NC~SNP
NC~~1*NC
C~~1*C
C~~0*NC
CP_Cogent ~~ 0*EA
CP_UKB ~~ 0*EA
CP_Cogent~~0*CP_Cogent
CP_UKB~~0*CP_UKB
EA~~0*EA
SNP~~SNP'

outputGWAS_cogent <-userGWAS(covstruc = LDSCoutput,SNPs = p_sumstats, estimation="DWLS", model=model,GC = "conserv",sub = c("C~SNP","NC~SNP"),SNPSE = 0.0001)

outputGWAS_cogent


# Rerun the "GWAS" for the hits with one CP variable (original CP GWAS) for comparison ####

load("Sumstats_CP_onlyhits.RData")
load("LDSCoutputCogNonCog.RData")

model<-'C=~NA*EA +start(0.2)*EA + start(0.4)*CP
NC=~NA*EA +start(0.2)*EA
C~SNP
NC~SNP
NC~~1*NC
C~~1*C
C~~0*NC
CP ~~ 0*EA
CP~~0*CP
EA~~0*EA
SNP~~SNP'

outputGWAS <-userGWAS(covstruc = LDSCoutput,SNPs = p_sumstats, estimation="DWLS", model=model,GC = "conserv",sub = c("C~SNP","NC~SNP"),SNPSE = 0.0001)

outputGWAS

# Compare results, Supp Fig 13 ####

merge_cog <- merge(outputGWAS[[1]],outputGWAS_cogent[[1]],by = 1)
merge_noncog <- merge(outputGWAS[[2]],outputGWAS_cogent[[2]],by = 1)

par(mfrow=c(1,2))

plot(merge_cog$Z_Estimate.x,merge_cog$Z_Estimate.y,xlab = "Z-stat Current model",ylab = "Z-stat Model with Cogent modeled independently",main="Cog")
abline(0,1,lty="dashed",col="red")

plot(merge_noncog$Z_Estimate.x,merge_noncog$Z_Estimate.y,xlab = "Z-statCurrent model",ylab = "Z-stat Model with Cogent modeled independently",main="NonCog")
abline(0,1,lty="dashed",col="red")

cor(merge_noncog$Z_Estimate.x,merge_noncog$Z_Estimate.y)
cor(merge_cog$Z_Estimate.x,merge_cog$Z_Estimate.y)


# Compare the current GWAS result with previous GWAS output ####
# to confirm changes in compute environment (mac vs linux R 3.6.3 vs 3.4.1) didnt induce changes:


hitscognoncog <- read.delim("hitscognoncog.txt", header=T)

# For NonCog
merge_val_versions <- merge(hitscognoncog,outputGWAS[[2]],by=1)

cog.rsid <- read.table("cog.rsid.txt", quote="\"", comment.char="",stringsAsFactors = F)
ncog.rsid <- read.table("ncog.rsid.txt", quote="\"", comment.char="",stringsAsFactors = F)

plot(merge_val_versions[merge_val_versions$SNP %in% ncog.rsid$V1,]$est.x,merge_val_versions[merge_val_versions$SNP %in%ncog.rsid$V1,]$est.y)
abline(0,1)

### Now for Cog
merge_val_versions <- merge(hitscognoncog,outputGWAS[[1]],by=1)

cog.rsid <- read.table("cog.rsid.txt", quote="\"", comment.char="",stringsAsFactors = F)
ncog.rsid <- read.table("ncog.rsid.txt", quote="\"", comment.char="",stringsAsFactors = F)

plot(merge_val_versions[merge_val_versions$SNP %in% cog.rsid$V1,]$est.x,merge_val_versions[merge_val_versions$SNP %in%cog.rsid$V1,]$est.y)
abline(0,1)



