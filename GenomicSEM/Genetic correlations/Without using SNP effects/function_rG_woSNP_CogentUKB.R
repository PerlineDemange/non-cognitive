

LDSCoutput_rG_woSNP <- function(data1, data2, data3, data4, sample.prev_trait, population.prev_trait, trait.name){
  
  traits <- c(data1, data2, data3, data4)
  sample.prev <- c(NA,NA,NA,sample.prev_trait) 
  population.prev <- c(NA,NA,NA,population.prev_trait) 
  ld<-"eur_w_ld_chr/"
  wld <- "eur_w_ld_chr/"
  trait.names<-c("CP_Cogent","CP_UKB", "EA", "T")
  LDSCoutput<- ldsc(traits, sample.prev, population.prev, ld, wld, trait.names=c("CP_Cogent","CP_UKB", "EA", "T"))
  
  modelrg<-'C=~NA*EA + start(0.4)*CP_Cogent + start(0.4)*CP_UKB
  NC=~NA*EA
  LT=~NA*T
  NC~~1*NC
  C~~1*C
  LT~~1*LT
  CP_Cogent~~0*CP_Cogent
  CP_UKB~~0*CP_UKB
  EA~~0*EA
  T~~0*T
  C~~0*NC
  CP_Cogent~~0*EA
  CP_UKB~~0*EA
  CP_Cogent~~0*T
  CP_UKB~~0*T
  EA~~0*T
  '
  output<-usermodel(LDSCoutput,estimation="DWLS",model=modelrg)
  saveRDS(output, file=paste(trait.name, '.Rda', sep=''))

  cog <- output$results[6,] #line of the results for the C~~LT
  noncog <- output$results[7,] #line of the results for the NC~~LT
  results <- cbind(trait.name, cog, noncog)
  results
}
