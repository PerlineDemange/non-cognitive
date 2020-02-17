# Function to calculate the genetic correlation with EA with Genomic SEM 

CogNoncog_gen_correlation_EA <- function(data1, data2, sample.prev_trait, population.prev_trait, trait.name){

traits <- c(data1, data2)
sample.prev <- c(NA,sample.prev_trait) 
population.prev <- c(NA,population.prev_trait) 
ld<-"eur_w_ld_chr/"
wld <- "eur_w_ld_chr/"
trait.names<-c("EA", "T")
LDSCoutput<- ldsc(traits, sample.prev, population.prev, ld, wld, trait.names=c("EA", "T"))

model_stand_uncons <- 'LEA =~ NA*EA + start(0.2)*EA
LT =~ NA*T + start(0.3)*T
LEA ~~ 1*LEA
LT ~~ 1*LT
EA ~~ 0*EA
T ~~ 0*T
LEA ~~ LT
'
outputEA_T <- usermodel(LDSCoutput,estimation="DWLS", model=model_stand_uncons)

EAT_est <- outputEA_T$results[3,6]
EAT_SE <- outputEA_T$results[3,7]
EAT_Z <- EAT_est/EAT_SE
EAT_P <- 2*pnorm(-abs(EAT_Z))  

results <- cbind(trait.name, EAT_est, EAT_SE, EAT_P)
results
} 