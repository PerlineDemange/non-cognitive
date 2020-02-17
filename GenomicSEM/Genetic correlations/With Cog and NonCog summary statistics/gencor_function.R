##################################################
## Project: CogNonCog 2018
## Script purpose: Function to run the genetic correlations with Genomic SEM, adapted from the file GenCor_GenSEM_function.R
## Date: December 2018
## Author: Perline Demange 
##################################################


CogNoncog_gen_correlation <- function(data1, data2, data3, sample.prev_trait, population.prev_trait, trait.name){
  
  traits <- c(data1, data2, data3)
  sample.prev <- c(NA,NA,sample.prev_trait) 
  population.prev <- c(NA,NA,population.prev_trait) 
  ld<-"eur_w_ld_chr/"
  wld <- "eur_w_ld_chr/"
  trait.names<-c("C", "NC", "T")
  LDSCoutput<- ldsc(traits, sample.prev, population.prev, ld, wld, trait.names=c("C", "NC", "T"))
  
  model_stand_uncons <- 'LC =~ NA*C + start(0.2)*C
  LNC =~ NA*NC + start(0.2)*NC
  LT =~ NA*T + start(0.3)*T
  LC ~~ 1*LC
  LNC ~~ 1*LNC 
  LT ~~ 1*LT
  NC ~~ 0*NC
  C ~~ 0*C
  T ~~ 0*T
  LC ~~ LNC
  LC ~~ LT
  LNC ~~ LT
  '
  outputT_stand_uncons <- usermodel(LDSCoutput,estimation="DWLS", model=model_stand_uncons)
  
  
  model_stand_cons <- 'LC =~ NA*C + start(0.2)*C
  LNC =~ NA*NC + start(0.2)*NC
  LT =~ NA*T + start(0.3)*T
  LC ~~ 1*LC
  LNC ~~ 1*LNC 
  LT ~~ 1*LT
  NC ~~ 0*NC
  C ~~ 0*C
  T ~~ 0*T
  LC ~~ LNC
  LC ~~ d*LT
  LNC ~~ d*LT
  '
outputT_stand_cons <- usermodel(LDSCoutput,estimation="DWLS", model=model_stand_cons)

outputT_stand <- list("unconstrained" = outputT_stand_uncons, "constrained" = outputT_stand_cons)

cogT_uncons = outputT_stand_uncons$results[5,6]
noncogT_uncons= outputT_stand_uncons$results[6,6]

cogT_SE_uncons = outputT_stand_uncons$results[5,7]
noncogT_SE_uncons= outputT_stand_uncons$results[6,7]

cogT_cons = outputT_stand_cons$results[5,6]
noncogT_cons= outputT_stand_cons$results[6,6]

cogT_SE_cons = outputT_stand_cons$results[5,7]
noncogT_SE_cons= outputT_stand_cons$results[6,7]

T_chisquare = outputT_stand_cons$`modelfit`[1,1]
T_pval = outputT_stand_cons$`modelfit`[1,3]

results <- cbind(trait.name, cogT_uncons, cogT_SE_uncons, noncogT_uncons, noncogT_SE_uncons, T_chisquare, T_pval, cogT_cons, cogT_SE_cons, noncogT_cons, noncogT_SE_cons)
results
} 
