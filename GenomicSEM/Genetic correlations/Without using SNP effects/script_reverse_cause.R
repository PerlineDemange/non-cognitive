##################################################
## Project: CogNonCog 2018
## Script purpose: Run model and GWAS with EA->CP 
## Date: August 2020
## Author: Michel Nivard
##################################################

#Michel's computer: R3.6.2, Lavaan 0.6.7, Genomic SEM  06 August 2020

require(GenomicSEM)

### Rerun the "GWAS" for the hits with the model with causal EA-CP

#obtained from script Model_Cogent_CP.R
load("Sumstats_CP_onlyhits.RData")
load("LDSCoutputCogNonCog.RData")


model<-'C=~NA*EA +start(0.2)*EA + start(0.4)*CP
NC=~NA*EA +start(0.2)*EA
NC~~1*NC
C~~1*C
C~~0*NC
CP ~ 0.2*EA
CP~~0*CP
EA~~0*EA'


model_recause <- usermodel(covstruc = LDSCoutput,estimation = "DWLS",model = model)
model_recause

model<-'C=~NA*EA +start(0.2)*EA + start(0.4)*CP
NC=~NA*EA +start(0.2)*EA
C~SNP
NC~SNP
NC~~1*NC
C~~1*C
C~~0*NC
CP ~ 0.2*EA
CP~~0*CP
EA~~0*EA
SNP~~SNP'



outputGWAS2 <-userGWAS(covstruc = LDSCoutput,SNPs = p_sumstats, estimation="DWLS", model=model,GC = "conserv",sub = c("C~SNP","NC~SNP"),SNPSE = 0.0001)


outputGWAS2



merge_cog2 <- merge(outputGWAS[[1]],outputGWAS2[[1]],by = 1)
merge_noncog2 <- merge(outputGWAS[[2]],outputGWAS2[[2]],by = 1)


cog.rsid <- read.table("cog.rsid.txt", quote="\"", comment.char="",stringsAsFactors = F)
ncog.rsid <- read.table("ncog.rsid.txt", quote="\"", comment.char="",stringsAsFactors = F)

par(mfrow=c(1,2))
plot(merge_noncog2[merge_noncog2$SNP %in% ncog.rsid$V1,]$Z_Estimate.x,merge_noncog2[merge_noncog2$SNP %in% ncog.rsid$V1,]$Z_Estimate.y,xlab="NonCog GWAS hits",ylab="NonCog GWAS hits in presence of small reverse causal effect")
plot(merge_cog2[merge_cog2$SNP %in% cog.rsid$V1,]$Z_Estimate.x,merge_cog2[merge_cog2$SNP %in% cog.rsid$V1,]$Z_Estimate.y,xlab="Cog GWAS hits",ylab="Cog GWAS hits in presence of small reverse causal effect")
