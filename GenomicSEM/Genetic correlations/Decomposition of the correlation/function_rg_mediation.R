##################################################
## Project: CogNonCog 2018
## Script purpose: Mediation analysis of the rG 
## Date: August 2019
## Author: Perline Demange 
##################################################

LDSCoutput_rG_mediation <- function(data1, data2, data3, sample.prev_trait, population.prev_trait, trait.name){

traits <- c(data1, data2, data3)
sample.prev <- c(NA,NA,sample.prev_trait) 
population.prev <- c(NA,NA,population.prev_trait) 
ld<-"/home/pdemange/CogNonCog/Genetic_Correlations/Input/eur_w_ld_chr/"
wld <- "/home/pdemange/CogNonCog/Genetic_Correlations/Input/eur_w_ld_chr/"
trait.names<-c("CP", "EA", "T")
LDSCoutput<- ldsc(traits, sample.prev, population.prev, ld, wld, trait.names=c("CP", "EA", "T"))

model<-'C=~NA*EA + start(0.4)*CP + a*EA
NC=~NA*EA + b*EA
LT=~NA*T + e*T
NC~~1*NC 
C~~1*C
LT~~1*LT
CP~~0*CP
EA~~0*EA
T~~0*T
C~~0*NC
CP~~0*EA
CP~~0*T
EA~~0*T
C~~c*LT
NC~~d*LT
EC:=a*c*e
ENC:=b*d*e
total:=a*c*e + b*d*e
'
output<-usermodel(LDSCoutput,estimation="DWLS",model=model)
saveRDS(output, file=paste(trait.name, '.Rda', sep=''))

cog <- output$results[7,] #line of the results for the  EC :=       a*c*e 
noncog <- output$results[8,] #line of the results for the  ENC :=       b*d*e 
total <- output$results[9,] #line of the results for total := a*c*e+b*d*e
results <- cbind(trait.name, cog, noncog, total)
results 
}