##################################################
## Project: CogNonCog 2018
## Script purpose: Compare the MAGMA results with the results from LDSC 
## Date: February 2019
## Author: Perline Demange 
##################################################
rm(list=ls())
library(data.table)
library(ggplot2)
setwd("C:/Users/PDE430/Documents/CogNonCog/Analyses/Annotations/")

MAGMA <- read.table("C:/Users/PDE430/Documents/CogNonCog/Analyses/Annotations/MAGMA/23andMe/Results_MAGMA_annotation_CogNonCog_23andMe_pvalcor.txt")
LDSC <- read.table("C:/Users/PDE430/Documents/CogNonCog/Analyses/Annotations/LDSC/23andMe/Results_LDSC_annotation_CogNonCog_23andMe.txt")
both_annot <- merge(MAGMA, LDSC, by.x="VARIABLE", by.y="ClusterName", suffixes=c(".MAGMA", ".LDSC")) 


### Pearson rank correlation of MAGMA and LDSC estimates ###
##############################################################
ggplot(both_annot, aes(x=BETA.Cog, y=Coefficient.Cog)) + 
  geom_point(size=3) + labs(x= "MAGMA beta", y="LDSC Coef")
cor.test(both_annot$BETA.Cog, both_annot$Coefficient.Cog, method="spearman")

ggplot(both_annot, aes(x=z.Cog, y=Coefficient_z.score.Cog)) + 
  geom_point(size=3) + labs(x= "MAGMA z score", y="LDSC Coef z score")
cor.test(both_annot$z.Cog, both_annot$Coefficient_z.score.Cog, method="spearman")

ggplot(both_annot, aes(x=BETA.Noncog, y=Coefficient.Noncog)) + 
  geom_point(size=3) + labs(x= "MAGMA beta", y="LDSC Coef")
cor.test(both_annot$BETA.Noncog, both_annot$Coefficient.Noncog, method="spearman")

ggplot(both_annot, aes(x=z.Noncog, y=Coefficient_z.score.Noncog)) + 
  geom_point(size=3) + labs(x= "MAGMA z score", y="LDSC Coef z score")
cor.test(both_annot$z.Noncog, both_annot$Coefficient_z.score.Noncog, method="spearman")

### Comparison pvalues similarly as Bryois et al. ##
####################################################

# Spearman rank correlation of "the strength of association" (-log10P) of MAGMA estimate and LDSC Enrichment estimates
both_annot$P.Cog.log <- -log10(both_annot$P.Cog)
both_annot$Enrichment_p.Cog.log <- -log10(both_annot$Enrichment_p.Cog)

ggplot(both_annot, aes(x=P.Cog.log, y=Enrichment_p.Cog.log)) + 
  geom_point(size=3) + labs(x= "MAGMA pval log", y="LDSC Enrichment pval log")
cor.test(both_annot$P.Cog.log, both_annot$Enrichment_p.Cog.log, method="spearman")


both_annot$P.Noncog.log <- -log10(both_annot$P.Noncog)
both_annot$Enrichment_p.Noncog.log <- -log10(both_annot$Enrichment_p.Noncog)

ggplot(both_annot, aes(x=P.Noncog.log, y=Enrichment_p.Noncog.log)) + 
  geom_point(size=3) + labs(x= "MAGMA pval log", y="LDSC Enrichment pval log")
cor.test(both_annot$P.Noncog.log, both_annot$Enrichment_p.Noncog.log, method="spearman")


