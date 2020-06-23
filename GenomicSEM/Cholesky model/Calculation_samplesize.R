##################################################
## Project: CogNonCog 2018
## Script purpose: 
## calculate the effective sample size of our GWAS, following Mallard et al. 2019
## Date: April 2019
## Author: Perline Demange 
##################################################

library(data.table)


cog <- fread("output/Cognitive_GWAS_with23andMe.txt", stringsAsFactors = F, data.table=F)
noncog <- fread("output/Non_Cognitive_GWAS_with23andMe.txt", stringsAsFactors = F, data.table = F)

head(cog)

# Because of the Cholesky model, we need to adjust with the residual heritabilities 
# (the estimates for the path loadings between the latent variable and the measured variable). 
# I use here the sqrt of the heritability(=path loadings) with 4 decimals, as reported in the preliminary figures. 

cog$Neff <- ((cog$Z/(cog$est*sqrt(0.1993)))^2)/(2*cog$MAF*(1-cog$MAF))   #0.446483*0.446483=0.1993
summary(cog$Neff)

# We apply a threshold for MAF as low and high MAF can bias the result. 
cog_maf_thresh <- cog[cog$MAF >= .10 & cog$MAF <= .40,]
cog_maf_thresh$N <- mean(cog_maf_thresh$Neff)
cog_maf_thresh$N <- floor(cog_maf_thresh$N)
summary(cog_maf_thresh$N)

noncog$Neff <- ((noncog$Z/(noncog$est*sqrt(0.0658)))^2)/(2*noncog$MAF*(1-noncog$MAF)) #0.256533*0.256533=0.0658
summary(noncog$Neff)
noncog_maf_thresh <- noncog[noncog$MAF >= .10 & noncog$MAF <= .40,]
noncog_maf_thresh$N <- mean(noncog_maf_thresh$Neff)
noncog_maf_thresh$N <- floor(noncog_maf_thresh$N)
summary(noncog_maf_thresh$N)


             