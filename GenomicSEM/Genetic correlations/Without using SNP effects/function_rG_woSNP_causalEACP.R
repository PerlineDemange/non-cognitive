LDSCoutput_rG_woSNP_causalEACP <- function(data1, data2, data3, sample.prev_trait, population.prev_trait, trait.name){
  
  traits <- c(data1, data2, data3)
  sample.prev <- c(NA,NA,sample.prev_trait) 
  population.prev <- c(NA,NA,population.prev_trait) 
  ld<-"eur_w_ld_chr/"
  wld <- "eur_w_ld_chr/"
  trait.names<-c("CP", "EA", "T")
  LDSCoutput<- ldsc(traits, sample.prev, population.prev, ld, wld, trait.names=c("CP", "EA", "T"))
  
  modelrg<-'C=~NA*EA +start(0.2)*EA + start(0.4)*CP
  NC=~NA*EA +start(0.2)*EA 
  LT=~NA*T
  NC~~1*NC
  C~~1*C
  LT~~1*LT
  C~~0*NC
  CP ~ 0.2*EA
  CP~~0*CP
  EA~~0*EA
  T~~0*T
  CP~~0*T
  EA~~0*T
  '
  
  output<-usermodel(LDSCoutput,estimation="DWLS",model=modelrg)
  saveRDS(output, file=paste(trait.name, '.Rda', sep=''))

  cog <- output$results[5,] #line of the results for the C~~LT
  noncog <- output$results[6,] #line of the results for the NC~~LT
  results <- cbind(trait.name, cog, noncog)
  results
}
