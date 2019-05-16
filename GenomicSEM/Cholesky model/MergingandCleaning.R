##################################################
## Project: CogNonCog 2018
## Script purpose: Join the output files of CogNonCog...sh together 
## Date: March 2019
## Author: Perline Demange 
##################################################

setwd("./output")
# Loading the files
cognitive1m <- readRDS(file = "cognitive1m.Rda")
cognitive2m <- readRDS(file = "cognitive2m.Rda")
cognitive3m <- readRDS(file = "cognitive3m.Rda")
cognitive4m <- readRDS(file = "cognitive4m.Rda")
cognitive5m <- readRDS(file = "cognitive5m.Rda")
cognitive6m <- readRDS(file = "cognitive6m.Rda")
cognitive7m <- readRDS(file = "cognitive7m.Rda")
cognitive8m <- readRDS(file = "cognitive8m.Rda")
noncog1m <- readRDS(file = "noncog1m.Rda")
noncog2m <- readRDS(file = "noncog2m.Rda")
noncog3m <- readRDS(file = "noncog3m.Rda")
noncog4m <- readRDS(file = "noncog4m.Rda")
noncog5m <- readRDS(file = "noncog5m.Rda")
noncog6m <- readRDS(file = "noncog6m.Rda")
noncog7m <- readRDS(file = "noncog7m.Rda")
noncog8m <- readRDS(file = "noncog8m.Rda")

# merging the files together # careful can not use this formula for other variable which name is contained in the previous variable...
mats <- grep(x = ls(pos = 1), pattern = "cognitive", value = TRUE)
cognitivetot <- do.call(rbind, mget(mats))
mats2 <- grep(x = ls(pos = 1), pattern = "noncog", value = TRUE)
noncogtot <- do.call(rbind, mget(mats2))

head(cognitivetot)
hist(cognitivetot$est, main = "cognitive", breaks = 100)
hist(noncogtot$est, main = "noncognitive", breaks = 100)
hist(cognitivetot$cog_CPest, main = "C_CP", breaks = 100)
hist(cognitivetot$cog_EAest, main = "C_EA", breaks = 100)
hist(cognitivetot$non_EAest, main = "NC_EA", breaks = 100)

#remove the files so it goes faster
rm(cognitive1m)
rm(cognitive2m)
rm(cognitive3m)
rm(cognitive4m)
rm(cognitive5m)
rm(cognitive6m)
rm(cognitive7m)
rm(cognitive8m)
rm(noncog1m)
rm(noncog2m)
rm(noncog3m)
rm(noncog4m)
rm(noncog5m)
rm(noncog6m)
rm(noncog7m)
rm(noncog8m)

### Quality checsk ###
# Removing Snps whose SE did not converge 
cognitivecor <- cognitivetot[complete.cases(as.numeric(cognitivetot$SE)), ]  #remove the SNPs that do not converge, SE can not be computed
noncogncor <- noncogtot[complete.cases(as.numeric(noncogtot$SE)), ]
nrow(cognitivetot)
nrow(cognitivecor)
hist(cognitivecor$est, main = "cognitive", breaks = 100)
hist(noncog$est, main = "noncognitive", breaks = 100)
rm(cognitivecor)
rm(noncogncor)
# Number of SNPs that did not compute? there is no SNPS for whicht the SE did not compute


cognitiveneg = cognitivetot[cognitivetot$cog_CPest < 0, ]
cognitiveneg2 = cognitivetot[cognitivetot$cog_EAest < 0, ]
cognitiveneg3 = cognitivetot[cognitivetot$non_EAest < 0, ]
nrow(cognitiveneg3)
# Number of SNPs with negative estimation? There is no SNPS for which the estimations of the loadings are negative 


### Get P value ###
# calculate the test statistic: z = Est/SE
cognitivetot$SE <- as.numeric(cognitivetot$SE)
cognitivetot$Z <- cognitivetot$est/cognitivetot$SE
cognitivetot$chisq <- cognitivetot$Z*cognitivetot$Z
mean(cognitivetot$chisq)
cognitivetot$P <- pchisq(cognitivetot$chisq, df = 1, lower = FALSE)

noncogtot$SE <- as.numeric(noncogtot$SE)
noncogtot$Z <- noncogtot$est/noncogtot$SE
noncogtot$chisq <- noncogtot$Z*noncogtot$Z
mean(noncogtot$chisq)
noncogtot$P <- pchisq(noncogtot$chisq, df = 1, lower = FALSE)

### Save data ###

save(cognitivetot, file = "Cognitive_GWAS_with23andMe.RData")
save(noncogtot, file = "Non_Cognitive_GWAS_with23andMe.RData")
#load("./output/Cognitive_GWAS_with23andMe.RData")
#load("./output/Non_Cognitive_GWAS_with23andMe.RData")

# Remove the warnings messages
head(cognitivetot)
head(cognitivetot[c(1:13,18:26)])
cognitivetot <- cognitivetot[c(1:13,18:26)]
head(noncogtot)
noncogtot <- noncogtot[c(1:13,18:26)]

# Save data to export
write.table(cognitivetot, file = "Cognitive_GWAS_with23andMe.txt", sep = "\t", quote = F, row.names = F)
write.table(noncogtot, file = "Non_Cognitive_GWAS_with23andMe.txt", sep = "\t", quote = F, row.names = F)

# Shorten the data, removes unnecessary columns
cognitive2 <- cognitivetot[, c("SNP", "CHR", "BP", "A1", "A2", "est", "SE", "Z", "P", "MAF")]
noncog2 <- noncogtot[, c("SNP", "CHR", "BP", "A1", "A2", "est", "SE", "Z", "P", "MAF")]
write.table(cognitive2, file = "Cognitive_GWAS_short_with23andMe.txt", sep = "\t", quote = F, row.names = F)
write.table(noncog2, file = "Non_Cognitive_GWAS_short_with23andMe.txt", sep = "\t", quote = F, row.names = F)

### Find independent signficant hits ###
# Use the file HowtoPruneforLD in unix 

## Nicer manhattan plot can also be done with the ManhattanPlot.R file ##
# Basics Manhattan plots
#library(qqman)
#jpeg('manhattan1-8Mcog.jpg', width = 1600, height = 700)
#manhattan(cognitivetot, chr = "CHR", bp = "BP", snp = "SNP", p = "P", main = "Manhattan plot cognitive, chi sq = 1.813")
#dev.off()
#jpeg('manhattan1-8Mnoncog.jpg', width = 1600, height = 700)
#manhattan(noncogtot, chr = "CHR", bp = "BP", snp = "SNP", p = "P", main = "Manhattan plot non-cognitive, chi sq = 1.473")
#dev.off()

# Manhattan plots with sig independent SNPS highlighted 
#Cog_sig_ind <- read.table(file="Cog_sig_independent_signals.txt", col.names = c("CHR:POS","P") )
#Non_Cog_sig_ind <- read.table(file="Non_Cog_sig_independent_signals.txt", col.names = c("CHR:POS","P") )
#cognitivetot$CHR.POS <- paste(cognitivetot$CHR, cognitivetot$BP, sep=":")
#noncogtot$CHR.POS <- paste(noncogtot$CHR, noncogtot$BP, sep=":")
#Cog_sig_ind <- as.vector(Cog_sig_ind$CHR.POS)
#Non_Cog_sig_ind <- as.vector(Non_Cog_sig_ind$CHR.POS)

#jpeg('manhattan_cog_highlight.jpg', width = 1600, height = 700)
#manhattan(cognitivetot, chr = "CHR", bp = "BP", snp = "CHR.POS", p = "P", highlight= Cog_sig_ind, main = "Manhattan plot cognitive, chi sq = 1.813")
#dev.off()

#jpeg('manhattan_noncog_highlight.jpg', width = 1600, height = 700)
#manhattan(noncogtot, chr = "CHR", bp = "BP", snp = "CHR.POS", p = "P", highlight= Non_Cog_sig_ind, main = "Manhattan plot non-cognitive, chi sq = 1.473")
#dev.off()

