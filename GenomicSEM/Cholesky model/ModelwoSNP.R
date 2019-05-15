##################################################
## Project: CogNonCog 2018
## Script purpose: Run the GSEM model without SNPs
## https://github.com/MichelNivard/GenomicSEM/wiki/3.-Models-without-Individual-SNP-effects
## Date: March 2019
## Author: Perline Demange 
##################################################

require("GenomicSEM")
load(file="LDSCoutputCogNonCog.RData")

model<-'C=~NA*EA + start(0.4)*CP
NC=~NA*EA
NC~~1*NC
C~~1*C
C~~0*NC
CP ~~ 0*EA
CP~~0*CP
EA~~0*EA'

output<-usermodel(LDSCoutput,estimation="DWLS",model=model)
output
save(output, file="Modeloutput_with23andMe.Rdata" )

