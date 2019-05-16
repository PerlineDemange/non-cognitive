##################################################
## Project: CogNonCog 2018
## Script purpose: R script to run the GenomicSEM for Multivariate GWAS in Lisa
##                 Follows https://github.com/MichelNivard/GenomicSEM/wiki/5.-User-Specified-Models-with-SNP-Effects
## Author: Perline Demange 
##################################################
### Genomic SEM installed on 26/03/2019 
### Compare to previous version, Genomic SEM has changed how the output of userGWAS, and this one has 2 more columns.. and addSNPS has an extra arg (parallel=F)


#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
beginsub = as.numeric(args[1])
endsub = as.numeric(args[2])
Namecog = as.character(args[3])
Namenoncog = as.character(args[4])
step=as.numeric(args[5])


#packages
library(devtools)
require(GenomicSEM)

#loading of the multivariable LDSC output and the prepared summary statistics
load(file="LDSCoutputCogNonCog.RData")
load(file="Sumstats.RData")

#combine both outputs
subset <- p_sumstats[beginsub:endsub,]
SNPcov<-addSNPs(LDSCoutput,subset)

#user model
model<-'C=~NA*EA +start(0.2)*EA + start(0.5)*CP
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

#Run the Genomic SEM GWAS
outputGWAS<-userGWAS(SNPcov,estimation="DWLS",model=model)# printwarn = FALSE

# Get two datasets with the loadings for the cognitive latente variable and the noncognitive latente variable
div = length(outputGWAS)%/%step
modulo = length(outputGWAS)%%step

if(modulo == 0){
  cognitive=as.data.frame(matrix(NA,ncol=17,nrow=length(outputGWAS)-modulo))
  noncog = cognitive
  C_EA = cognitive
  C_CP = cognitive
  NC_EA = cognitive
  colnames(cognitive)=colnames(outputGWAS[[1]])
  colnames(noncog)=colnames(outputGWAS[[1]])
  colnames(C_EA)=colnames(outputGWAS[[1]])
  colnames(C_CP)=colnames(outputGWAS[[1]])
  colnames(NC_EA)=colnames(outputGWAS[[1]])
  for(j in 0:(div-1)){
    working <- outputGWAS[(1:step) + j*step] #take step Snps step times 
    a <- (1:step) + j*step
    int1 <- as.data.frame(do.call(rbind,working))
    cognitive[min(a):max(a ),]<- int1[int1$free==4,]
    noncog[min(a):max(a ),]<- int1[int1$free==5,]
    C_EA[min(a):max(a ),]<- int1[int1$free==1,]
    C_CP[min(a):max(a ),]<- int1[int1$free==2,]
    NC_EA[min(a):max(a ),]<- int1[int1$free==3,]
    print(j)
  }
} else {
  d.frame <- as.data.frame(do.call(rbind,outputGWAS))
  cognitive<- d.frame[d.frame$free==4,]
  noncog <- d.frame[d.frame$free==5,]
  C_EA<- d.frame[d.frame$free==1,]
  C_CP<- d.frame[d.frame$free==2,]
  NC_EA<- d.frame[d.frame$free==3,]
}


#make 2 datasets
cognitive$cog_CPest <- C_CP$est
cognitive$cog_CPSE <- C_CP$SE
cognitive$cog_EAest <- C_EA$est 
cognitive$cog_EASE <- C_EA$SE 
cognitive$non_EAest <- NC_EA$est 
cognitive$non_EASE <- NC_EA$SE 

noncog$cog_CPest <- C_CP$est
noncog$cog_CPSE <- C_CP$SE
noncog$cog_EAest <- C_EA$est 
noncog$cog_EASE <- C_EA$SE 
noncog$non_EAest <- NC_EA$est 
noncog$non_EASE <- NC_EA$SE 

#save data 
saveRDS(cognitive, file=paste(Namecog, '.Rda', sep=''))
saveRDS(noncog, file=paste(Namenoncog, '.Rda', sep=''))